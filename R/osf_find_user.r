#' @import RCurl rjson
#' @export

osf_find_user <- function(user_name, local=FALSE){
  search_term <- "https://osf.io/api/v1/search/?q=user:"  
  if(local==TRUE){
    search_term <- "localhost:5000/api/v1/search/?q=user:"  
  }
  name <- c(strsplit(user_name," ")) 
  enumerate <- 1
  len <- length(name[[1]])
  
  while(enumerate <= len){
    if(enumerate == len){
      search_term <- paste0(search_term, name[[1]][enumerate])  
    }else{
      search_term <- paste0(search_term, name[[1]][enumerate], "+AND+user:")
    }
    enumerate <- enumerate + 1
  }
  
  json_data <- getURL(search_term)
  
  df <- data.frame("user"=character(), "user_url"=character())  
  
  for(user_data in fromJSON(json_data, method = "C", unexpected.escape = "error" )$results){
    user <- user_data$user
    user_url <- substring(user_data$user_url,10) # cuts out "/profile/"
    df <- rbind(df, data.frame("user" = user, "user_url" = user_url))
  }
  return(df)
}
