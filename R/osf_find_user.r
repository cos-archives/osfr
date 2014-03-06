#' @param id Name of person searching for e.g., osf_find_user("John Smith")
#' @return A data.frame of user_names and user_urls 
#' @import RCurl rjson
#' @export


build_search_term <- function(user_name){
    search_term <- "https://osf.io/api/v1/search/?q=user:"  
    name <- strsplit(user_name," ")
    enumerate <- 1
    len <- length(name[[1]])
    
    while(enumerate <= len){
        if(enumerate == len){
            search_term <- paste0(search_term, name[[1]][enumerate])  
        }
        else{
            search_term <- paste0(search_term, name[[1]][enumerate], "+AND+user:")  
        }
        enumerate <- enumerate + 1
    }
    return(search_term)
}


osf_find_user <- function(user_name){
    
    json_data <- getURL(build_search_term(user_name, local))
    json_data <- fromJSON(json_data, method = "C", unexpected.escape = "error" )
    
    df <- data.frame("user_name"=character(), "user_url"=character())  
    
    for(user_data in json_data$results){
        user_name <- user_data$user
        user_url <- substring(user_data$user_url, 10) # cuts out "/profile/"
        df <- rbind(df, data.frame("user_name" = user_name, "user_url" = user_url))
    }
    
    return(df)
}
