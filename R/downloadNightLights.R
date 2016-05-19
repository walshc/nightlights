downloadNightLights <- function(years, extract = TRUE, directory = NULL) {

  root.url <- "http://ngdc.noaa.gov/eog/data/web_data/v4composites/"
  orig.dir <- getwd()

  if (any(years > 2013) | any(years < 1992)) {
    stop("Night lights data only available between 1992 and 2013.")
  }

  if (!is.null(directory)) {
    dir.create(directory)
    setwd(directory)
  }

  files <- c("F101992", "F101993", "F101994", "F121994", "F121995", "F121996",
             "F121997", "F121998", "F121999", "F141997", "F141998", "F141999",
             "F142000", "F142001", "F142002", "F142003", "F152000", "F152001",
             "F152002", "F152003", "F152004", "F152005", "F152006", "F152007",
             "F152008", "F162004", "F162005", "F162006", "F162007", "F162008",
             "F162009", "F182010", "F182011", "F182012", "F182013")

  files <- paste0(files[substr(files, 4, 7) %in% years], ".v4.tar")
  for (i in files) {
    download.file(paste0(root.url, i), destfile = i)
    if (extract) {
      untar(i)
      all.files <- list.files()
      gz <- all.files[grepl(gsub(".tar", "", i), all.files) &
                      grepl("web.avg_vis.tif.gz", all.files)]
      R.utils::gunzip(gz)
    }
  }
  setwd(orig.dir)
}
