\name{osf_get_project_files}
\alias{osf_get_project_files}
\title{Get a list of files from a public project}
\usage{
  osf_get_project_files(project_id)
}
\arguments{
  \item{project_id}{id of a public project, i.e. '5ctke'.}
}
\value{
  A URL for dataset for the Dryad id.
}
\description{
  Get a data.frame of files from a public project
}
\examples{
\dontrun{
osf_get_project_files(5ctke)
}
}
