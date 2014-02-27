# require(RCurl)
# require(rjson)

get_projects <- function(user_url, local=FALSE){
  url <- gsub("user_url", user_url, "https://osf.io/api/v1/profile/user_url/public_projects/")
  if(local==TRUE){
    url <- gsub("user_url", user_url, "localhost:5000/api/v1/profile/user_url/public_projects/")
  }
  
  json_data <- getURL(url)
  
  df <- data.frame("projects"=character())  #todo need to add name to OSF route, easy
  
  for(user_data in fromJSON(json_data, method = "C", unexpected.escape = "error" )$nodes){
    project_id <- user_data$id
    df <- rbind(df, data.frame("projects" = project_id))
  }
  
  return(df)
}
