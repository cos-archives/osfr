# require(RCurl)
# require(rjson)
#' @export

osf_get_project_files <- function(project_id, local=FALSE){
    url <- gsub("project_id", project_id, "https://osf.io/api/v1/project/project_id/osffiles/r/")
    if(local==T){
        url <- gsub("project_id", project_id, "localhost:5000/api/v1/project/project_id/osffiles/r/")
    }
  
    json_data <- getURL(url)
  
    df <- data.frame("file_name"=character(), "download_url"=character(), "versions"=numeric(), "date_modified"=character())
    
    for(file in fromJSON(json_data, method = "C", unexpected.escape = "error")){
        df <- rbind(df, data.frame(
        "file_name"=file$name,
        "download_url"=file$download,
        "versions"=length(file$versions),
        "date_modified"=file$date_modified
    ))
    }
    
    return(df)
}
