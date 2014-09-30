---
layout: blog
title: Archives
section: Past
---

# Archives

All blog posts in reverse chronological order.

{% for post in site.categories.blog %}
<div class="section list">
  <h1>{{ post.date | date_to_string }}</h1>
  <p class="line">
  <a class="title" href="{{ post.url }}">{{ post.title }}</a>
  <a class="comments" href="{{ post.url }}#disqus_thread">View Comments</a>
  </p>
  <p class="excerpt">{{ post.excerpt }}</p>
</div>
{% endfor %}


<!-- Tags, following http://stackoverflow.com/questions/1408824/an-easy-way-to-support-tags-in-a-jekyll-blog -->

All blog posts by tags.

{% capture tags %}
  {% for tag in site.tags %}
    {{ tag[0] }}
  {% endfor %}
{% endcapture %}
{% assign sortedtags = tags | split:' ' | sort %}

{% for tag in sortedtags %}
<div class="section list">
  <h1> {{ tag }}</h1>
  <ul>
  {% for post in site.tags[tag] %}
    <li><a class="title" href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
  </ul>
</div>


{% endfor %}
