\name{osf_get_file}
\alias{osf_get_file}
\title{Get data.frame of OSF data file}
\usage{
  osf_read(url)
}
\arguments{
  \item{download_url}{download_url from osf_get_files, i.e. 'https://osf.io/api/v1/project/5ctke/osffiles/something.xlsx/version/1/'.}
}
\description{
  Create a data.frame from a file on the OSF
}
\examples{
\dontrun{
osf_get_file("https://osf.io/api/v1/project/5ctke/osffiles/something.xlsx/version/1/")
}
}
