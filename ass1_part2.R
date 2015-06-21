library(slidify)

library(shinyapps)

#remove
shinyapps::deployApp('C:/Users/Tamagoch/Desktop/Git/DataProducts/Ass1')

author("first_deck")


#publish on rpubs
options(rpubs.upload.method = "internal")

options(RCurlOptions = list(verbose = FALSE, capath = system.file("CurlSSL", "cacert.pem", package = "RCurl"), ssl.verifypeer = FALSE))

publish_rpubs("Titanic survival probability prediction", html_file = "index.html")
