# Define score.sentiment function to rate tweets as positve or negative.
# This function taken from "R by example: mining Twitter for consumer attitudes towards airlines" presented by Jeffrey Breen
# at the Boston Predictive Analytics MeetUp. http://www.slideshare.net/jeffreybreen/r-by-example-mining-twitter-for

score.sentiment = function(sentences, positive.words, negative.words, .progress='none')
{
  
  require(plyr)
  
  require(stringr)
  
  
  # we got a vector of sentences. plyr will handle a list or a vector as an "l" for us
  
  # we want a simple array of scores back, so we use "l" + "a" + "ply" = laply:
  
  scores = laply(sentences, function(sentence, positive.words, negative.words) {
    
    
    
    
    # clean up sentences with R's regex-driven global substitute, gsub():
    
    
    sentence = gsub('[[:punct:]]', '', sentence)
    
    
    sentence = gsub('[[:cntrl:]]', '', sentence)
    
    
    sentence = gsub('\\d+', '', sentence)
    
    
    # and convert to lower case:
    
    
    sentence = tolower(sentence)
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    # compare our words to the dictionaries of positive & negative terms
    positive.matches = match(words, positive.words)
    negative.matches = match(words, negative.words)
    
    
    
    
    
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    positive.matches = !is.na(positive.matches)
    negative.matches = !is.na(negative.matches)
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(positive.matches) - sum(negative.matches)
    
    return(score)
  }, positive.words, negative.words, .progress=.progress )
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
} 



# Load needed libraries to allow R to interface with twitter and interface with the API using OAuth.
require(twitteR)
require(ROAuth)
require(ggplot2)

# The code below does not work due to a current bug in twitteR. This means that the rate of downloading tweets will be limited.
# ###The following code should NEVER be shared. It includes private keys that authenticate against the twitter API.
# ###This code was taken from the twitteR doccumentation. Run the code from this block to the next comment.
# reqURL <- "https://api.twitter.com/oauth/request_token"
# accessURL <- "https://api.twitter.com/oauth/access_token"
# authURL <- "https://api.twitter.com/oauth/authorize"
# consumerKey <- "keygoeshere"
# consumerSecret <- "keygoeshere"
# twitCred <- OAuthFactory$new(consumerKey=consumer.key,
#                              consumerSecret=consumer.secret,
#                              requestURL=reqURL,
#                              accessURL=accessURL,
#                              authURL=authURL)
# twitCred$handshake()
# ###After entering the PIN provided by twitter, run the following command.
# registerTwitterOAuth(twitCred)

# Load saved tweets.
load(file="siue.tweets.RData")

# Add hot new tweets.
# siueTweets <- append(siue.tweets, searchTwitter('siue', n=1500))
# siueTweets <- append(siue.tweets, searchTwitter('#onlyatsiue', n=1500))

# Extract the text of the tweet for mining.
tweetText <-lapply(siue.tweets, function(x) x$getText())
# Remove non-UTF8 characters.
tweetText <- subset(tweetText, !grepl("[\x80-\xFF]", tweetText))

# Import sentiment lexicons. If the situation demands, add in domain-specific jargon.
positiveWords <- scan('Hu and Liu Sentiment Lexicon/positive-words.txt', 
                      what='character', comment.char=';')

negativeWords <- scan('Hu and Liu Sentiment Lexicon/negative-words.txt', 
                      what='character', comment.char=';')

# Score tweets and summarize.
tweetScores <- score.sentiment(tweetText, positiveWords, negativeWords, .progress='text')

# Summarize and graph histogram with ggplot2.
summary(tweetScores$score)
qplot(score, data=tweetScores, geom="histogram", binwidth=1)