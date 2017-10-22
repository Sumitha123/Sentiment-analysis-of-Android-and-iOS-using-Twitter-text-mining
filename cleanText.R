clean.text <- function(tweet_txt)
{
  tweet_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", tweet_txt)
  tweet_txt = gsub("@\\w+", "", tweet_txt)
  tweet_txt = gsub("[[:punct:]]", "", tweet_txt)
  tweet_txt = gsub("[[:digit:]]", "", tweet_txt)
  tweet_txt = gsub("http\\w+", "", tweet_txt)
  tweet_txt = gsub("[ \t]{2,}", "", tweet_txt)
  tweet_txt = gsub("^\\s+|\\s+$", "", tweet_txt)
  tweet_txt = gsub("amp", "", tweet_txt)
  # define "tolower error handling" function
  try.tolower = function(x)
  {
    y = NA
    try_error = tryCatch(tolower(x), error=function(e) e)
    if (!inherits(try_error, "error"))
      y = tolower(x)
    return(y)
  }
  
  tweet_txt = sapply(tweet_txt, try.tolower)
  tweet_txt = tweet_txt[tweet_txt != ""]
  names(tweet_txt) = NULL
  return(tweet_txt)
}