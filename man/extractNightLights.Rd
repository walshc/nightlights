\name{extractNightLights}
\alias{extractNightLights}
\title{Extract Night Lights data from regions in a shapefile}
\description{Extract NOAA night lights data for regions in a
  SpatialPolygonsDataFrame. For years with two different satellite readings, it
  first takes the average between the two years.}
\usage{
extractNightLights(nl.dir = ".", shp, stats = c("sum"))
}
\arguments{
\item{nl.dir}{The directory the night lights data is stored in. The files must
  be extracted to TIFF format and the filenames must not have been changed.
  Other TIFF files in the same directory will probably cause problems. The
  default value for \code{nl.dir} is the current directory.}
\item{shp}{The \code{SpatialPolygonsDataFrame} to extract data from.}
\item{stats}{A vector of functions to apply to the data within each region, for
  example \code{c("sum", "mean", "sd")}. The default is \code{"sum"}.}
}
\value{
  Returns a \code{data.frame} with \code{shp@data} combined with the extracted
  night lights data for each year provided.}
}
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

# Download and extract some night lights data (one year here as an example):
download.file("http://ngdc.noaa.gov/eog/data/web_data/v4composites/F182013.v4.tar",
              destfile = "F182013.v4.tar")
untar("F182013.v4.tar")
R.utils::gunzip("F182013.v4c_web.stable_lights.avg_vis.tif.gz")

# Directory where night lights data are stored (current directory here):
nl.dir <- "."

# By default, the function gets the sum of night lights within the regions:
nl.sums <- extractNightLights(nl.dir, shp)

# You can specificy other statistics to get, e.g. the mean & standard deviation:
nl.mean.sd <- extractNightLights(nl.dir, shp, stats = c("mean", "sd"))
}
