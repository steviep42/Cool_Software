##
# Pittard, Steve - wsp@emory.edu
# Example function to do GeoCoding
# See http://rollingyours.wordpress.com
## 

myGeo <- function(address="Atlanta,GA") {
 
# Make sure we have the required libraries to do the work
 
  stopifnot(require(RCurl))
  stopifnot(require(XML))
   
# Remove any spaces in the address field and replace with "+"
 
   address = gsub(" ","\\+",address)
    
# Create the request URL according to Google specs
 
  google.url = "http://maps.googleapis.com/maps/api/geocode/xml?address="
  my.url = paste(google.url,address,"&sensor=false",sep="")
 
  Sys.sleep(0.5) # Just so we don't beat up the Google servers with rapid fire requests
   
# Send the request to Google and turn it into an internal XML document
   
  txt = getURL(my.url)
  xml.report = xmlTreeParse(txt, useInternalNodes=TRUE)
 
# Pull out the lat/lon pair and return it 
 
  place = getNodeSet(xml.report,  "//GeocodeResponse/result[1]/geometry/location[1]/*")
  lat.lon = as.numeric(sapply(place,xmlValue))
  names(lat.lon) = c("lat","lon")
   
  return(lat.lon)
}
