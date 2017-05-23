#` DataBase Connector Functions
#'
#' This function allows you to access Databases.
#' @param pkg, 
#' @keywords package,
#' @export
#' @examples
#' usepkg()
  
  
  
usepkg <- function(pkg) {
    if (!base::is.element(pkg, utils::installed.packages()[,1]))
        utils::install.packages(pkg, dep = TRUE)
        base::require(pkg, character.only = TRUE)
}