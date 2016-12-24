#!/bin/bash

# Bash script to download and extract/decompress all the night lights data from
# NOAA.

echo -n "Please provide the data directory to download and extract data to (make sure you have at least 50GB of free space; it can be an external drive):"
read DATA_DIR

if ! [ -d $DATA_DIR ]; then
        mkdir -p $DATA_DIR
fi

cd $DATA_DIR

if ! [ -d tar-files ]; then
        mkdir tar-files
fi
cd tar-files

# Download each file from:
# "Average Visible, Stable Lights, & Cloud Free Coverages."
wget -A "*.tar" -m -p -E -k -K -np -erobots=off \
     https://www.ngdc.noaa.gov/eog/data/web_data/v4composites/

mv www.ngdc.noaa.gov/eog/data/web_data/v4composites/*.tar .
rm -rf www.ngdc.noaa.gov

# Extract the files from the archives into a folder called gzfiles:
if ! [ -d ../gz-files]; then
        mkdir ../gz-files
fi
for f in *.tar; do tar -xvf $f -C ../gz-files; done

# Delete the .tar files
rm -f *.tar

# Extract the .gz files:
cd ../gz-files
gunzip *web.stable_lights.avg_vis.tif.gz -f

# Put all the tif and tfw files into a separate folder:
mv *.tif ../
mv *.tfw ../

# Delete the .gz files:
rm *.gz

# Delete the old directories
rmdir tar-files
rmdir gz-files
