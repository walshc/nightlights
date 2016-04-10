extractNightLights <- function(nl.dir = ".", shp, stats = "sum") {
  require(raster)

  if (class(shp) != "SpatialPolygonsDataFrame") {
    stop("'shp' must be a SpatialPolygonsDataFrame")
  }

  orig.dir <- getwd()

  setwd(nl.dir)
  files <- list.files(pattern = "*.tif")
  # Years in which this night lights data are available:
  years <- substr(files, 4, 7)  # The year is characters 4 to 9

  # Need to average the years where there are two satellite readings:
  double.years <- years[duplicated(years)]
  years <- sort(unique(years))

  # Start the output data.frame:
  df <- shp@data

  for (i in seq_along(years)) {
    cat("Extracting night lights data for year ", years[i], "...", sep = "")
    # If there are two satellite readings in a year, average them first:
    if (years[i] %in% double.years) {
      both.files <- grep(years[i], files, value = TRUE)
      r  <- crop(raster(both.files[1]), shp)
      r2 <- crop(raster(both.files[2]), shp)
      values(r) <- (values(r) + values(r2)) / 2
      rm(r2)
      # With only on reading in a year, just read in the file normally:
    } else {
      r <- crop(raster(grep(years[i], files, value = TRUE)), shp)
    }
    proj4string(r) <- proj4string(shp)
    for (j in stats) {
      extract <- extract(r, shp, fun = get(j), na.rm = TRUE)
      df[[paste0("night.lights.", years[i], ".", j)]] <- c(extract)
    }
    cat("Done\n")
  }
  setwd(orig.dir)
  return(df)
}
