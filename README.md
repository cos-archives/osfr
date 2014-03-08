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

