---
layout: blog
title: Home
section: Home
---

Thoughts on Open Sata Science
==========================================

This is [Juuso](/)'s blog on data science and open knowledge. 

More [information](info.html) about this blog and a complete archive of [past](past.html) posts, are available via links at the top of the page.

You can also subscribe to an [atom feed][] of the most recent posts.

[atom feed]: /blog/atom.xml

<a href="/blog/atom.xml"><img src="/images/rss.png" alt="Atom Feed" style="height: 2em; margin-right:2.5em;" class="right"/></a>

Recent Posts
------------

{% for post in site.categories.blog limit:5 %}
<div class="section list">
  <h1>{{ post.date | date_to_string }}</h1>
  <p class="line">
  <a class="title" href="{{ post.url }}">{{ post.title }}</a>
  <a class="comments" href="{{ post.url }}#disqus_thread">View Comments</a>
  </p>
  <p class="excerpt">{{ post.excerpt }}</p>
</div>
{% endfor %}

<p>
<a href="past.html">Older Posts &rarr;</a>
</p>

<!-- Add DISQUS stuff from mark/iem/index.markdown -->
