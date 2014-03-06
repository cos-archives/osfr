#' @param Takes a users project_id, e.g., osf_get_project_files("5ctke")
#' @return A data.frame of the files in the public project
#' @import RCurl rjson
#' @export

clean_download_url <- function(download_url){
    end <- substring(download_url, 1, nchar(download_url)-9)
#     return(paste0("https://osf.io/api/v1/project/", end))
    return(paste0("staging.openscienceframework.org/api/v1/project/", end))
}

osf_get_project_files <- function(project_id){
#     url <- gsub("project_id", project_id, "https://osf.io/api/v1/project/project_id/osffiles/r/")
    url <- gsub("project_id", project_id, "staging.openscienceframework.org/api/v1/project/project_id/osffiles/r/")
    returned <- getURL(url)
    json_data <- fromJSON(returned, method = "C", unexpected.escape = "error")
    
    df <- data.frame("file_name"=character(), "download_url"=character(), "versions"=numeric(), "date_modified"=character())
    for(file in json_data){
        df <- rbind(df, data.frame(
            "file_name" = file$name,
            "download_url" = clean_download_url(file$download),
            "versions" = length(file$versions),
            "date_modified" = file$date_modified
        ))
    }
    return(df)
}