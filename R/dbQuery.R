#` DataBase Connector Functions
#'
#' This function allows you to access Databases.
#' @param db(dbname, jdbcDriverPath, url, port), query, username, password
#' @keywords db(dbname, jdbcDriverPath, url, port), query, username, password
#' @export
#' @examples
#' dbQuery()


dbQuery <- function(db = c(type="dbname", driver="jdbcDriverPath", url="url", port="port"), query = NULL, username, password){
    
    mariadb <- c("mariadb", "org.mariadb.jdbc.Driver", "jdbc:mariadb://%s:%s", "3306")
    mysql <- c("mysql", "org.mysql.jdbc.Driver", "jdbc:mysql://%s:%s", "3306")
    postgresql <- c("postgresql", "org.postgresql.Driver", "jdbc:postgresql://%s:%s","5432")
    ibmdb2 <- c("ibmdb2", "com.ibm.db2.jcc.DB2Driver", "jdbc:db2://%s:%s", "50000")
    oracle <- c("oracle", "oracle.jdbc.OracleDriver", "jdbc:oracle:thin:@//%s:%s", "1521")
    dbStrDF <- t(data.frame(mariadb, mysql, postgresql, ibmdb2, oracle))
    colnames(dbStrDF) <- c("dbname", "classPath", "url", "port")


    dbname <- db[1]
    jdbcPath <- db[2]
    dburl <- db[3]
    dbport <- db[4]
    
    if (dbname %in% rownames(dbStrDF)){
        classPath <- dbStrDF[dbname, 'classPath']
        url <- dbStrDF[dbname, 'url']
        
    } else {
        print("DB type not prepared")
        break
    }
    connURL <- sprintf(url, dburl, dbport)
    
    drv <- RJDBC::JDBC(classPath, jdbcPath)
    conn <- RJDBC::dbConnect(drv, connURL, username, password)
    res <- RJDBC::dbGetQuery(conn, query)
    
    RJDBC::dbDisconnect(conn)
    print(head(res))
    
    return(res)
}