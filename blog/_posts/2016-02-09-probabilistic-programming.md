---
title: "Stan - The Bayesian Data Scientist's Best Friend"
subtitle: "Introduction to Probabilistic Programming and Stan"
layout: post
tags: [datascience, Stan]
---

The choice of tools in practical data science projects is often restricted into ones that are easy and fast to implement and that work efficiently. Traditionally this has ruled out for example most Bayesian data analysis techniques, as they involve laborious statistical inference procedures. This is about to change with the help of probabilistic programming languages (PPL). In this post I'll give an introduction to probabilistic programming and especially Bayesian PPL called Stan, based on a presentations given by Professor [Aki Vehtari](http://users.aalto.fi/~ave/) and others from the [Aalto Probabilistic Machine Learning](http://research.cs.aalto.fi/pml/) research group.

<center>
<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Introduction to Probabilistic Programming and <a href="https://twitter.com/mcmc_stan">@mcmc_stan</a> by <a href="https://twitter.com/avehtari">@avehtari</a> from <a href="https://twitter.com/hashtag/AaltoPML?src=hash">#AaltoPML</a>- full house! <a href="https://t.co/Navv4VyHxK">pic.twitter.com/Navv4VyHxK</a></p>&mdash; Juuso Parkkinen (@ouzor) <a href="https://twitter.com/ouzor/status/695570618289418240">February 5, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
</center>

