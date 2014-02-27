#' @param Takes a users project_id, e.g., osf_get_project_files("5ctke")
#' @return A data.frame of the files in the public project
#' @import RCurl rjson
#' @export

osf_get_project_files <- function(project_id, local=FALSE){
    url <- gsub("project_id", project_id, "https://osf.io/api/v1/project/project_id/osffiles/r/")
    
    ##### For testing purposes ##### RM for production
    if(local==TRUE){
        url <- gsub("project_id", project_id, "localhost:5000/api/v1/project/project_id/osffiles/r/")
    }
  
    json_data <- getURL(url)
    json_data <- fromJSON(json_data, method = "C", unexpected.escape = "error")
    df <- data.frame("file_name"=character(), "download_url"=character(), "versions"=numeric(), "date_modified"=character())
    for(file in json_data){
        df <- rbind(df, data.frame(
            "file_name" = file$name,
            "download_url" = file$download,
            "versions" = length( file$versions ),
            "date_modified" = file$date_modified
        ))
    }
    return(df)
}