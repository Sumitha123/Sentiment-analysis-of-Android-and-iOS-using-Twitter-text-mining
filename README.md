# Sentiment-analysis-of-Android-and-iOS-using-Twitter-text-mining

## Description

The aim of my project is to perform a lexicon based sentiment analysis of the two major
Mobile Operating Systems – Android and iOS by extracting tweets with hash tags
Android and iOS.Sentiment Analysis is the process of computationally determining whether
a tweet is positive, negative or neutral. The most important decision that we need to make 
before buying a smartphone is – which operating systems do we want to use. It would be very 
interesting to compare the sentiments over time of the top mobile Operating Systems and also, 
the leading smartphones: Samsung Galaxy and iPhone.

## Getting Started

This project is in R language and performs sentiment analysis of each OS and leading smartphones by extracting as many 
tweets as possible and using sentiment lexicons and suitable functions to calculate their sentiment 
score. Sentiment lexicons are lookup tables or dictionaries that map words to sentiment scores. The 
results are analyzed statistically by visualizing the results using bar graphs/histograms. 

## Prerequisites

Install packages “twitter”, “RCurl”,"tm", "ggplot2", "wordcloud", "plyr" and "stringr" and load them into the session. 

## Source Code

### sentimentScore.R  
Consists of function score.sentiment() which implements a simple algorithm to calculate the score by subtracting negative
occurences from positive occurences.

### cleanText.R
Consists of function clean.text(), that cleans up sentences with R's regex-driven global substitute, gsub().

### Twitter.R
This file contains the following functions and their implementation.

twitter.handshake() - To authenticate connection to Twitter app and initialize handshake.
Go to the url  https://apps.twitter.com/, sign in and create a new app. 
To set up the connection, go to Keys and Access tokens tab and copy api_key, api_secret, access_token and access_token_secret.
To set up twitter handshake authorization, we use the function: 
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret).
twitter.wordcloud(searchterm,i) - To create wordcloud.Visually attractive Wordcloud can be constructed using words and their frequencies obtained in above step. 
twitter.freq.terms(searchterm,i) - To create barplot of frequent terms.
sentiment.score(searchterm,i) - To Create Sentiment Plot using ggplot2 for each search term.
sentiment.count(searchterm,i) - Function to calculate sentiments Frequency Count for each Search Term.



