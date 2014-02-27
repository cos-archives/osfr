# require(httr)
# require(RCurl)
# require(XML)
# require(stringr)
# require(gdata)
# require(tools)
# require(XLConnect)
# require(downloader)

## url to dataframe methods  

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
    ext <- file_ext(substr(url, 1, regexpr("\\/version/+\\d", url, ignore.case=TRUE)-1))
    if(is.element(ext, c("csv", "xls", "xlsx", "txt"))){
        return(get_list[[ext]](url))  
    }
    return("No method to read file")
}

url <- "https://osf.io/api/v1/project/5ctke/osffiles/something.xlsx/version/1/"
url <- "https://osf.io/api/v1/project/5ctke/osffiles/something.txt/version/1/"
url <- "https://osf.io/api/v1/project/5ctke/osffiles/asdfasd.csv/version/1/"

# 
# get_osf_file <- function(project_id, file_name, version_number, local=FALSE){    
#   url <-paste0("https:osf.io/api/v1/project/", project_id,"/osffiles/", file_name, "/version/", version_number,"/")
#   if(local==TRUE){
#     url <-paste0("localhost:5000/api/v1/project/", project_id,"/osffiles/", file_name, "/version/", version_number,"/")
#   }
#   osf_dat<- getURI(url)
#   return(osf_dat)
# }
# 
