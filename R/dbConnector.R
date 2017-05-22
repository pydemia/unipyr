#` DataBase Connector Functions
#`
#`


mdbQuery <- function(query = NULL, username, password){
    
    require(RJDBC)
    
    drv <- RJDBC::JDBC("org.mariadb.jdbc.Driver", "~/jdbcDriver/mariadb-java-client-1.5.6.jar") 
    conn <- RJDBC::dbConnect(drv, "jdbc:mariadb://windows.pydemia.org:3306", username, password)
    res <- RJDBC::dbGetQuery(conn, query)
    print(res)
    return(res)
}