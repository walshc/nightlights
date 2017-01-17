extractNightLights <- function(directory = ".", shp, stats = "sum",
                               years = NULL) {
  require(raster)

  if (!class(shp) %in% c("SpatialPolygons", "SpatialPolygonsDataFrame",
                         "SpatialPointsDataFrame")) {
    stop(paste("'shp' must be either a SpatialPolygons",
               "SpatialPolygonsDataFrame or SpatialPointsDataFrame"))
  }

  crs <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
  shp <- sp::spTransform(shp, sp::CRS(crs))

  orig.dir <- getwd()

  setwd(directory)
  files <- list.files(pattern = "*.tif$")

  # Years in which this night lights data are available:
  all.years <- as.numeric(substr(files, 4, 7))  # The year is characters 4 to 9

  # Need to average the years where there are two satellite readings:
  double.years <- all.years[duplicated(all.years)]

  # If years aren't provided, take all of them:
  if (is.null(years)) {
    years <- sort(unique(all.years))
  }

  # Start the output data.frame:
  if (class(shp) == "SpatialPolygons") {
    df <- data.frame(id = 1:length(shp@polygons))
  } else if (class(shp) == "SpatialPolygonsDataFrame") {
    df <- data.frame(shp@data)
  } else if (class(shp) == "SpatialPointsDataFrame") {
    df <- data.frame(shp@data)
  }

  for (i in seq_along(years)) {

    cat("Extracting night lights data for year ", years[i], "...", sep = "")

    # If there are two satellite readings in a year, average them first:
    if (years[i] %in% double.years) {
      both.files <- grep(years[i], files, value = TRUE)
      r  <- crop(raster(both.files[1]), shp, snap = "out")
      r2 <- crop(raster(both.files[2]), shp, snap = "out")
      values(r) <- (values(r) + values(r2)) / 2
      rm(r2)

      # With only one reading in a year, just read in the file normally:
    } else {
      r <- crop(raster(grep(years[i], files, value = TRUE)), shp, snap = "out")
    }

    for (j in stats) {
      extract <- raster::extract(r, shp, fun = get(j), na.rm = TRUE)
      df[[paste0("night.lights.", years[i], ".", j)]] <- c(extract)
    }

    cat("Done\n")
  }
  setwd(orig.dir)
  return(df)
}
