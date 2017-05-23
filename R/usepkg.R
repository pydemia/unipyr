#` DataBase Connector Functions
#'
#' This function allows you to access Databases.
#' @param pkg, 
#' @keywords package,
#' @export
#' @examples
#' usepkg()
  
  
  
usepkg <- function(pkg) {
    if (!is.element(pkg, installed.packages()[,1]))
        install.packages(pkg, dep = TRUE)
        require(pkg, character.only = TRUE)
}