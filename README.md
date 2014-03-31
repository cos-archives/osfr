## WARNING: THIS PACKAGE IS FOR TESTING ONLY; OSF API AND THIS R INTERFACE ARE IN A STATE OF FLUX

**osfr** is an R package that enables API access to the Open Science Framework, namely access to public projects and their files through R.

This code is not yet ready to be used beyond trying it out, long term support of functions cannot be guaranteed.

Currently requires use of our staging server--nothing there is permanent although it may seem to be consitent with osf.io--it is not: `options("osf_url_base"="staging.openscienceframework.org")` 

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
 
## examples
### find a user

Search terms must be exact (e.g., 'Alex Schill' will not find 'Alex Schiller' nor 'Alexander Schiller')

```bash
require(osfr)

users <- osf_find_user('Alex Schiller')

>      user_name user_id
>1 Alex Schiller    rnizy
```
Select the right Alex Schiller (there is only one right now) and store it

**NOTE** that the order of the users data.frame is mutable and will change if another "Alex Schiller" makes an account
```
user_id <- users[1,]$user_id
> [1] rnizy
```

### get a user's projects from their user_id

```
projects <- osf_get_projects('rnizy')

>   project
>1    jusue
>2    5ctke
>3    mv8pj
>4    4znzp
```
Select the right project_id and store it

**NOTE** that the order of this list is also mutable
```
project_id <- projects[2,]$project
> [1] 5ctke
```
### get a project's files

```
files <- osf_get_project_files(project)

>  project_id      file_name versions       date_modified      size
>1      5ctke something.xlsx        2 2014/03/08 04:02 PM     28 KB
>2      5ctke   Untitled.png        1 2013/12/11 04:56 PM     32 KB
...
>7      5ctke     backup.png        1 2014/02/18 02:21 PM     16 KB
>8      5ctke    asdfasd.csv        1 2014/02/11 04:17 PM 397 bytes
```
Select the file line you want and store it
```
file_info <- files[8,]
>  project_id   file_name versions       date_modified      size
>8      5ctke asdfasd.csv        1 2014/02/11 04:17 PM 397 bytes
```
### read a file into R from the file_info

**NOTE** this method of reading is mutable and will read the *most recent version* of a file. If you want a specific version see below
```
dat <- read.osf(file_info)

> A B C D
> 1 1 2 3 4
> 2 2 3 4 5
> 3 3 4 5 6
> 4 4 5 6 7
> 5 5 6 7 8
> 6 6 7 8 9
```
### read a specific version of a file

Specify the project_id, file_name, and version:
```
dat <- read.osf(project_id, "something.xlsx", "1")
```
By explicitly assigning we can ensure that we have version 1 of something.xlsx instead of version 2
