###Load needed libraries to allow R to interface with twitter and interface with the API using OAuth.
library(twitteR)
library(ROAuth)

###The following code should NEVER be shared. It includes private keys that authenticate against the twitter API.
###This code was taken from the twitteR doccumentation. Run the code from this block to the next comment.
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL = "http://api.twitter.com/oauth/access_token"
authURL = "http://api.twitter.com/oauth/authorize"
consumerKey = "YOUR.KEY.GOES.HERE"
consumerSecret = "YOUR.SECRET.GOES.HERE"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)
twitCred$handshake()
###After entering the PIN provided by twitter, run the following command.
registerTwitterOAuth(twitCred)