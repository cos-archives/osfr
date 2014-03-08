#' @param Takes file download_url to a datafile, e.g., osf_get_file("https://osf.io/api/v1/project/5ctke/osffiles/something.xlsx/version/1/")
#' @return A data.frame of the data
#' @import httr RCurl XML stringr tools XLConnect downloader
#' @export

# url to dataframe methods  

get_xls_xlsx <- function(url){ 
    local.file = tempfile() 
    download(url, local.file) 
    wb = loadWorkbook(local.file, create=F) 
    readWorksheet(wb, sheet=1) 
}

get_csv <- function(url){
    return(read.csv(text=getURL(url)))
}

get_txt <- function(url){
    return(read.table(text=getURL(url), header=T, sep ="\t"))
}

# ext to method
get_list <- list(
    "xls" = get_xls_xlsx,
    "xlsx" = get_xls_xlsx,
    "csv" = get_csv,
    "txt" = get_txt
    )

osf_read <- function(df_or_project_id, file_name="", version="" ){

    if(file_name==""){
        project_id<-df_or_project_id$project_id
        file_name<-df_or_project_id$file_name
        version<-df_or_project_id$versions
    }else{
        project_id<-df_or_project_id
    }

    url <- paste0("https://","osf.io/api/v1/project/", project_id, "/osffiles/", file_name,"/version/", version, "/")
    ext <- file_ext(file_name)

    if(
      is.element(ext, c("csv", "xls", "xlsx", "txt"))
      ){
        return(get_list[[ext]](url))  
    }
    return("No method to read file")
}

read.osf <- osf_read
