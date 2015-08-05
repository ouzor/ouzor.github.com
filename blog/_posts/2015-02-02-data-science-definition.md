---
title: "Data scientist - statistician, programmer, consultant and visualizer?"
subtitle: "My personal attempt to define a data scientist"
layout: post
tags: [datascience]
---

Data science has recently emerged as an interdisciplinary field with a fair amount of hype around it. It has been declared as the [sexiest job of the 21st century][hbr-ds] and the salaries of data scientists have skyrocketed. However, there still is not a good overall definition for data science, so here I’ll try to open it from my own perspective.

An obvious reason to the lack of a good definition is that professionals from a diverse set of fields, such as analytics, statistics, computer science, business intelligence and information management, jumped to adopt to new sexy job title, and everyone emphasizes her own background in her definitions.

A good way to approach the problem is to list skills that are necessary for the job, or at least common among data scientists. An often cited combination of skills is illustrated by Drew Convay in the [Data Science Venn Diagram][ds-venn]: 
<center>
<a href="http://drewconway.com/zia/2013/3/26/the-data-science-venn-diagram">
<img src="http://static1.squarespace.com/static/5150aec6e4b0e340ec52710a/t/51525c33e4b0b3e0d10f77ab/1364352052403/Data_Science_VD.png" alt="Data Science Venn Diagram" width="400">
</a>
</center>

Personally I think this is a very good starting point. Math and statistics knowledge is required to know how and why different statistical data analysis methods work, and importantly, when they do not work (see the Danger Zone in the Venn Diagram)! At least basic programming skills (e.g. R or Python) are practically a must in processing and analyzing large and messy data sets. And to be able to really connect the data analysis to the business problems and create value, also substantive expertise is needed.

One could argue that this combination is nothing new, as data analysts and statisticians have been doing this stuff for decades in both research and business. For example, the data science rockstar [Nate Silver] claimed that [data scientist is just a sexed up word for a statistician][simplystat]. However, I think the challenges set by the variety and messiness of practical data analysis problems today are different from what statistics has traditionally been dealing with. Hadley Wickham had a very nice post [about this][hadley]. 

In my opinion there’s one important skillset missing in the Venn Diagram, which is communication. Without proper communication skills even the greatest of results will not be taken into use. An essential part of communication is information visualization, which is used to illustrate complex statistical phenomena in understandable terms. A data scientist is also a consultant with a [need for some soft skills as well][ds-soft].

Recently I bumped into the [definition of a modern data scientist][ds-modern], which indeed adds the communication piece in the puzzle. This new defition is neatly summarized in the following figure:

<center>
<a href="http://www.marketingdistillery.com/2014/11/29/is-data-science-a-buzzword-modern-data-scientist-defined/">
<img src="http://www.marketingdistillery.com/wp-content/uploads/2014/11/mds_f-723x1024.png" alt="Data Science Venn Diagram" width="600">
</a>
</center>

Notice how Big Data -related tools, such as MapReduce and Hadoop, are also mentioned in this definition, but only in a somewhat minor role. This is in line with my own view, as I see that there’s no value in the amount of data as such, and that there’s plenty of interesting things to do with small data sets as well. But more about Big Data in some future post. I will also leave for a further position to cover in more detail the different types of problems and tasks a data scientist can engage in.

[hbr-ds]: https://hbr.org/2012/10/data-scientist-the-sexiest-job-of-the-21st-century/
[ds-venn]: http://drewconway.com/zia/2013/3/26/the-data-science-venn-diagram
[Nate Silver]: http://en.wikipedia.org/wiki/Nate_Silver
[simplystat]: http://simplystatistics.org/2013/08/08/data-scientist-is-just-a-sexed-up-word-for-statistician/
[hadley]: http://bulletin.imstat.org/2014/09/data-science-how-is-it-different-to-statistics%E2%80%89/
[ds-soft]: http://dataconomy.com/the-importance-of-soft-skills-in-data-science
[ds-modern]: http://www.marketingdistillery.com/2014/11/29/is-data-science-a-buzzword-modern-data-scientist-defined/