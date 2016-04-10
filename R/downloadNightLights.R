downloadNightLights <- function() {
  system("bash <(curl -s https://raw.githubusercontent.com/walshc/nightlights/master/download-and-extract-lights-data.sh)")
}
