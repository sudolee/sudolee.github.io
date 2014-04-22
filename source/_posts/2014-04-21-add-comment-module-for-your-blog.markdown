---
layout: post
title: "为你的blog添加评论模块"
date: 2014-04-21 20:38:55 +0800
comments: true
categories: [blog, octopress, comments]
---


有了评论模块，你就可以和志同道合的人一起讨论，也是获取观众建议的快捷方式。这里提供两种评论模块的配置方法：[https://disqus.com](https://disqus.com/)和[http://duoshuo.com](http://duoshuo.com/)

<!--more-->

## disqus
*Disqus是一家第三方社会化评论系统，主要为网站主提供评论托管服务。octopress已经支持了disqus的评论模块(见：`octopress/.themes/themename/source/_includes/post/disqus_thread.html`)，只需要简单的设置就可以工作。*

### 在[https://disqus.com](https://disqus.com/)注册
注册disqus非常简单，只要有邮箱就可以。注册完成后，登录之。 

### 在disqus创建域名
进入网址[http://disqus.com/admin/create](http://disqus.com/admin/create/)。创建你的域名，`site name`和`disqus url`要保持一致，这个就是稍后在octopress配置文件_config.yml里的`disqus_short_name`.

### 在_config.yml设置新的`disqus_short_name`
```
# _config.yml
# Disqus Comments
disqus_short_name: yourshortname
disqus_show_comment_count: false
```
重新`rake generate`就可以看到包含评论模块的blog。

## 多说
[多说](http://duoshuo.com/)(WordPress)是一款追求极致体验的社会化评论框，可以用微博、QQ、人人、豆瓣等帐号登录并评论。因为它支持国内一些常用的社交网站，所以比较流行。

**注：**多说网的注册这里不再累述。

### 在多说网创建域名
多说网域名的创建不太好找，它在这里[http://duoshuo.com/create-site](http://duoshuo.com/create-site)，创建域名后就可以获取`short_name`.  
`站点名称`和`多说域名`采用统一的字符串，如：`duoshuoshortname`，那么站点地址就设置为：`duoshuoshortname.com`。  
这里的域名就是short_name。

### 在_config.yml设置新的`duoshuo_short_name`
在`_config.yml`里添加多说`short_name`和多说评论开关。
```
# _config.yml
# Duoshuo Comments
duoshuo_comments: true
duoshuo_short_name: duoshuoshortname
```

### 在每个post的页面添加多说模块
* 在`source/_layouts/post.html`添加如下代码:
``` html
｛% if site.duoshuo_comments == true and site.duoshuo_short_name and page.comments == true %｝
  <section>
    <h1>- Comments -</h1>
    <div id="comments" aria-live="polite">｛% include post/duoshuo.html %｝</div>
  </section>
｛% endif %｝
```
这段代码检查`_config.yml`里`duoshuo_comments: true`和`duoshuo_short_name`如果被设置就包含后面的网页`post/duoshuo.html`.  
**注意:** 这段代码里的"{"和"}"都是中文字符，在实际代码中需要替换为英文字符。

* 创建`post/duoshuo.html`
``` js
<div class="ds-thread"></div>
<script type="text/javascript">
var duoshuoQuery = {short_name:"yourduoshuoshortname"};
	(function() {
		var ds = document.createElement('script');
		ds.type = 'text/javascript';ds.async = true;
		ds.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//static.duoshuo.com/embed.js';
		ds.charset = 'UTF-8';
		(document.getElementsByTagName('head')[0] 
		 || document.getElementsByTagName('body')[0]).appendChild(ds);
	})();
</script>
```
重新`rake generate`就可以看到包含评论模块的blog。
