\name{read.osf}
\alias{read.osf}
\title{Get data.frame of OSF data file}
\usage{read.osf("download_url")}
\arguments{
    \item{download_url}{download_url from read.osf, i.e. 'https://osf.io/api/v1/project/5ctke/osffiles/something.xlsx/version/1/'.}}
\description{Create a data.frame from a file on the OSF}
\examples{
    \dontrun{read.osf("https://osf.io/api/v1/project/5ctke/osffiles/something.xlsx/version/1/")}
}
