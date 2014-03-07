#' @param Takes a users project_id, e.g., osf_get_project_files("5ctke")
#' @return A data.frame of the files in the public project
#' @import RCurl rjson
#' @export

osf_url_base <- ifelse(is.null(got <- getOption('osf_url_base')), 'https://osf.io', got)

clean_download_url <- function(download_url){
    end <- substring(download_url, 1, nchar(download_url)-9)
    return(paste0(osf_url_base, "/project/", end))
}

osf_get_project_files <- function(project_id){
    print(osf_url_base)
    print(getOption('osf_url_base'))
    print(options())
    
    base_url <- paste0(osf_url_base, "/api/v1/project/project_id/osffiles/")
    url <- gsub("project_id", project_id, base_url)
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
