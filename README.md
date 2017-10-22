# Sentiment-analysis-of-Android-and-iOS-using-Twitter-text-mining

#We should install packages “twitter” and “RCurl” and load them into the session. 
#Twitter API requires authentication to retrieve tweets. 
#Go to the url  https://apps.twitter.com/, sign in and create a new app. To set up the connection, go to Keys and Access tokens tab and copy api_key, api_secret, access_token and access_token_secret. To set up twitter handshake authorization, we use the function: setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret).
searchTwitter function is used to search tweets based on the search string.
tweet <- searchTwitter(searchterm, n, lang = 'en', resultType = 'recent')
searchTerm is the search string for which tweets should be extracted.
n is the maximum number of tweets to be extracted. ‘en’ restricts tweets to English language.
The output character vector is given as input to a function clean.text(), which cleans up sentences with R's regex-driven global substitute, gsub().
The data is converted into a corpus. Corpus handling and pre-processing requires text-mining package – “tm”. 
Obtain words and their frequencies.Creating a wordcloud requires the wordcloud and RColorbrewer package.
Visually attractive Wordcloud can be constructed using words and their frequencies obtained in above step. 
We calculate the sentiment score using score.sentiment() function. Next, we create barplot of frequently used 
terms in the tweets related to each search term. 
We create a  barplot for iOS and Android OS by filetring tweets with hashtags iOS and  Android.
