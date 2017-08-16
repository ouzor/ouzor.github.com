---
title: "New Paper on Predictive Toxicogenomics"
subtitle: "The final act of my academic career (at least for now)"
layout: post
tags: [datascience, healthcare, research]
fb-img: http://ouzor.github.io/blog/figs/2017-08-14-predictive-toxicogenomics-paper/toxgen_eyediagram.png
---

I’m co-authoring a new paper titled "[A transcriptomics data-driven gene space accurately predicts liver cytopathology and drug-induced liver injury](https://doi.org/10.1038/ncomms15932)", published in July in Nature Communications. This work was included as a manuscript in my doctoral thesis and I’m extremely happy to see it finally published in a high-profile journal with open access.

The significance of the work lies in the potential to replace toxicology tests carried on animals with a combination of in vitro (cell line) measurements and advanced statistical data analysis and machine learning. In addition to reducing requirements for animal testing, this would notably decrease the costs of drug development. 

The paper applies probabilistic modelling to combine gene expression measurements from cell lines treated with a large set of drug molecules (the [Connectivity Map](https://www.broadinstitute.org/connectivity-map-cmap) data set) with toxicology data from partly same molecules and cell lines (the [NCI-60](https://dtp.cancer.gov/discovery_development/nci-60/) data set). By combining advanced statistical methods with large data sets, we were able to provide a comprehensive picture into the relations between molecular drug responses and toxicological outcomes. These relations can then be applied to predict toxicity for new molecules. 

<center>
<img src="/blog/figs/2017-08-14-predictive-toxicogenomics-paper/toxgen_eyediagram.png" alt="Component model visualisation">

<br>
<em>An <a href="https://github.com/ouzor/eyediagram">"Eye Diagram"</a> visualisation of the component model that describes statistical associations between molecular drug responses and toxicological outcomes. Picture: Juuso Parkkinen, Aalto University.</em>
</center>

The research was a joint collaboration between Aalto university, Karolinska Institute and the Institute for Molecular Medicine Finland (FIMM). The authors: [Pekka Kohonen](https://twitter.com/PKohonen), [Egon Willighagen](https://twitter.com/egonwillighagen), Rebecca Ceder, Krister Wennerberg, Samuel Kaski (my thesis supervisor) and Roland Grafström.

The research project leading to this publication was a long journey that taught me a lot. Collaborating with medicine and toxicology experts was a great experience, where we gradually developed common understanding of the types of problems we could try solving with advanced statistical methods, and finally were able to create exciting results. These experiences have also been valuable in my career as a data scientist. 

The paper has been covered in a [blog post](https://chem-bla-ics.blogspot.fi/2017/07/new-paper-transcriptomics-data-driven.html) by Egon Willighagen, and in news pieces
by [MedicalXpress](https://medicalxpress.com/news/2017-08-statistical-component-associations-chemicals-toxicological.html), [Aalto University](http://www.aalto.fi/en/current/news/2017-08-10/) and [Karolinska Institute](http://ki.se/imm/genrymd-for-toxiska-reaktioner-forutsager-risk-for-leverskada). Here's also the [Altmetric tracking](https://www.altmetric.com/details/21486207) page for the paper. 

<script type="text/javascript" src="https://d1bxh8uas1mnw7.cloudfront.net/assets/embed.js">
</script><div class="altmetric-embed" data-badge-type="donut" data-altmetric-id="21486207" />


