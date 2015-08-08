---
title: "Interactive visualizations with R - a minireview"
subtitle: "A minireview of R packages ggvis, rCharts, plotly and googleVis for interactive visualizations"
layout: post
tags: [R, visualization]
---

Interactive visualization allows deeper exploration of data than static plots. Javascript libraries such as [d3] have made possible wonderful new ways to show data. Luckily the R community has been active in developing R interfaces to some popular javascript libraries to enable R users to create interactive visualizations without knowing any javascript. 

In this post I have reviewed some of the most common interactive visualization packages in R with simple example plots along with some comments and experiences. Here are the packages included:

* [ggplot2] - one of the best static visualization packages in R
* [ggvis] - interactive plots from the makers of ggplot2
* [rCharts] - R interface to multiple javascript charting libraries
* [plotly] - convert ggplot2 figures to interactive plots easily
* [googleVis] - use Google Chart Tools from R

You can either jump straight to the [example visualization](#examplevisus) or read my comments first. The R markdown source code for this blog post with embedded visualizations can be found in [Github][source]. I have probably missed some important features and documentation, and also clear mistakes are possible. Please point those out in the comments, and I'll fix them. It is also important to note that I am a heavy ggplot2 user, and hence my comments may also be biased!

Also other libraries for creating interactive visualizations from R do exist, such as [clickme], [RIGHT], [ggobi], [iplots], [gg2v], [rVega], [cranvas] and [r2d3]. Some of these are not under active development anymore. I might include some of those into the comparison here in the future. The [d3Network] package is also worth checking if you need cool interactive network visualizations.

[d3]: http://d3js.org/
[ggplot2]: http://ggplot2.org/
[ggvis]: http://ggvis.rstudio.com/
[rCharts]: http://rcharts.io/
[gallery]: http://rcharts.io/gallery/
[plotly]: https://plot.ly/r/
[googleVis]: http://cran.r-project.org/web/packages/googleVis/vignettes/googleVis_examples.html

[clickme]: https://github.com/nachocab/clickme
[RIGHT]: https://code.google.com/p/r-interactive-graphics-via-html/
[ggobi]: http://cran.r-project.org/web/packages/rggobi/index.html
[iplots]: http://cran.r-project.org/web/packages/iplots/index.html
[gg2v]: https://github.com/hadley/gg2v
[rVega]: https://github.com/metagraf/rVega
[cranvas]: http://cranvas.org/
[r2d3]: http://www.coppelia.io/introducing-r2d3/
[d3Network]: http://christophergandrud.github.io/d3Network/
[source]: https://github.com/ouzor/ouzor.github.com/blob/master/blog/_R/2014-11-21-interactive-visualizations.Rmd

## Technical features

All four packages use javascript for the interactive visualizations, and are cabable of producing most of the standard plot types. The syntaxes vary somewhat, as ggvis uses the pipe operator `%>%` (familiar for dplyr users), replacing the `+` in ggplot2. rCharts uses several javascript libraries and also the syntax used varies between different types of charts. 

All other packages than googleVis are clearly in an early development phase, which is visible in a limited features and documentation. As an experienced ggplot2 user it was often hard to adapt to the much narrower range of features included in ggvis. For example [faceting] is a very important feature that hopefully gets implemented soon. 

Documentation-wise ggvis and googleVis seem to be the most advanced. rCharts especially suffers from the combination of multiple plot types (named rather uninformatively as `rPlot`, `nPlot` and so on) with practically no documentation. So producing anything else than what's provided in the existing examples was very hard. 

googleVis sets itself apart by requiring the data in a different format than the other packages. In Hadley Wickham's [terms][tidy data], it assumes the data is in the *messy* format, in contrast to the other packages, tha assume *tidy* data. This makes it somewhat hard to use, at least when one is used to using tidy data frames. See the examples below for more details.

Plotly is an interesting alternative to the other packages in that it simply takes as input a ggplot2 object and transforms it into an interactive chart that can then be embedded into websites. Using the service requires authentication, which is a clear limitation. By default all plots are made publicly visible to anyone, but there apparently is a way to produce private plots as well, with a limit in their number in the free account. 

ggvis is currently the only one of these packages that can not produce map visualizations, but I assume this feature will be added in the future. plotly can use maps created with ggplot2, but not yet with the handy [ggmap] extension. 

[faceting]: http://docs.ggplot2.org/0.9.3.1/facet_grid.html
[tidy data]: http://www.jstatsoft.org/v59/i10/
[ggmap]: https://sites.google.com/site/davidkahle/ggmap

## Sharing the visualizations

Interactive visualizations are typically meant to be shared for a larger audience. Common ways to share interactive visualizations from R are as standalone html files, embedded in [R markdown][rmd] documents, and embedded in [Shiny] applications. All the studied packages can produce standalone htmls, though possibly with some loss of interactivity. 

R markdown documents are a very nice way of sharing reproducible analyses, using the [knitr] and [rmarkdown] packages. Outputs from all the studied visualization packages can be embedded in .Rmd documents, though I had some problems (see the Issues section below). All packages are also compatible with Shiny documents and applications, and have good tutorials for this. 

[rmd]: http://rmarkdown.rstudio.com/
[Shiny]: http://shiny.rstudio.com/
[knitr]: http://yihui.name/knitr/
[rmarkdown]: https://github.com/rstudio/rmarkdown

## Issues

I encountered several problems when preparing this blog post. Specifically, I had issues in embedding the plots into R markdown documents. This is made more complicated with the various available ways of turning .Rmd files into html: manual `knit()` and `knit2html()` functions, the `Knit HTML` button in RStudio, and a Jekyll-powered blog with its own requirements. Here I have listed the most important issues, with solutions when found. Some things are still unsolved, hope someone can help me with those! 

* **ggvis** showed up nicely with `Knit HTML`, as it creates a standalone file with the necessary javascript libraries included. However, this was not the case with my blog setup. My solution was to inlude the set of scripts (taken from the [source of this page][ggvis-scripts]) into the header of all my blog posts (see [here][blog-scripts]). Not sure if this is an optimal solution.
* **UPDATE 8.8.2015**: After [updating] the blog theme, the ggvis only show up with Chrome, not with Firefox or Safari. There's some black magic beyond my understanding going on, so I would really appreciate some help with this!
* **rCharts:** Embedding rCharts to R markdown did not quite work either as shown e.g. [here][rcharts-rmd]. With `Knit HTML` button the line that worked was `rchars.object$print(include_assets=TRUE)`, whereas with the blog the line was `rchars.object$show('iframesrc', cdn=TRUE)`.
* **plotly:** Embedding plotly charts into R markdown documents did not work as shown [here][plotly-rmd], but adding `session="knitr"` to the `ggplotly()` call [solved the issue][plotly-issue] (thanks to Scott Chamberlain and Marianne Corvellec for help!). Note that in this post I embedded existing plotly charts manually.
* There are still two charts that do now show up in this post. I have quite limited understanding of how knitr, jekyll and the javascript tools work together, and could not get these to work. Perhaps the scripts somehow conflict with each other?

I also noticed some minor issues:

* googleVis was missing axis labels by default
* rCharts is missing legend titles, and behaves strangely on scatter plot: legend shows partially incorrect information, and the plot area is too tight 

[plotly-rmd]: http://ropensci.org/blog/2014/04/17/plotly/
[plotly-issue]: https://github.com/ropensci/plotly/issues/12#issuecomment-63134893
[rcharts-rmd]: http://bl.ocks.org/ramnathv/raw/8084330/
[ggvis-scripts]: http://ggvis.rstudio.com/0.1/interactivity.html
[blog-scripts]: https://github.com/ouzor/ouzor.github.com/blob/master/_includes/head.html
[updating]: http://ouzor.github.io/blog/2015/08/07/website-update.html

## Summary

In general, being able to produce valid interactive html charts from R markdown without knowing any javascript is great! All of the packages great sensible outputs, but there are also a lot of differences. I love ggplot2, and hence I also like ggvis, as it pays attention to graphical details following the [grammar of graphics] principles. However, the package is still missing a lot of important features, such as faceting. In many cases rCharts can do what ggvis can not (yet), and so it is a good alternative. However, the missing documentation makes it hard to create customized plots. Plotly has a really nice idea and implementation, but requirement for authentication and limited number of private plots reduce the usability a lot. Google's [Motion charts](https://code.google.com/p/google-motion-charts-with-r/) are cool and useful, but otherwise the input data format logic that differs from the packages makes using the package too hard in practice. 

[grammar of graphics]: http://www.cs.uic.edu/~wilkinson/TheGrammarOfGraphics/GOG.html

## Example visualizations {#examplevisus}

Here I have made example plots with the interactive tools: [histograms](#histograms), [scatter plots](#scatter) and [line plots](#lineplots). Source code is available in [Github][source]. First we need to install and load the necessary R packages:


{% highlight r %}
## Install necessary packages
install.packages("devtools")
library("devtools")
install.packages("ggvis")
install.packages("googleVis")
install_github("ramnathv/rCharts")
install_github("ropensci/plotly")
install.packages("dplyr")
install.packages("tidyr")
install.packages("knitr")
{% endhighlight %}
 

{% highlight r %}
# Load packages
library("ggvis")
library("googleVis")
library("rCharts")
library("plotly")
library("dplyr")
library("tidyr")
library("knitr")
# Define image sizes
img.width <- 450
img.height <- 300
options(RCHART_HEIGHT = img.height, RCHART_WIDTH = img.width)
opts_chunk$set(fig.width=6, fig.height=4)
{% endhighlight %}

Plotly needs some setting up (using the credentials from [here][plotly-rmd]).


{% highlight r %}
# Plotly requires authentication
py <- plotly("RgraphingAPI", "ektgzomjbx")
{% endhighlight %}

Prepare the mtcars data set a bit.


{% highlight r %}
# Use mtcars data
data(mtcars)
mtcars$cyl <- factor(mtcars$cyl)
mtcars$am <- factor(mtcars$am)
# Compute mean mpg per cyl and am
mtcars.mean <- mtcars %>% group_by(cyl, am) %>% 
  summarise(mpg_mean=mean(mpg)) %>% 
  select(cyl, am, mpg_mean) %>% ungroup()
{% endhighlight %}

## Histograms {#histograms}

**ggplot**


{% highlight r %}
hist.ggplot <- ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth=1)
hist.ggplot
{% endhighlight %}

![testing](/blog/figs/2014-11-21-interactive-visualizations/hist_ggplot-1.png) 

**ggvis**


{% highlight r %}
hist.ggvis <- mtcars %>% ggvis(x = ~mpg) %>% layer_histograms(width=1) %>% 
  set_options(width = img.width, height = img.height)
hist.ggvis
{% endhighlight %}

<!--html_preserve--><div id="plot_id527406125-container" class="ggvis-output-container">
<div id="plot_id527406125" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id527406125_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id527406125" data-renderer="svg">SVG</a>
 | 
<a id="plot_id527406125_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id527406125" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id527406125_download" class="ggvis-download" data-plot-id="plot_id527406125">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id527406125_spec = {
    "data": [
        {
            "name": "mtcars0/bin1/stack2",
            "format": {
                "type": "csv",
                "parse": {
                    "xmin_": "number",
                    "xmax_": "number",
                    "stack_upr_": "number",
                    "stack_lwr_": "number"
                }
            },
            "values": "\"xmin_\",\"xmax_\",\"stack_upr_\",\"stack_lwr_\"\n9.5,10.5,2,0\n10.5,11.5,0,0\n11.5,12.5,0,0\n12.5,13.5,1,0\n13.5,14.5,1,0\n14.5,15.5,5,0\n15.5,16.5,2,0\n16.5,17.5,1,0\n17.5,18.5,2,0\n18.5,19.5,3,0\n19.5,20.5,1,0\n20.5,21.5,5,0\n21.5,22.5,0,0\n22.5,23.5,2,0\n23.5,24.5,1,0\n24.5,25.5,0,0\n25.5,26.5,1,0\n26.5,27.5,1,0\n27.5,28.5,0,0\n28.5,29.5,0,0\n29.5,30.5,2,0\n30.5,31.5,0,0\n31.5,32.5,1,0\n32.5,33.5,0,0\n33.5,34.5,1,0"
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n8.25\n35.75"
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n0\n5.25"
        }
    ],
    "scales": [
        {
            "name": "x",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "width"
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "rect",
            "properties": {
                "update": {
                    "stroke": {
                        "value": "#000000"
                    },
                    "fill": {
                        "value": "#333333"
                    },
                    "x": {
                        "scale": "x",
                        "field": "data.xmin_"
                    },
                    "x2": {
                        "scale": "x",
                        "field": "data.xmax_"
                    },
                    "y": {
                        "scale": "y",
                        "field": "data.stack_upr_"
                    },
                    "y2": {
                        "scale": "y",
                        "field": "data.stack_lwr_"
                    }
                },
                "ggvis": {
                    "data": {
                        "value": "mtcars0/bin1/stack2"
                    }
                }
            },
            "from": {
                "data": "mtcars0/bin1/stack2"
            }
        }
    ],
    "width": 450,
    "height": 300,
    "legends": [

    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "layer": "back",
            "grid": true,
            "title": "mpg"
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "layer": "back",
            "grid": true,
            "title": "count"
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 450,
        "height": 300
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id527406125").parseSpec(plot_id527406125_spec);
</script><!--/html_preserve-->

**rCharts**


{% highlight r %}
# rCharts histogram needs manual binning and counting!
hist.rcharts <- rPlot(x="bin(mpg,1)", y="count(id)", data=mtcars, type="bar")
# Use this with 'Knit HTML' button
# hist.rcharts$print(include_assets=TRUE)
# Use this with jekyll blog
hist.rcharts$show('iframesrc', cdn=TRUE)
{% endhighlight %}

<iframe srcdoc=' &lt;!doctype HTML&gt;
&lt;meta charset = &#039;utf-8&#039;&gt;
&lt;html&gt;
  &lt;head&gt;
    
    &lt;script src=&#039;//ramnathv.github.io/rCharts/libraries/widgets/polycharts/js/polychart2.standalone.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    
    &lt;style&gt;
    .rChart {
      display: block;
      margin-left: auto; 
      margin-right: auto;
      width: 450px;
      height: 300px;
    }  
    &lt;/style&gt;
    
  &lt;/head&gt;
  &lt;body &gt;
    
    &lt;div id = &#039;chart156f562ef83e5&#039; class = &#039;rChart polycharts&#039;&gt;&lt;/div&gt;    
    &lt;script type=&#039;text/javascript&#039;&gt;
    var chartParams = {
 &quot;dom&quot;: &quot;chart156f562ef83e5&quot;,
&quot;width&quot;:    450,
&quot;height&quot;:    300,
&quot;layers&quot;: [
 {
 &quot;x&quot;: &quot;bin(mpg,1)&quot;,
&quot;y&quot;: &quot;count(id)&quot;,
&quot;data&quot;: {
 &quot;mpg&quot;: [     21,     21,   22.8,   21.4,   18.7,   18.1,   14.3,   24.4,   22.8,   19.2,   17.8,   16.4,   17.3,   15.2,   10.4,   10.4,   14.7,   32.4,   30.4,   33.9,   21.5,   15.5,   15.2,   13.3,   19.2,   27.3,     26,   30.4,   15.8,   19.7,     15,   21.4 ],
&quot;cyl&quot;: [ &quot;6&quot;, &quot;6&quot;, &quot;4&quot;, &quot;6&quot;, &quot;8&quot;, &quot;6&quot;, &quot;8&quot;, &quot;4&quot;, &quot;4&quot;, &quot;6&quot;, &quot;6&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;4&quot;, &quot;4&quot;, &quot;4&quot;, &quot;4&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;4&quot;, &quot;4&quot;, &quot;4&quot;, &quot;8&quot;, &quot;6&quot;, &quot;8&quot;, &quot;4&quot; ],
&quot;disp&quot;: [    160,    160,    108,    258,    360,    225,    360,  146.7,  140.8,  167.6,  167.6,  275.8,  275.8,  275.8,    472,    460,    440,   78.7,   75.7,   71.1,  120.1,    318,    304,    350,    400,     79,  120.3,   95.1,    351,    145,    301,    121 ],
&quot;hp&quot;: [    110,    110,     93,    110,    175,    105,    245,     62,     95,    123,    123,    180,    180,    180,    205,    215,    230,     66,     52,     65,     97,    150,    150,    245,    175,     66,     91,    113,    264,    175,    335,    109 ],
&quot;drat&quot;: [    3.9,    3.9,   3.85,   3.08,   3.15,   2.76,   3.21,   3.69,   3.92,   3.92,   3.92,   3.07,   3.07,   3.07,   2.93,      3,   3.23,   4.08,   4.93,   4.22,    3.7,   2.76,   3.15,   3.73,   3.08,   4.08,   4.43,   3.77,   4.22,   3.62,   3.54,   4.11 ],
&quot;wt&quot;: [   2.62,  2.875,   2.32,  3.215,   3.44,   3.46,   3.57,   3.19,   3.15,   3.44,   3.44,   4.07,   3.73,   3.78,   5.25,  5.424,  5.345,    2.2,  1.615,  1.835,  2.465,   3.52,  3.435,   3.84,  3.845,  1.935,   2.14,  1.513,   3.17,   2.77,   3.57,   2.78 ],
&quot;qsec&quot;: [  16.46,  17.02,  18.61,  19.44,  17.02,  20.22,  15.84,     20,   22.9,   18.3,   18.9,   17.4,   17.6,     18,  17.98,  17.82,  17.42,  19.47,  18.52,   19.9,  20.01,  16.87,   17.3,  15.41,  17.05,   18.9,   16.7,   16.9,   14.5,   15.5,   14.6,   18.6 ],
&quot;vs&quot;: [      0,      0,      1,      1,      0,      1,      0,      1,      1,      1,      1,      0,      0,      0,      0,      0,      0,      1,      1,      1,      1,      0,      0,      0,      0,      1,      0,      1,      0,      0,      0,      1 ],
&quot;am&quot;: [ &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot; ],
&quot;gear&quot;: [      4,      4,      4,      3,      3,      3,      3,      4,      4,      4,      4,      3,      3,      3,      3,      3,      3,      4,      4,      4,      3,      3,      3,      3,      3,      4,      5,      5,      5,      5,      5,      4 ],
&quot;carb&quot;: [      4,      4,      1,      1,      2,      1,      4,      2,      2,      4,      4,      3,      3,      3,      4,      4,      4,      1,      2,      1,      1,      2,      2,      4,      2,      1,      2,      2,      4,      6,      8,      2 ] 
},
&quot;facet&quot;: null,
&quot;type&quot;: &quot;bar&quot; 
} 
],
&quot;facet&quot;: [],
&quot;guides&quot;: [],
&quot;coord&quot;: [],
&quot;id&quot;: &quot;chart156f562ef83e5&quot; 
}
    _.each(chartParams.layers, function(el){
        el.data = polyjs.data(el.data)
    })
    var graph_chart156f562ef83e5 = polyjs.chart(chartParams);
&lt;/script&gt;
    
    &lt;script&gt;&lt;/script&gt;    
  &lt;/body&gt;
&lt;/html&gt; ' scrolling='no' frameBorder='0' seamless class='rChart  polycharts  ' id='iframe-chart156f562ef83e5'> </iframe>
 <style>iframe.rChart{ width: 100%; height: 400px;}</style>

Does not show up...

**plotly**


{% highlight r %}
# This works, but is not evaluated now. Instead the iframe is embedded manually.
py$ggplotly(hist.ggplot, session="knitr")
{% endhighlight %}

<iframe height="400" id="igraph" scrolling="no" seamless="seamless" src="https://plot.ly/~ouzor/33/count-vs-mpg/" width="450" frameBorder="0"></iframe>

**googleVis**


{% highlight r %}
# Number of bins chosen automatically, which is sometimes bad
gvis.options <- list(hAxis="{title:'mpg'}",
                     width=img.width, height=img.height)
hist.gvis <- gvisHistogram(data=mtcars["mpg"], option=gvis.options)
print(hist.gvis, tag="chart")
{% endhighlight %}

<!-- Histogram generated in R 3.1.2 by googleVis 0.5.6 package -->
<!-- Wed Jan 14 17:22:44 2015 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataHistogramID156f55ce9311 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 21 
],
[
 21 
],
[
 22.8 
],
[
 21.4 
],
[
 18.7 
],
[
 18.1 
],
[
 14.3 
],
[
 24.4 
],
[
 22.8 
],
[
 19.2 
],
[
 17.8 
],
[
 16.4 
],
[
 17.3 
],
[
 15.2 
],
[
 10.4 
],
[
 10.4 
],
[
 14.7 
],
[
 32.4 
],
[
 30.4 
],
[
 33.9 
],
[
 21.5 
],
[
 15.5 
],
[
 15.2 
],
[
 13.3 
],
[
 19.2 
],
[
 27.3 
],
[
 26 
],
[
 30.4 
],
[
 15.8 
],
[
 19.7 
],
[
 15 
],
[
 21.4 
] 
];
data.addColumn('number','mpg');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartHistogramID156f55ce9311() {
var data = gvisDataHistogramID156f55ce9311();
var options = {};
options["allowHtml"] = true;
options["hAxis"] = {title:'mpg'};
options["width"] =    450;
options["height"] =    300;

    var chart = new google.visualization.Histogram(
    document.getElementById('HistogramID156f55ce9311')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartHistogramID156f55ce9311);
})();
function displayChartHistogramID156f55ce9311() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartHistogramID156f55ce9311"></script>
 
