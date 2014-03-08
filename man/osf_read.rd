\name{osf_read}
\alias{osf_read}
\title{Read osf file}
\usage{
  osf_read("file_info")
  osf_read("project_id", "file_name", "version")
}
\arguments{
  \item{df_or_project_id}{df line from osf_get_project_files or project_id}
  \item{file_name}{if a project_id was specified, a file_name from the osf_get_project_files is required}
  \item{version}{if a project_id was specified, a version from the osf_get_project_files is required}
}

\description{
  Create a data.frame from a file on the OSF
}
\examples{
\dontrun{
read_osf("https://osf.io/api/v1/project/5ctke/osffiles/something.xlsx/version/1/")
}
}
