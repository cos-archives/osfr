#' @param Takes a user_id, e.g., osf_get_project_files("rnizy")
#' @return A data.frame of the public projects for a user
#' @import RCurl rjson
#' @export


osf_get_projects <- function(user_id){
    
    osf_url_base <- ifelse(is.null(got <- getOption('osf_url_base')), 'https://osf.io', got)    
    
    base_url <- paste0(osf_url_base, "/api/v1/profile/user_url/public_projects/")
    
    url <- gsub("user_url", user_id, base_url)
    
    returned <- getURL(url)
    json_data <- fromJSON(returned, method = "C", unexpected.escape = "error" )
    
    df <- do.call('rbind', lapply(json_data$nodes, function(projects){
        data.frame("project"=projects$id)
        }))   

    return(df)
}
