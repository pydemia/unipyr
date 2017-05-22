#` DataBase Connector Functions
#'
#' This function allows you to access Databases.
#' @param db db
#' @keywords db db
#' @export
#' @examples
#' dbStr()

dbStr <- function(){
    
    mariadb <- c("mariadb", "org.mariadb.jdbc.Driver", "jdbc:mariadb://%s:%s", "3306")
    mysql <- c("mysql", "org.mysql.jdbc.Driver", "jdbc:mysql://%s:%s", "3306")
    postgresql <- c("postgresql", "org.postgresql.Driver", "jdbc:postgresql://%s:%s","5432")
    ibmdb2 <- c("ibmdb2", "com.ibm.db2.jcc.DB2Driver", "jdbc:db2://%s:%s", "50000")
    oracle <- c("oracle", "oracle.jdbc.OracleDriver", "jdbc:oracle:thin:@//%s:%s", "1521")
    dbStrDF <- t(data.frame(mariadb, mysql, postgresql, ibmdb2, oracle))
    colnames(dbStrDF) <- c("dbname", "classPath", "url", "port")
    
    return(dbStrDF)
    
}