<!-- divChart -->
  
<div id="HistogramID156f55ce9311" 
  style="width: 450; height: 300;">
</div>

## Scatter plots {#scatter}

**ggplot**


{% highlight r %}
scatter.ggplot <- ggplot(mtcars, aes(x=wt, y=mpg, colour=cyl)) + geom_point()
scatter.ggplot
{% endhighlight %}

![testing](/blog/figs/2014-11-21-interactive-visualizations/scatter_ggplot-1.png) 

**ggvis**


{% highlight r %}
scatter.ggvis <- mtcars %>% ggvis(x = ~wt, y = ~mpg, fill = ~cyl) %>% 
  layer_points() %>% set_options(width = img.width, height = img.height)
scatter.ggvis
{% endhighlight %}

<!--html_preserve--><div id="plot_id762864843-container" class="ggvis-output-container">
<div id="plot_id762864843" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id762864843_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id762864843" data-renderer="svg">SVG</a>
 | 
<a id="plot_id762864843_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id762864843" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id762864843_download" class="ggvis-download" data-plot-id="plot_id762864843">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id762864843_spec = {
    "data": [
        {
            "name": "mtcars0",
            "format": {
                "type": "csv",
                "parse": {
                    "wt": "number",
                    "mpg": "number"
                }
            },
            "values": "\"wt\",\"mpg\",\"cyl\"\n2.62,21,\"6\"\n2.875,21,\"6\"\n2.32,22.8,\"4\"\n3.215,21.4,\"6\"\n3.44,18.7,\"8\"\n3.46,18.1,\"6\"\n3.57,14.3,\"8\"\n3.19,24.4,\"4\"\n3.15,22.8,\"4\"\n3.44,19.2,\"6\"\n3.44,17.8,\"6\"\n4.07,16.4,\"8\"\n3.73,17.3,\"8\"\n3.78,15.2,\"8\"\n5.25,10.4,\"8\"\n5.424,10.4,\"8\"\n5.345,14.7,\"8\"\n2.2,32.4,\"4\"\n1.615,30.4,\"4\"\n1.835,33.9,\"4\"\n2.465,21.5,\"4\"\n3.52,15.5,\"8\"\n3.435,15.2,\"8\"\n3.84,13.3,\"8\"\n3.845,19.2,\"8\"\n1.935,27.3,\"4\"\n2.14,26,\"4\"\n1.513,30.4,\"4\"\n3.17,15.8,\"8\"\n2.77,19.7,\"6\"\n3.57,15,\"8\"\n2.78,21.4,\"4\""
        },
        {
            "name": "scale/fill",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"4\"\n\"6\"\n\"8\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n1.31745\n5.61955"
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n9.225\n35.075"
        }
    ],
    "scales": [
        {
            "name": "fill",
            "type": "ordinal",
            "domain": {
                "data": "scale/fill",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "width"
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "symbol",
            "properties": {
                "update": {
                    "size": {
                        "value": 50
                    },
                    "x": {
                        "scale": "x",
                        "field": "data.wt"
                    },
                    "y": {
                        "scale": "y",
                        "field": "data.mpg"
                    },
                    "fill": {
                        "scale": "fill",
                        "field": "data.cyl"
                    }
                },
                "ggvis": {
                    "data": {
                        "value": "mtcars0"
                    }
                }
            },
            "from": {
                "data": "mtcars0"
            }
        }
    ],
    "width": 450,
    "height": 300,
    "legends": [
        {
            "orient": "right",
            "fill": "fill",
            "title": "cyl"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "layer": "back",
            "grid": true,
            "title": "wt"
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "layer": "back",
            "grid": true,
            "title": "mpg"
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 450,
        "height": 300
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id762864843").parseSpec(plot_id762864843_spec);
</script><!--/html_preserve-->

**rCharts**


{% highlight r %}
scatter.rcharts <- rPlot(mpg ~ wt, data = mtcars, color = 'cyl', type = 'point')
# WTF, legend shows 4-7, while the levels are 4,6,8???
# very tight limits, parts of points missing on the edge
# Use this with 'Knit HTML' button
# scatter.rcharts$print(include_assets=TRUE)
# Use this with jekyll blog
scatter.rcharts$show('iframesrc', cdn=TRUE)
{% endhighlight %}

<iframe srcdoc=' &lt;!doctype HTML&gt;
&lt;meta charset = &#039;utf-8&#039;&gt;
&lt;html&gt;
  &lt;head&gt;
    
    &lt;script src=&#039;//ramnathv.github.io/rCharts/libraries/widgets/polycharts/js/polychart2.standalone.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    
    &lt;style&gt;
    .rChart {
      display: block;
      margin-left: auto; 
      margin-right: auto;
      width: 450px;
      height: 300px;
    }  
    &lt;/style&gt;
    
  &lt;/head&gt;
  &lt;body &gt;
    
    &lt;div id = &#039;chart156f57a77be16&#039; class = &#039;rChart polycharts&#039;&gt;&lt;/div&gt;    
    &lt;script type=&#039;text/javascript&#039;&gt;
    var chartParams = {
 &quot;dom&quot;: &quot;chart156f57a77be16&quot;,
&quot;width&quot;:    450,
&quot;height&quot;:    300,
&quot;layers&quot;: [
 {
 &quot;x&quot;: &quot;wt&quot;,
&quot;y&quot;: &quot;mpg&quot;,
&quot;data&quot;: {
 &quot;mpg&quot;: [     21,     21,   22.8,   21.4,   18.7,   18.1,   14.3,   24.4,   22.8,   19.2,   17.8,   16.4,   17.3,   15.2,   10.4,   10.4,   14.7,   32.4,   30.4,   33.9,   21.5,   15.5,   15.2,   13.3,   19.2,   27.3,     26,   30.4,   15.8,   19.7,     15,   21.4 ],
&quot;cyl&quot;: [ &quot;6&quot;, &quot;6&quot;, &quot;4&quot;, &quot;6&quot;, &quot;8&quot;, &quot;6&quot;, &quot;8&quot;, &quot;4&quot;, &quot;4&quot;, &quot;6&quot;, &quot;6&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;4&quot;, &quot;4&quot;, &quot;4&quot;, &quot;4&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;8&quot;, &quot;4&quot;, &quot;4&quot;, &quot;4&quot;, &quot;8&quot;, &quot;6&quot;, &quot;8&quot;, &quot;4&quot; ],
&quot;disp&quot;: [    160,    160,    108,    258,    360,    225,    360,  146.7,  140.8,  167.6,  167.6,  275.8,  275.8,  275.8,    472,    460,    440,   78.7,   75.7,   71.1,  120.1,    318,    304,    350,    400,     79,  120.3,   95.1,    351,    145,    301,    121 ],
&quot;hp&quot;: [    110,    110,     93,    110,    175,    105,    245,     62,     95,    123,    123,    180,    180,    180,    205,    215,    230,     66,     52,     65,     97,    150,    150,    245,    175,     66,     91,    113,    264,    175,    335,    109 ],
&quot;drat&quot;: [    3.9,    3.9,   3.85,   3.08,   3.15,   2.76,   3.21,   3.69,   3.92,   3.92,   3.92,   3.07,   3.07,   3.07,   2.93,      3,   3.23,   4.08,   4.93,   4.22,    3.7,   2.76,   3.15,   3.73,   3.08,   4.08,   4.43,   3.77,   4.22,   3.62,   3.54,   4.11 ],
&quot;wt&quot;: [   2.62,  2.875,   2.32,  3.215,   3.44,   3.46,   3.57,   3.19,   3.15,   3.44,   3.44,   4.07,   3.73,   3.78,   5.25,  5.424,  5.345,    2.2,  1.615,  1.835,  2.465,   3.52,  3.435,   3.84,  3.845,  1.935,   2.14,  1.513,   3.17,   2.77,   3.57,   2.78 ],
&quot;qsec&quot;: [  16.46,  17.02,  18.61,  19.44,  17.02,  20.22,  15.84,     20,   22.9,   18.3,   18.9,   17.4,   17.6,     18,  17.98,  17.82,  17.42,  19.47,  18.52,   19.9,  20.01,  16.87,   17.3,  15.41,  17.05,   18.9,   16.7,   16.9,   14.5,   15.5,   14.6,   18.6 ],
&quot;vs&quot;: [      0,      0,      1,      1,      0,      1,      0,      1,      1,      1,      1,      0,      0,      0,      0,      0,      0,      1,      1,      1,      1,      0,      0,      0,      0,      1,      0,      1,      0,      0,      0,      1 ],
&quot;am&quot;: [ &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;0&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot;, &quot;1&quot; ],
&quot;gear&quot;: [      4,      4,      4,      3,      3,      3,      3,      4,      4,      4,      4,      3,      3,      3,      3,      3,      3,      4,      4,      4,      3,      3,      3,      3,      3,      4,      5,      5,      5,      5,      5,      4 ],
&quot;carb&quot;: [      4,      4,      1,      1,      2,      1,      4,      2,      2,      4,      4,      3,      3,      3,      4,      4,      4,      1,      2,      1,      1,      2,      2,      4,      2,      1,      2,      2,      4,      6,      8,      2 ] 
},
&quot;facet&quot;: null,
&quot;color&quot;: &quot;cyl&quot;,
&quot;type&quot;: &quot;point&quot; 
} 
],
&quot;facet&quot;: [],
&quot;guides&quot;: [],
&quot;coord&quot;: [],
&quot;id&quot;: &quot;chart156f57a77be16&quot; 
}
    _.each(chartParams.layers, function(el){
        el.data = polyjs.data(el.data)
    })
    var graph_chart156f57a77be16 = polyjs.chart(chartParams);
&lt;/script&gt;
    
    &lt;script&gt;&lt;/script&gt;    
  &lt;/body&gt;
&lt;/html&gt; ' scrolling='no' frameBorder='0' seamless class='rChart  polycharts  ' id='iframe-chart156f57a77be16'> </iframe>
 <style>iframe.rChart{ width: 100%; height: 400px;}</style>

**plotly**


{% highlight r %}
# This works, but is not evaluated now. Instead the iframe is embedded manually.
py$ggplotly(scatter.ggplot, session="knitr")
{% endhighlight %}

<iframe height="400" id="igraph" scrolling="no" seamless="seamless" src="https://plot.ly/~ouzor/34/mpg-vs-wt/" width="450" frameBorder="0"></iframe>

**googleVis**


{% highlight r %}
# Spread data to show the wanted scatter plot (unique id required for unique rows)
mtcars$id <- as.character(1:nrow(mtcars))
mtcars.temp <- tidyr::spread(mtcars[c("wt", "mpg", "cyl", "id")], key=cyl, value=mpg)
gvis.options <- list(hAxis="{title:'wt'}", vAxis="{title:'mpg'}",
                     width=img.width, height=img.height)
scatter.gvis <- gvisScatterChart(select(mtcars.temp, -id), options=gvis.options)
print(scatter.gvis, tag="chart")
{% endhighlight %}

<!-- ScatterChart generated in R 3.1.2 by googleVis 0.5.6 package -->
<!-- Wed Jan 14 17:22:44 2015 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataScatterChartID156f5424adf0f () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 1.513,
30.4,
null,
null 
],
[
 1.615,
30.4,
null,
null 
],
[
 1.835,
33.9,
null,
null 
],
[
 1.935,
27.3,
null,
null 
],
[
 2.14,
26,
null,
null 
],
[
 2.2,
32.4,
null,
null 
],
[
 2.32,
22.8,
null,
null 
],
[
 2.465,
21.5,
null,
null 
],
[
 2.62,
null,
21,
null 
],
[
 2.77,
null,
19.7,
null 
],
[
 2.78,
21.4,
null,
null 
],
[
 2.875,
null,
21,
null 
],
[
 3.15,
22.8,
null,
null 
],
[
 3.17,
null,
null,
15.8 
],
[
 3.19,
24.4,
null,
null 
],
[
 3.215,
null,
21.4,
null 
],
[
 3.435,
null,
null,
15.2 
],
[
 3.44,
null,
19.2,
null 
],
[
 3.44,
null,
17.8,
null 
],
[
 3.44,
null,
null,
18.7 
],
[
 3.46,
null,
18.1,
null 
],
[
 3.52,
null,
null,
15.5 
],
[
 3.57,
null,
null,
15 
],
[
 3.57,
null,
null,
14.3 
],
[
 3.73,
null,
null,
17.3 
],
[
 3.78,
null,
null,
15.2 
],
[
 3.84,
null,
null,
13.3 
],
[
 3.845,
null,
null,
19.2 
],
[
 4.07,
null,
null,
16.4 
],
[
 5.25,
null,
null,
10.4 
],
[
 5.345,
null,
null,
14.7 
],
[
 5.424,
null,
null,
10.4 
] 
];
data.addColumn('number','wt');
data.addColumn('number','4');
data.addColumn('number','6');
data.addColumn('number','8');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartScatterChartID156f5424adf0f() {
var data = gvisDataScatterChartID156f5424adf0f();
var options = {};
options["allowHtml"] = true;
options["hAxis"] = {title:'wt'};
options["vAxis"] = {title:'mpg'};
options["width"] =    450;
options["height"] =    300;

    var chart = new google.visualization.ScatterChart(
    document.getElementById('ScatterChartID156f5424adf0f')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartScatterChartID156f5424adf0f);
})();
function displayChartScatterChartID156f5424adf0f() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartScatterChartID156f5424adf0f"></script>
 
