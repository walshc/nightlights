\name{downloadNightLights}
\alias{downloadNightLights}
\title{Download Night Lights data from NOAA}
\description{Download night lights data from NOAA for specific years.}
\usage{
downloadNightLights(years, extract = TRUE, directory = NULL,
                    download.method = NULL, ...)
}
\arguments{
\item{years}{The years of data to download, e.g. \code{2000:2002} or
  \code{c(1992, 2002, 2012)}. The available years are 1992-2013.}
\item{extract}{(Logical) Should the downloaded files be extracted from the
  tarballs? Default is \code{TRUE}.}
\item{directory}{The directory to save the files to. If omitted, it saves to
  the current directory. If the directory does not yet exist, it will be
  created.}
\item{download.method}{Method to use in the \code{download.file} button. If not
  specified it will use \code{internal} on Windows and \code{wget}
  otherwise. Extra arguments can also be passed to the \code{download.file} function such as \code{extra} when needed.}
}
\examples{
  downloadNightLights(years = c(1992, 2002, 2012), directory = "night-lights")
}
