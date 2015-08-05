---
title: "Learning and sharing - my first data science lecture"
subtitle: "Recap of my guest lecture on data science at Tampere University of Technology "
layout: post
tags: [datascience, lecture]
---

I had the pleasure to give a guest lecture on data science at Tampere University of Technology yesterday. I was invidited by my friend [Jukka Huhtamäki] to give a lecture on Programmatic Content Management course ([description in Finnish][pcm]). This was my first full-scale lecture, so it was a very exciting opportunity to share my experiences and views of the topic.

Here are my [slides] in html format, and the corresponding rmarkdown [source]. Based on Jukka's description I understood that the participants were mostly web developers and had experience on data journalism, but not much on statistics. I thus decided to keep my presentation on a quite general level. I also made a small pre-lecture survey on the ideas that 'data science' brought to the participants mind, and created this wordcloud based on those (see below). This was encouraging, as the audience clearly identified many relevants aspects related to data science, in addition to the mandatory big data stuff.

<center>
<img src="/presentations/tty_datascience_2015/tty_datascience_2015_files/figure-html/wordcloud-1.png" alt="Data Science word cloud" width="600">
</center>

We also advertised the lecture on Facebook which worked out nicely, with more than 100 people 'Going' and some 50 more 'Maybes'. The final count was about 80, which was very nice! This also increased the heterogeneity of the audience, bringing in also audience with more data science -related expertise. Based on the feedback some of them were disappointed with the lack of in-depth examples from the industry, which was unfortunate. Such examples are kind of hard to give, as our business cases are confidential. I tried to address this by presenting open data science examples, but could indeed have gone deeper with these.

On the other hand I also got some very positive feedback saying that the lecture was easy to understand. It's tough balancing between generality and specificity for an audience with very varied backgrounds! We had very good comments and discussions during the lecture. I also got some comments challenging my points of view, which as excellent. As I tried to emphasize, data science can be viewed from so many angles and mine is only one of them. 

I had experimented with rmarkdown html slides before, but this was the first I time I create a full presentation with them. I really like the idea of being able to produce slides from rmarkdown source files. However, producing even acceptable-looking slides turned out to be surprisingly challenging, at least for the first time. The basic markdown ioslides format is very limited. Luckily it can be extended by including proper html into the source, but this is also more laborious than writing pure markdown. This was a good excercise, but I am not sure whether I will continue making such long presentations with rmarkdown in the future, or stick with Keynote.


[Jukka Huhtamäki]: https://twitter.com/jnkka
[pcm]: http://iislab.ee.tut.fi/piiri/groups/ohjelmallinen-sis%C3%A4ll%C3%B6nhallinta-2015
[slides]: /presentations/tty_datascience_2015/tty_datascience_2015.html
[source]: /presentations/tty_datascience_2015/tty_datascience_2015.Rmd