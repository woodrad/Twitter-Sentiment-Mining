This codebase is no longer maintained. From what I can tell, the code no longer pulls down tweets as planned. I hope you still find some use in it.

---

The goal of this project is to provide a simple example of mining tweets for sentiments using a bag of words approach. This project is made using the literate approach to programming and is composed of the tangled Rnw file and the woven PDF.  

Major changes are recorded in the changelog file contained in this repository. Known bugs are reported on the GitHub issues page for this project.

For the build to succeed, you will need to have the following R packages installed: plyr, stringr, twitteR, ggplot2, and ROauth. You also need to have Sweave set up properly.

The Sentiment Lexicon for this project is taken from Hu and Liu's opinion lexicon. See http://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html for source information and http://www.cs.uic.edu/~liub/FBS/opinion-lexicon-English.rar to download their opinion lexicon.

The scoring function implemented in this project was greatly inspired by "R by example: mining Twitter for consumer attitudes towards airlines" by Jeffrey Breen (see http://www.slideshare.net/jeffreybreen/r-by-example-mining-twitter-for).
