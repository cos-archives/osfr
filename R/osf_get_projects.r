#' @param Takes a user_id, e.g., osf_get_project_files("rnizy")
#' @return A data.frame of the public projects for a user
#' @import RCurl rjson
#' @export

osf_get_projects <- function(user_url){
#     url <- gsub("user_url", user_url, "https://osf.io/api/v1/profile/user_url/public_projects/")
    url <- gsub("user_url", user_url, "https://staging.openscienceframework.org/api/v1/profile/user_url/public_projects/")
    returned <- getURL(url)
    json_data <- fromJSON(returned, method = "C", unexpected.escape = "error" )
    
    df <- data.frame("projects"=character())  #todo need to add name to OSF route, easy
    
    for(user_data in json_data$nodes){
        project_id <- user_data$id
        df <- rbind(df, data.frame("projects" = project_id))
    }
    return(df)
}

