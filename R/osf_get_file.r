#' @param Takes file download_url to a datafile, e.g., osf_get_file("https://osf.io/api/v1/project/5ctke/osffiles/something.xlsx/version/1/")
#' @return A data.frame of the data
#' @import httr RCurl XML stringr gdata tools XLConnect downloader
#' @export

# url to dataframe methods  

_get_xls_xlsx <- function(url){ 
    local.file = tempfile() 
    download(url, local.file) 
    wb = loadWorkbook(local.file, create=F) 
    readWorksheet(wb, sheet=1) 
}

_get_csv <- function(url){
    return(read.csv(text=getURL(url)))
}

_get_txt <- function(url){
    return(read.table(text=getURL(url), header=T, sep ="\t"))
}

# ext to method

_get_list <- list(
    "xls" = _get_xls_xlsx,
    "xlsx" = _get_xls_xlsx,
    "csv" = _get_csv,
    "txt" = _get_txt
    )


osf_get_file <- function(url){
    ext <- file_ext(substr(url, 1, regexpr("\\/version/+\\d", url, ignore.case=TRUE)-1))
    if(is.element(ext, c("csv", "xls", "xlsx", "txt"))){
        return(_get_list[[ext]](url))  
    }
    return("No method to read file")
}
