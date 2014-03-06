\name{osf_read}
\alias{osf_read}
\title{Get data.frame of OSF data file}
\usage{
  osf_read(url)
}
\arguments{
  \item{download_url}{download_url from read_osf, i.e. 'https://osf.io/api/v1/project/5ctke/osffiles/something.xlsx/version/1/'.}
}
\description{
  Create a data.frame from a file on the OSF
}
\examples{
\dontrun{
read_osf("https://osf.io/api/v1/project/5ctke/osffiles/something.xlsx/version/1/")
}
}
