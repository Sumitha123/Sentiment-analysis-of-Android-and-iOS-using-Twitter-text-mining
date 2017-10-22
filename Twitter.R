
-----------------------------------------------------------------
#Sentiment analysis of Android and tweet using twitter text mining
#Author - Sumitha P K
-----------------------------------------------------------------


#Create a function for initializing Twitter Handshake
  
twitter.handshake <- function(){
#Load required libraries
#install.packages("twitteR")  
library("twitteR")
library("RCurl")
library(tm)
library("ggplot2")
library("wordcloud")

api_key <- "wpE4joIPivAGGoORs1L1Gw9ia"
api_secret <- "rVr3OFVO4TgYMJVF1T6kMkM5sv5OUk4UFRxE4RdRSrYPp56BgN"
access_token <- "287570350-txTpjTYRlY67GxK1L9rZMWykQf976TXtW8ivmHbC"
access_token_secret <- "6Mt5sGBxOPsjsdEtG99RirclIjRfK13xybuUcf7NAdvhn"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

# Set SSL certs globally
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package =  "RCurl")))

#Initialize handshake
twitCred$handshake()
}

# Create a function to search a term in twitter and return a dataframe of 
# frequent words and their frequencies.
twitter.searchtweets <- function(searchterm,i){
tweet <- searchTwitter(searchterm, n=i, lang = 'en', resultType = 'recent')
tweetTxt = sapply(tweet, function(x) x$getText())
tweetTxt <- iconv(tweetTxt, 'UTF-8', 'ASCII')
tweetTxt <- clean.text(tweetTxt)


#Building the Corpus by specifying the source to be character vector
myCorpus = Corpus(VectorSource(tweetTxt))
#Changing letters to lower case
myCorpus <- tm_map(myCorpus, tolower)
#Removing punctuations
myCorpus <- tm_map(myCorpus, removePunctuation)
#Removing numbers
myCorpus <- tm_map(myCorpus, removeNumbers)
# Text stemming
myCorpus <- tm_map(myCorpus, stemDocument)
#Removing stopwords
my_stopwords<- c(stopwords("en"),stopwords("SMART"),"appgt","indiedev")
myCorpus <- tm_map(myCorpus, removeWords, my_stopwords)
#Removing White spaces
myCorpus <- tm_map(myCorpus, stripWhitespace)

#Constructing a term document matrix
dtm <- TermDocumentMatrix(myCorpus)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
return(d)
}

#Create a function to create wordcloud
twitter.wordcloud <- function(searchterm,i){
d = twitter.searchtweets(searchterm,i)
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, scale = c(10,0.5), random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"), random.color= TRUE)
}


#Create a function to create barplot of frequent terms
twitter.freq.terms <- function(searchterm,i){
d = twitter.searchtweets(searchterm,i)
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")
}

#Creating Sentiment Plot for each term
sentiment.score <- function(searchterm,i){
d = twitter.searchtweets(searchterm,i)
pos <- scan("positiveWords.txt",what="character",comment.char=";")
neg <- scan("negativeWords.txt",what="character",comment.char=";")
pos.words <- c(pos, 'upgrade')
neg.words <- c(neg, 'wait', 'waiting', 'epicfail')
source("sentiment.R")
analysis <- score.sentiment(d$word,pos.words,neg.words)
table(analysis$score)
neutral <- length(which(analysis$score == 0))
positive <- length(which(analysis$score > 0))
negative <- length(which(analysis$score < 0))
Sentiment <- c("Negative","Neutral","Positive")
Count <- c(negative,neutral,positive)
output <- data.frame(Sentiment,Count)
print(output)
myPlot<-ggplot(output,aes(output$Sentiment,output$Count,fill = Sentiment))+
        xlab("Sentiment")+ylab("Score")+ylim(0,1500)
Plot<-myPlot+geom_bar(stat = "identity")+ggtitle("Sentiment Score Barplot") 
Plot
}