<!-- divChart -->
  
<div id="ScatterChartID156f5424adf0f" 
  style="width: 450; height: 300;">
</div>


## Line plots {#lineplots}

**ggplot**


{% highlight r %}
line.ggplot <- ggplot(mtcars.mean, aes(x=cyl, y=mpg_mean, colour=am)) + 
  geom_line(aes(group=am))
line.ggplot
{% endhighlight %}

![testing](/blog/figs/2014-11-21-interactive-visualizations/line_ggplot-1.png) 

**ggvis**


{% highlight r %}
line.ggvis <- mtcars.mean %>% ggvis(x = ~cyl, y = ~mpg_mean, stroke = ~am) %>% 
  layer_lines() %>% set_options(width = img.width, height = img.height)
line.ggvis
{% endhighlight %}

<!--html_preserve--><div id="plot_id338069126-container" class="ggvis-output-container">
<div id="plot_id338069126" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id338069126_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id338069126" data-renderer="svg">SVG</a>
 | 
<a id="plot_id338069126_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id338069126" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id338069126_download" class="ggvis-download" data-plot-id="plot_id338069126">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id338069126_spec = {
    "data": [
        {
            "name": "mtcars.mean0/group_by1/arrange2_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "mpg_mean": "number"
                }
            },
            "values": "\"cyl\",\"mpg_mean\",\"am\"\n\"4\",22.9,\"0\"\n\"6\",19.125,\"0\"\n\"8\",15.05,\"0\"\n\"4\",28.075,\"1\"\n\"6\",20.5666666666667,\"1\"\n\"8\",15.4,\"1\""
        },
        {
            "name": "mtcars.mean0/group_by1/arrange2",
            "source": "mtcars.mean0/group_by1/arrange2_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.am"
                    ]
                }
            ]
        },
        {
            "name": "scale/stroke",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"0\"\n\"1\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"4\"\n\"6\"\n\"8\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n14.39875\n28.72625"
        }
    ],
    "scales": [
        {
            "name": "stroke",
            "type": "ordinal",
            "domain": {
                "data": "scale/stroke",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": "mtcars.mean0/group_by1/arrange2"
            },
            "marks": [
                {
                    "type": "line",
                    "properties": {
                        "update": {
                            "x": {
                                "scale": "x",
                                "field": "data.cyl"
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.mpg_mean"
                            },
                            "stroke": {
                                "scale": "stroke",
                                "field": "data.am"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": "mtcars.mean0/group_by1/arrange2"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 450,
    "height": 300,
    "legends": [
        {
            "orient": "right",
            "stroke": "stroke",
            "title": "am"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "layer": "back",
            "grid": true,
            "title": "cyl"
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "layer": "back",
            "grid": true,
            "title": "mpg_mean"
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 450,
        "height": 300
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id338069126").parseSpec(plot_id338069126_spec);
</script><!--/html_preserve-->

Does not show up...

**rCharts**


{% highlight r %}
line.rcharts <- hPlot(x="cyl", y="mpg_mean", group="am", data=mtcars.mean, type="line")
# Use this with 'Knit HTML' button
# line.rcharts$print(include_assets=TRUE)
# Use this with jekyll blog
line.rcharts$show('iframesrc', cdn=TRUE)
{% endhighlight %}

<iframe srcdoc=' &lt;!doctype HTML&gt;
&lt;meta charset = &#039;utf-8&#039;&gt;
&lt;html&gt;
  &lt;head&gt;
    
    &lt;script src=&#039;//code.jquery.com/jquery-1.9.1.min.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;//code.highcharts.com/highcharts.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;//code.highcharts.com/highcharts-more.js&quot;&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    &lt;script src=&#039;//code.highcharts.com/modules/exporting.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
    
    &lt;style&gt;
    .rChart {
      display: block;
      margin-left: auto; 
      margin-right: auto;
      width: 450px;
      height: 300px;
    }  
    &lt;/style&gt;
    
  &lt;/head&gt;
  &lt;body &gt;
    
    &lt;div id = &#039;chart156f51cbffdb5&#039; class = &#039;rChart highcharts&#039;&gt;&lt;/div&gt;    
    &lt;script type=&#039;text/javascript&#039;&gt;
    (function($){
        $(function () {
            var chart = new Highcharts.Chart({
 &quot;dom&quot;: &quot;chart156f51cbffdb5&quot;,
&quot;width&quot;:            450,
&quot;height&quot;:            300,
&quot;credits&quot;: {
 &quot;href&quot;: null,
&quot;text&quot;: null 
},
&quot;exporting&quot;: {
 &quot;enabled&quot;: false 
},
&quot;title&quot;: {
 &quot;text&quot;: null 
},
&quot;yAxis&quot;: [
 {
 &quot;title&quot;: {
 &quot;text&quot;: &quot;mpg_mean&quot; 
} 
} 
],
&quot;series&quot;: [
 {
 &quot;data&quot;: [
 [
 &quot;4&quot;,
          22.9 
],
[
 &quot;6&quot;,
        19.125 
],
[
 &quot;8&quot;,
         15.05 
] 
],
&quot;name&quot;: &quot;0&quot;,
&quot;type&quot;: &quot;line&quot;,
&quot;marker&quot;: {
 &quot;radius&quot;:              3 
} 
},
{
 &quot;data&quot;: [
 [
 &quot;4&quot;,
        28.075 
],
[
 &quot;6&quot;,
20.56666666667 
],
[
 &quot;8&quot;,
          15.4 
] 
],
&quot;name&quot;: &quot;1&quot;,
&quot;type&quot;: &quot;line&quot;,
&quot;marker&quot;: {
 &quot;radius&quot;:              3 
} 
} 
],
&quot;xAxis&quot;: [
 {
 &quot;title&quot;: {
 &quot;text&quot;: &quot;cyl&quot; 
},
&quot;categories&quot;: [ &quot;4&quot;, &quot;6&quot;, &quot;8&quot; ] 
} 
],
&quot;subtitle&quot;: {
 &quot;text&quot;: null 
},
&quot;id&quot;: &quot;chart156f51cbffdb5&quot;,
&quot;chart&quot;: {
 &quot;renderTo&quot;: &quot;chart156f51cbffdb5&quot; 
} 
});
        });
    })(jQuery);
&lt;/script&gt;
    
    &lt;script&gt;&lt;/script&gt;    
  &lt;/body&gt;
&lt;/html&gt; ' scrolling='no' frameBorder='0' seamless class='rChart  highcharts  ' id='iframe-chart156f51cbffdb5'> </iframe>
 <style>iframe.rChart{ width: 100%; height: 400px;}</style>

**plotly**


{% highlight r %}
# This works, but is not evaluated now. Instead the iframe is embedded manually.
py$ggplotly(line.ggplot, session="knitr")
{% endhighlight %}

<iframe height="400" id="igraph" scrolling="no" seamless="seamless" src="https://plot.ly/~ouzor/35/mpg-mean-vs-cyl/" width="450" frameBorder="0"></iframe>

**googleVis**


{% highlight r %}
# Spread data to show the wanted line plot
mtcars.mean.temp <- tidyr::spread(mtcars.mean, key=am, value=mpg_mean)
gvis.options <- list(hAxis="{title:'cyl'}", vAxis="{title:'mpg_mean'}",
                     width=img.width, height=img.height)
line.gvis <- gvisLineChart(xvar="cyl", yvar=c("0", "1"), data=mtcars.mean.temp, 
                           options=gvis.options)
print(line.gvis, tag="chart")
{% endhighlight %}

<!-- LineChart generated in R 3.1.2 by googleVis 0.5.6 package -->
<!-- Wed Jan 14 17:22:45 2015 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataLineChartID156f5794ef754 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 "4",
22.9,
28.075 
],
[
 "6",
19.125,
20.56666667 
],
[
 "8",
15.05,
15.4 
] 
];
data.addColumn('string','cyl');
data.addColumn('number','0');
data.addColumn('number','1');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartLineChartID156f5794ef754() {
var data = gvisDataLineChartID156f5794ef754();
var options = {};
options["allowHtml"] = true;
options["hAxis"] = {title:'cyl'};
options["vAxis"] = {title:'mpg_mean'};
options["width"] =    450;
options["height"] =    300;

    var chart = new google.visualization.LineChart(
    document.getElementById('LineChartID156f5794ef754')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "corechart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartLineChartID156f5794ef754);
})();
function displayChartLineChartID156f5794ef754() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartLineChartID156f5794ef754"></script>
 
<!-- divChart -->
  
<div id="LineChartID156f5794ef754" 
  style="width: 450; height: 300;">
</div>

## Session info


{% highlight r %}
sessionInfo()
{% endhighlight %}



{% highlight text %}
## R version 3.1.2 (2014-10-31)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] tidyr_0.1        dplyr_0.3.0.2    plotly_0.5.10    ggplot2_1.0.0   
##  [5] RJSONIO_1.3-0    RCurl_1.95-4.3   bitops_1.0-6     rCharts_0.4.5   
##  [9] googleVis_0.5.6  ggvis_0.4.0.9000 knitr_1.8       
## 
## loaded via a namespace (and not attached):
##  [1] assertthat_0.1   colorspace_1.2-4 DBI_0.3.1        digest_0.6.4    
##  [5] evaluate_0.5.5   formatR_1.0      grid_3.1.2       gtable_0.1.2    
##  [9] htmltools_0.2.6  httpuv_1.3.2     jsonlite_0.9.13  labeling_0.3    
## [13] lattice_0.20-29  lazyeval_0.1.9   magrittr_1.0.1   MASS_7.3-35     
## [17] mime_0.2         munsell_0.4.2    parallel_3.1.2   plyr_1.8.1      
## [21] proto_0.3-10     R6_2.0           Rcpp_0.11.3      reshape2_1.4    
## [25] scales_0.2.4     shiny_0.10.2.1   stringr_0.6.2    tools_3.1.2     
## [29] whisker_0.3-2    xtable_1.7-4     yaml_2.1.13
{% endhighlight %}

