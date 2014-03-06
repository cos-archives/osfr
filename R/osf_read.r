#' @param Takes file download_url to a datafile, e.g., osf_get_file("https://osf.io/api/v1/project/5ctke/osffiles/something.xlsx/version/1/")
#' @return A data.frame of the data
#' @import httr RCurl XML stringr gdata tools XLConnect downloader
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

osf_get_file <- function(url){
    url = paste0("http://", url) ## TEMP ## getURL requires at least http, Remove for production
    ext <- file_ext(
        substr(url, 1, regexpr("\\/version/+\\d", url, ignore.case=TRUE)-1)
        )
    if(
      is.element(ext, c("csv", "xls", "xlsx", "txt"))
      ){
        return(get_list[[ext]](url))  
    }
    return("No method to read file")
}
