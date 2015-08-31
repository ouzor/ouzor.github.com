---
title: "Visualizing Twitter history with streamgraphs in R"
subtitle: "How to make a streamgraph with R from Twitter hashtags"
layout: post
tags: [R, visualization, twitter]
---

I was exploring ways to visualize my Twitter history, and ended up creating this interactive streamgraph of my 20 most used hashtags in Twitter:

<p> 
<iframe frameborder="0" width="700" height="500" 
        sandbox="allow-same-origin allow-scripts"
        scrolling="no" seamless="seamless"
        src="/files/R/twitter_streamgraph.html">
</iframe>
</p> 

The graph shows how my Twitter activity has varied a lot. The top three hashtags are #datascience, #rstats and #opendata (no surprises there). There are also event-related hashtags that show up only once, such as #tomorrow2015 and #iccss2015, and annually repeating ones, such as #apps4finland.

## How this was made?

Twitter has quite a strict policy for obtaining data, but they do allow one to download the full personal Twitter history, i.e. all tweets as a convenient csv file (instructions [here](https://support.twitter.com/articles/20170160)), so that's what I did.

The visualization was created with the [streamgraph](http://rud.is/b/2015/02/15/introducing-the-streamgraph-htmlwidget-r-pacakge/) R package that uses the great [htmlwidgets](http://www.htmlwidgets.org/) framework for easy creation of javascript visualizations from R. The plots are designed for daily data, but this ended up being too messy, so I aggregated the data on monthly level instead.

Embedding the streamgraph htmlwidget into this Jekyll blog required a bit of hazzle. As pointed out in the comments [here](http://blog.revolutionanalytics.com/2015/07/streamgraphs-in-r.html), the widget must be first created as a standalone html file and then embedded as an iframe. Hopefully there will be a more straightforward way to include htmlwidgets to Jekyll blogs in the future!

Some problems:

* The size of the widget has to be fixed when creating, so it will not scale automatically. This could possibly be fixed in the streamgraph package following [this](http://www.htmlwidgets.org/develop_sizing.html).
* Font size of the graph is very small, but I could not find a way to change it, even in the javascript source. 

The script for producing the streamgraph from the Twitter data is [here](/files/R/twitter_streamgraph.R). It is also printed below, with the help of `read_chunk()`. See more details from the [rmarkdown source](/blog/_R/2015-08-22-twitter-streamgraph.Rmd) for this post.





{% highlight r %}
# Script for producing a streamgraph of tweet hashtags

# Load packages
library("readr")
library("dplyr")
library("lubridate")
library("streamgraph")
library("htmlwidgets")

# Read my tweets
tweets_df <- read_csv("files/R/tweets.csv") %>%
  select(timestamp, text) %>%
  mutate(text = tolower(text))

# Pick hashtags with regexp
hashtags_list <- regmatches(tweets_df$text, gregexpr("#[[:alnum:]]+", tweets_df$text))

# Create a new data_frame with (timestamp, hashtag) -pairs
hashtags_df <- data_frame()
for (i in which(sapply(hashtags_list, length) > 0)) {
  hashtags_df <- bind_rows(hashtags_df, data_frame(timestamp = tweets_df$timestamp[i],
                                                   hashtag = hashtags_list[[i]]))
}

# Process data for plotting
hashtags_df <- hashtags_df %>%
  # Pick top 20 hashtags
  filter(hashtag %in% names(sort(table(hashtag), decreasing=TRUE))[1:20]) %>%
  # Group by year-month (daily is too messy)
  # Need to add '-01' to make it a valid date for streamgraph
  mutate(yearmonth = paste0(format(as.Date(timestamp), format="%Y-%m"), "-01")) %>%
  group_by(yearmonth, hashtag) %>%
  summarise(value = n())

# Create streamgraph
sg <- streamgraph(data = hashtags_df, key = "hashtag", value = "value", date = "yearmonth",
                 offset = "silhouette", interpolate = "cardinal",
                 width = "700", height = "400") %>%
  sg_legend(TRUE, "hashtag: ") %>%
  sg_axis_x(tick_interval = 1, tick_units = "year", tick_format = "%Y")

# Save it for viewing in the blog post
# For some reason I can not save it to files/R/ direclty so need to use file.rename()
saveWidget(sg, file="twitter_streamgraph.html", selfcontained = TRUE)
file.rename("twitter_streamgraph.html", "files/R/twitter_streamgraph.html")
{% endhighlight %}





