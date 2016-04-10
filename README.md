# nightlights
An `R` package to extract NOAA night lights data for regions within shapefiles/`SpatialPolygonsDataFrame`. The night lights data can be downloaded from [here](http://ngdc.noaa.gov/eog/data/web_data/v4composites/). A download script is also provided (see below).

## Installation
        if (!require(devtools)) install.packages("devtools")
        devtools::install_github("walshc/nightlights")

## Usage
        require(nightlights)

        # Read in a shapefile:
        require(rgdal)
        shp <- readOGR(dsn = "shapefile-directory", layer = "some-shapefile")

        # Get the sum of night light values within each region in `shp`:
        df <- extractNightLights(nl.dir = "~/data/night-lights", shp = shp)

        # Get the mean and standard deviation within each region in `shp`:
        df <- extractNightLights(nl.dir = "~/data/night-lights", shp = shp, stats = c("mean", "sd"))

## Example output
               GEOID       NAME night.lights.1999.sum night.lights.2000.sum
        0 2502328285    Hanover                3613.0                3587.0
        1 2502338855 Marshfield                5726.5                5253.5
        2 2502350145    Norwell                4494.0                4268.5
        3 2502372985    Wareham                5625.5                5338.0
        4 2500300975     Alford                 324.5                 409.0
        5 2500334970      Lenox                2339.5                2661.0

## Script to download and extract all the data
To save time downloading and extracting all of the NOAA data manually I also provide a script (`download-and-extract-lights-data.sh`) which should work in the terminal on OS X and Linux. The script will ask which directory you want to save the night lights data to. Keep in mind the full data set is very large so you will need about 50GB of space to do this. You can choose to save it to an external drive if you wish. Paste the following commands in the terminal to get it started:

        wget https://raw.githubusercontent.com/walshc/nightlights/master/download-and-extract-lights-data.sh
        chmod +x download-and-extract-lights-data.sh
        ./download-and-extract-lights-data.sh