According to [Wikipedia](https://en.wikipedia.org/wiki/Probabilistic_programming_language), *probabilistic programming languages are designed to describe probabilistic models and then perform inference on those models*. The language and software are tailored for probabilistic models with cleaner notation and support for the whole workflow from model specification to visualisation of results. Most effort is spent on making the model inference phase as automatic and efficient as possible. 

Together these properties make PPLs very useful tools for a wide range of users. They make applied statistics and machine learning work more efficient, and for less experienced ones they provide access to a wide variety of models. For researchers developing new models, they provide an easy and flexible way to prototype different model variants. PPLs also make publishing model specifications easier, thus promoting reproducibility and open science.

A good overview of available PPLs can be found at [Probabilistic-programming.org](http://probabilistic-programming.org/wiki/Home). In the rest of the post I will focus on [Stan](http://mc-stan.org/). Also [PyMC3](https://pymc-devs.github.io/pymc3/) is worth checking for Python users. 

## Stan goes NUTS


[Stan](http://mc-stan.org/) is a probabilistic programming language and software for describing data and model for Bayesian inference. After the description, the software makes the required computation automatically using state-of-the-art techniques including automatic differentiation, [Hamiltonian Monte Carlo](https://theclevermachine.wordpress.com/2012/11/18/mcmc-hamiltonian-monte-carlo-a-k-a-hybrid-monte-carlo/), [No-U-turn Sampler (NUTS)](http://www.stat.columbia.edu/~gelman/research/published/nuts.pdf), [automatic variational inference (ADVI)](http://arxiv.org/abs/1506.03431). Stan also provides extensive diagnostics for the inference.  

Here's an example of a simple Bernoulli model written in the Stan language:

<pre><code>
data {
  int <lower=0> N;
  int <lower=0,upper=1> y[N];
}
parameters {
  real <lower=0,upper=1> theta;
}
model {
  theta ~ beta(1,1);
  y ~ bernoulli(theta);
}
</code></pre>

Models written in Stan language are compiled to C++, which makes the inference faster and also allows easy portability to other languages. Stan already has [interfaces](http://mc-stan.org/interfaces/) for common data science languages, including [RStan](http://mc-stan.org/interfaces/rstan.html) and [PyStan](http://mc-stan.org/interfaces/pystan.html). For R users there is also the new [rstanarm package](https://cran.rstudio.com/web/packages/rstanarm/), which extends many commonly used statistical modelling tools, such as generalised linear models, providing options to specify priors and perform full posterior inference. 

Aki, who recently joined the [Stan Development Team](http://mc-stan.org/team/), covered Stan's features extensively in his presentation. More information on many of these can be found in the [Stan documentation](http://mc-stan.org/documentation/), and for example [these slides by Bob Carpenter](http://andrewgelman.com/wp-content/uploads/2015/07/darpa-ppaml-2015.pdf). The [developer mailing list](https://groups.google.com/forum/#!forum/stan-dev) is also a good source for information on recent developments. Aki also gave hints of interesting future developments, including Gaussian Processes, better adaptations and diagnostics, Riemannian HMC, distributed computing, and data streaming. 

Several research examples were mentioned that use Stan, including [hierarchical survival analysis by Peltola *et al.*](http://becs.aalto.fi/en/research/bayes/diabcvd/) and [nonlinear pharmacometric models by Weber *et al.*](http://arxiv.org/abs/1602.02055) - Stan can handle ordinary differential equations as well! We have also used Stan at [Reaktor](http://reaktor.com/) in the apartment price modelling and visualisation  [Kannattaakokauppa.fi](http://kannattaakokauppa.fi/#/en/): 

<center>
<img src="/blog/figs/2016-02-09-probabilistic-programming/kannattaakokauppa_screenshot.png" alt="None" width="600">

<br>
<em>Screenshot of <a href="http://kannattaakokauppa.fi/#/en/">Kannattaakokauppa.fi</a>, showing regional trends in apartment prices in Finland. For a thorough description of the model and data used, see <a href="http://ropengov.github.io/r/2015/06/11/apartment-prices/">here</a>.</em>
</center>

One practical issue that has been challenging researchers and practitioners is how to assess predictive performance, for instance to compare different models. For this, Aki and [Andrew Gelman](http://andrewgelman.com/) have recently developed the [Pareto smoothed importance sampling leave-one-out cross-validation](http://arxiv.org/abs/1507.04544) procedure. It is implemented in the [R package loo](https://cran.r-project.org/web/packages/loo/index.html), which looks great and useful for me personally.

Although Stan already provides efficient inference for a wide range of models, it has its limitations. It does not yet provide support for discrete parameters, which restricts the available model families (if discrete parameters cannot be easily marginalized out). Hierarchical models often suffer from inefficiencies due to distributions with difficult posterior geometries, and in many cases reparameterization can help (see details in the manual). Other sources of problems can be highly non-linear dependency structures (leading to banana-shaped, curved posteriors), multi-modal posterior distributions, and long-tailed distributions. 

One key building block in Stan is the [math library](https://github.com/stan-dev/math), and especially the automatic differentiation method used in gradient computations. [Automatic differentation](https://en.wikipedia.org/wiki/Automatic_differentiation) refers to a set of techniques for numerically evaluating the derivative of any function. Two main methods are called forward-mode and backward-mode (or reverse-mode) autodiff. Alternatives for automatic differentiation are symbolic (used e.g. by [Mathematica / Wolfram](https://reference.wolfram.com/language/tutorial/SymbolicCalculations.html)) and numeric differentiation. These are however not suitable for probabilistic programming, as they are either restricted in types of distributions they can handle (non-programmatic, symbolic) or slow and inaccurate (numeric). 

Stan uses reverse-mode automatic differentiation, which is faster than forward-mode when the output dimensionality (typically 1 in probabilistic programming context) is smaller than the input dimensionality (can be very high). Currently Stan only solves 1st order derivatives, but 2nd and 3rd order are coming in the future (already available in [Github](https://github.com/stan-dev/stan)). Stan's autodiff is optimised for functions often used in Bayesian statistics and has been proven more efficient than most other autodiff libraries. 


## Tools of the future

Personally I am very excited to see how Stan and rstanarm can help to incorporate Bayesian statistics into my daily work. In general I believe these kinds of flexible probabilistic programming tools will be very useful for applied statisticians, machine learners, and data scientists, extending their statistical modelling capabilities and improving their efficiency. 

*I'd like to thank my friend and colleague [Janne Sinkkonen](https://twitter.com/euxoa), whose comments helped me to improve this post.*
