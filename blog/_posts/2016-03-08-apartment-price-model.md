---
title: "Urbanisation Continues - Modeling Regional Apartment Prices in Finland"
subtitle: "Modelling and visualising open apartment price data with R"
layout: post
tags: [R, visualisation]
fb-img: http://ouzor.github.io/blog/figs/2016-03-08-apartment-price-model/model_vs_raw_log.gif
---

With all the data science and big data hype going on it's always nice to see real case examples. At [Reaktor](https://reaktor.com/) we have created [Kannattaakokauppa.fi](http://kannattaakokauppa.fi/#/en/), a probabilistic modeling-based interactive visualisation of regional apartment price trends in Finland. The service shows the predicted price levels and trends for year 2017, and by zooming in to a chosen zip code the price development since 2005 is shown. 

<center>
<img src="/blog/figs/2016-03-08-apartment-price-model/kk_2017.png" alt="None" width="600">

<br>
<em>Screenshot of <a href="http://kannattaakokauppa.fi/#/en/">Kannattaakokauppa.fi</a>.</em>
</center>

The visualisation is based on a hierarchical probabilistic model (implemented with R and [Stan](http://ouzor.github.io/blog/2016/02/09/probabilistic-programming.html)) of open data from Statistics Finland. For a thorough description of the model, see the blog post at [rOpenGov](http://ropengov.github.io/r/2015/06/11/apartment-prices/) by my colleague [Janne Sinkkonen](https://twitter.com/euxoa), who did the main modelling work. All R source code is available in [GitHub](https://github.com/reaktor/Neliohinnat). More technical details in the end of this post. We published the first version of the visualisation last spring, and now we have updated it with data from year 2015. 

One clear finding from our analysis is that apartment prices are increasing faster in regions with high population density. This "urbanisation" trend clearly visible in the visualisation (click 'Trend2017'), with most of Finland showing reducing prices and only the largest cities showing increasing prices.


## Filling holes with statistical modeling 

The raw data from Statistics Finland is missing a lot of data, as prices are not reported openly if there are too few transactions per year per zip code. Hence the raw data has a lot of holes. And many of the reported values are also likely to contain notable random variation.

Luckily, with a hierarhical probabilistic we are can predict missing data by generalising information across zip codes to fill the holes. As a result, we get a good overview of the regional apartment price development in Finland, and also more reliable price levels for individual zip codes. 

To illustrate the advantages of the modelling approach, I created the following animation showing the raw data side by side with the modelled data:

<center>
<img src="/blog/figs/2016-03-08-apartment-price-model/model_vs_raw_log.gif" alt="None" width="600">
</center>

The animation is made using the [gganimate](https://github.com/dgrtwo/gganimate) R package ([source code](https://github.com/reaktor/Neliohinnat/blob/master/source_2016/model_visualisations.R)). 



## Data sources and R packages

Apartment price data for the postal codes is from [Statistics Finland][statfi] open data [API][statfi-api] (see [Terms of Use][statfi-terms]). 
Postal code region names, municipalities and population data is from Statistics Finland [Paavo - Open data by postal code area][paavo]. Postal code area map is from [Duukkis] and licensed under CC BY 4.0.

The data sets are accessed via R packages [pxweb] and [gisfin] from the [rOpenGov] project. 

For the final interactive visualisation was created by [Janne Aukia](https://twitter.com/jaukia) with JavaScript. For this, the data was processed in R and written into json files. The spatial data files were first written as geojson file and finally transformed to [topojson](https://github.com/mbostock/topojson) to reduce loading times.

[statfi]: http://tilastokeskus.fi/meta/til/ashi.html
[statfi-api]: http://www.stat.fi/org/avoindata/api.html
[statfi-terms]: http://tilastokeskus.fi/org/lainsaadanto/yleiset_kayttoehdot_en.html
[paavo]: http://www.tilastokeskus.fi/tup/paavo/index_en.html
[pxweb]: https://github.com/ropengov/pxweb
[rOpenGov]: http://ropengov.github.io/
[gisfin]: https://github.com/ropengov/gisfin
[Duukkis]: http://www.palomaki.info/apps/pnro/


