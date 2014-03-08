**osfr** is an R package that enables API access to the Open Science Framework, namely access to public projects and their files through R.

## WARNING: INTERFACE IS NOT FINISHED

This code is not yet ready to be used beyond trying it out, long term support of functions cannot be guaranteed.

Currently requires `options("osf_url_base"="staging.openscienceframework.org")` to be set to run.

##install

```bash
if(!require("devtools")){
    install.packages("devtools")
    require("devtools")
}
install_git("https://github.com/CenterForOpenScience/osfr.git")
```

##functions

- `osf_find_user` - takes a username and returns a dataframe of users and their user_urls
- `osf_get_projects` - takes a user_url and returns a list of their public projects
- `osf_get_project_files` - takes a project_id and returns a list of files and their download_urls
- `osf_read` or `read.osf` - takes a download_url for a data file and reads it into a data.frame

## workflow
Person's Name   Person's url Project url  File download url                                                   output
"Alex Schiller" -> "rnizy" -> "5ctke" -> "https://"osf.io/api/v1/project/5ctke/osffiles/this.csv/version/1/" -> data
## examples

Find a user's url from their name (search terms must be exact)

```bash
require(osfr)

osf_find_user('Alex Schiller')

>      user_name user_url
>1 Alex Schiller    rnizy
```

Get a user's public projects from their user_url

```
osf_get_projects('rnizy')

>  projects
>1    jusue
>2    5ctke
>3    mv8pj
>4    4znzp
```
Get a project's files from a project_url

```
osf_get_project_files('5ctke')

>   file_name       download_url                                                      versions  date_modified
>1  something.xlsx  https://osf.io/project//5ctke/osffiles/something.xlsx/version/1/  1         2014/02/25 08:37 PM
>2  Untitled.png    https://osf.io/project//5ctke/osffiles/Untitled.png/version/1/    1         2013/12/11 04:56 PM
>3  something.xls   https://"osf.io/api/v1/project/5ctke/osffiles/this.csv/version/1/ 1         2014/02/25 05:24 PM
```

Read a file into R from the file's download url

```
dat <- read.osf("https://"osf.io/api/v1/project/5ctke/osffiles/this.csv/version/1/")

head(dat)

> A B C D
> 1 1 2 3 4
> 2 2 3 4 5
> 3 3 4 5 6
> 4 4 5 6 7
> 5 5 6 7 8
> 6 6 7 8 9
```