#Function to calculate sentiments Frequency Count for each Search Term
sentiment.count <- function(searchterm,i){
  d = twitter.searchtweets(searchterm,i)
  Positive <- scan("positiveWords.txt",what="character",comment.char=";")
  neg <- scan("negativeWords.txt",what="character",comment.char=";")
  pos.words <- c(pos, 'upgrade')
  neg.words <- c(neg, 'wait', 'waiting', 'epicfail')
  source("sentiment.R")
  analysis <- score.sentiment(d$word,pos.words,neg.words)
  table(analysis$score)
  neutral <- length(which(analysis$score == 0))
  positive <- length(which(analysis$score > 0))
  negative <- length(which(analysis$score < 0))
  Sentiment <- c("Negative","Neutral","Positive")
  Count <- c(neutral,negative,positive)
  return(Count)
}

#Initializing Twitter Handshake
twitter.handshake()

#Creating wordcloud
twitter.wordcloud("#iOS",500)
twitter.wordcloud("#iPhone8",500)
twitter.wordcloud("#Android",500)
twitter.wordcloud("#Galaxys8",500)


#Creating barplot of frequent terms
twitter.freq.terms("#iOS",500)
twitter.freq.terms("#iPhone8",500)
twitter.freq.terms("#Android",500)
twitter.freq.terms("#Galaxys8", 500)


#Creating positive,negative and neutral sentiment score plot
sentiment.score("#iOS",1000)
sentiment.score("#Android",1000)

#iPhone Series
iPhone <- c(rep("iPhone4" , 3) , rep("iPhone4S" , 3), rep("iPhone5" , 3),
           rep("iPhone5S" , 3), rep("iPhone5C" , 3), rep("iPhone6" , 3),
           rep("iPhone6S" , 3), rep("iPhone6SPlus" , 3), rep("iPhone7" , 3),
           rep("iPhone8" , 3))
Sentiment <- rep(c("Neutral" , "Negative" , "Positive") , 10)
Score <- c(sentiment.count("#iPhone4", 500),sentiment.count("#iPhone4S", 500),
           sentiment.count("#iPhone5", 500),sentiment.count("#iPhone5S", 500),
           sentiment.count("#iPhone5C", 500),sentiment.count("#iPhone6", 500),
           sentiment.count("#iPhone6S", 500),sentiment.count("#iPhone6SPlus", 500),
           sentiment.count("#iPhone7", 500),sentiment.count("#iPhone8", 500))
data=data.frame(iPhone,Sentiment,Score)
data


# Stacked Bar Plot
ggplot(data, aes(fill=Sentiment, y=Score, x=iPhone)) + 
  geom_bar( stat="identity") + theme(axis.text.x=element_text(angle=90,hjust=1))


#Samsung Galaxy Series
Samsung_Galaxy <- c(rep("GalaxyS4" , 3) , rep("GalaxyS5" , 3), rep("GalaxyS6" , 3),
            rep("GalaxyS6Edge" , 3), rep("GalaxyS7" , 3), rep("GalaxyS7Edge" , 3),
            rep("GalaxyS8" , 3), rep("GalaxyS8Plus" , 3))
Sentiment <- rep(c("Neutral" , "Negative" , "Positive") , 8)
Score <- c(sentiment.count("#GalaxyS4", 500),sentiment.count("#GalaxyS5", 500),
           sentiment.count("#GalaxyS6", 500),sentiment.count("#GalaxyS6Edge", 500),
           sentiment.count("#GalaxyS7", 500),sentiment.count("#GalaxyS7Edge", 500),
           sentiment.count("#GalaxyS8", 500),sentiment.count("#GalaxyS8Plus", 500))
           
data=data.frame(Samsung_Galaxy,Sentiment,Score)
data

# Stacked Bar Plot
ggplot(data, aes(fill=Sentiment, y=Score, x=Samsung_Galaxy)) + 
  geom_bar( stat="identity") + theme(axis.text.x=element_text(angle=90,hjust=1))
