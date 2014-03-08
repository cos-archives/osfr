#' @param Takes a users project_id, e.g., osf_get_project_files("5ctke")
#' @return A data.frame of the files in the public project
#' @import RCurl rjson
#' @export

options("osf_url_base"="http://staging.openscienceframework.org/")
getOption("osf_url_base")

osf_get_project_files <- function(project_id){
    
    osf_url_base <- ifelse(is.null(got <- getOption('osf_url_base')), 'https://osf.io', got)
    base_url <- paste0(osf_url_base, "/api/v1/project/project_id/osffiles/")
    
    url <- gsub("project_id", project_id, base_url)
    
    returned <- getURL(url)
    json_data <- fromJSON(returned, method = "C", unexpected.escape = "error")

    df <- do.call('rbind', lapply(json_data, function(project_data){
        data.frame(
            "project_id"=project_id,
            "file_name"=project_data$name,
            "versions"=length(project_data$versions),
            "date_modified"=project_data$date_modified,
            "size"=project_data$size
        )
    }))
    
    return(df)
}
