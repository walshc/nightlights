
# nightlights
An `R` package to extract NOAA night lights data for regions within shapefiles/`SpatialPolygonsDataFrame`.

## Installation
        if (!require(devtools)) install.packages("devtools")
        devtools::install_github("walshc/nightlights")

## Usage
        require(nightlights)

        # Get the sum of night light values within each region in `shp`:
        df <- extractNightLights(nl.dir = "~/night-lights", shp = shp)

        # Get the mean and standard deviation within each region in `shp`:
        df <- extractNightLights(nl.dir = "~/night-lights", shp = shp, stats = c("mean", "sd"))

## Example output
               GEOID       NAME night.lights.1999.sum night.lights.2000.sum
        0 2502328285    Hanover                3613.0                3587.0
        1 2502338855 Marshfield                5726.5                5253.5
        2 2502350145    Norwell                4494.0                4268.5
        3 2502372985    Wareham                5625.5                5338.0
        4 2500300975     Alford                 324.5                 409.0
        5 2500334970      Lenox                2339.5                2661.0

## Download and Extraction Script
To save time downloading and extracting all of the NOAA data manually I also provide a script which should work in the terminal on OS X and Linux. The script will ask which directory you want to save the night lights data to. Keep in mind the full data set is very large so you will need about 50GB of space to do this. You can choose to save it to an external drive if you wisu. The script can also be used from within R:

        nightlights::downloadNightLights()
