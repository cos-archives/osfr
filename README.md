rosf
====

rosf is an R package that enables API access to the Open Science Framework

Enables access to public projects and their files through R.

functions:
- osf_find_user - takes a username and returns a dataframe of users and their user_urls
- osf_get_projects - takes a user_url and returns a list of their public projects
- osf_get_project_files - takes a project_id and returns a list of files and their download_urls
- osf_get_file - takes a download_url for a data file and reads it into a data.frame
