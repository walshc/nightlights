\name{extractNightLights}
\alias{extractNightLights}
\title{Extract Night Lights data from regions in a shapefile}
\description{Extract NOAA night lights data for regions in a
  SpatialPolygonsDataFrame. For years with two different satellite readings, it
  first takes the average between the two years.}
\usage{
extractNightLights(directory = ".", shp, stats = c("sum"))
}
\arguments{
\item{directory}{The directory the night lights data is stored in. The files
  must be extracted to TIFF format and the filenames must not have been
  changed.  Other TIFF files in the same directory will probably cause
  problems. The default value for \code{nl.dir} is the current directory.}
\item{shp}{The \code{SpatialPolygonsDataFrame} to extract data from.}
\item{stats}{A vector of functions to apply to the data within each region, for
  example \code{c("sum", "mean", "sd")}. The default is \code{"sum"}.}
}
\value{
  Returns a \code{data.frame} with \code{shp@data} combined with the extracted
  night lights data for each year provided.}
\examples{
q <- readline(prompt="Download shapefile and night lights data for example (about 500MB)? (Y/n)")
if (q != "Y") {
  stop("Aborted.")
}

# Get an example shapefile to work with:
download.file("ftp://ftp2.census.gov/geo/tiger/TIGER2015/COUSUB/tl_2015_25_cousub.zip",
              destfile = "tl_2015_25_cousub.zip")
unzip("tl_2015_25_cousub.zip")
shp <- rgdal::readOGR(".", "tl_2015_25_cousub")

# Download and extract some night lights data to a directory "night-lights":
downloadNightLights(years = 1999:2000, directory = "night-lights")

# By default, the function gets the sum of night lights within the regions:
nl.sums <- extractNightLights(directory = "night-lights", shp)

# You can specificy other statistics to get, e.g. the mean & standard deviation:
nl.mean.sd <- extractNightLights(directory = "night-lights", shp,
                                 stats = c("mean", "sd"))
}
