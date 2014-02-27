\name{osf_find_user}
\alias{osf_find_user}
\title{Find OSF users via search}
\usage{
  osf_find_user(user_name)
}
\arguments{
\item{user_name}{name of user, i.e. 'John Smith'.}
}
\description{
  Get a data.frame of OSF users and user_urls
}
\examples{
\dontrun{
osf_find_user("Jane Smith")
}
}