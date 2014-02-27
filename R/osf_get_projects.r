#' @param Takes a user_id, e.g., osf_get_project_files("rnizy")
#' @return A data.frame of the public projects for a user
#' @import RCurl rjson
#' @export

osf_get_projects <- function(user_url, local=FALSE){
    url <- gsub("user_url", user_url, "https://osf.io/api/v1/profile/user_url/public_projects/")
    
    ##### For testing purposes ##### RM for production
    if(local==TRUE){
        url <- gsub("user_url", user_url, "localhost:5000/api/v1/profile/user_url/public_projects/")
    }
    
    json_data <- getURL(url)
    json_data <- fromJSON(json_data, method = "C", unexpected.escape = "error" )$nodes
    
    df <- data.frame("projects"=character())  #todo need to add name to OSF route, easy
    
    for(user_data in json_data){
        project_id <- user_data$id
        df <- rbind(df, data.frame("projects" = project_id))
    }
    
    return(df)
}
