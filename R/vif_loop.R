#` DataBase Connector Functions
#'
#' This function allows you to access Databases.
#' @param pkg, 
#' @keywords package,
#' @export
#' @examples
#` importFrom("stats", "formula", "lm")
#` importFrom("utils", "flush.console", "install.packages", "installed.packages")
#' vif_loop(in_frame,thresh=10, trace=F, ...)
  
  
  
vif_loop <- function(in_frame,thresh=10, trace=F, ...){
    

    if(class(in_frame) != 'data.frame') in_frame<-data.frame(in_frame)

        #get initial vif value for all comparisons of variables
        vif_init<-vector('list', length = ncol(in_frame))
        names(vif_init) <- names(in_frame)
        var_names <- names(in_frame)

        for(val in var_names){
            regressors <- var_names[-which(var_names == val)]
            form <- paste(regressors, collapse = '+')
            form_in <- stats::formula(paste(val,' ~ .'))
            vif_init[[val]]<- fmsb::VIF(stats::lm(form_in,data=in_frame,...))
        }
        vif_max<-max(unlist(vif_init))

        if(vif_max < thresh){
            if(trace==T){ #print output of each iteration
                prmatrix(vif_init,collab=c('var','vif'),rowlab=rep('', times = nrow(vif_init) ),quote=F)
                cat('\n')
                cat(paste('All variables have VIF < ', thresh,', max VIF ',round(vif_max,2), sep=''),'\n\n')
            }
            return(names(in_frame))
        }
        else {

            in_dat<-in_frame

            #backwards selection of explanatory variables, stops when all VIF values are below 'thresh'
            while(vif_max >= thresh){

                vif_vals <- vector('list', length = ncol(in_dat))
                names(vif_vals) <- names(in_dat)
                var_names <- names(in_dat)

                for(val in var_names){
                    regressors <- var_names[-which(var_names == val)]
                    form <- paste(regressors, collapse = '+')
                    form_in <- stats::formula(paste(val,' ~ .'))
                    vif_add <- fmsb::VIF(stats::lm(form_in,data=in_dat,...))
                    vif_vals[[val]] <- vif_add
                }

                max_row<-which.max(vif_vals)
                #max_row <- which( as.vector(vif_vals) == max(as.vector(vif_vals)) )

                vif_max<-vif_vals[max_row]

                if(vif_max<thresh) break

                    if(trace==T){ #print output of each iteration
                        vif_vals <- do.call('rbind', vif_vals)
                        vif_vals
                        prmatrix(vif_vals,collab='vif',rowlab=row.names(vif_vals),quote=F)
                        cat('\n')
                        cat('removed: ', names(vif_max),unlist(vif_max),'\n\n')
                        utils::flush.console()
                    }

                    in_dat<-in_dat[,!names(in_dat) %in% names(vif_max)]

                    }

                return(names(in_dat))

            }

}