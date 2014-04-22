---
layout: post
title: "用GithubPages和octopress部署blog"
date: 2014-04-20 16:35:14 +0800
comments: true
categories: [github pages, octopress, blog]
---

*一直想自己搭建一个blog，但又因购买域名和租用服务器之麻烦没有实现。最近看到github上推出了github page服务，于是跃跃欲试。之前对git和markdown比较熟悉，所以搭建起来也没什么困难。好吧，总算是个良好的开始。*

<!--more-->

## github pages
![github](https://pages.github.com/favicon.ico)  
`github pages`可以用git托管blog的静态网页，还可以自定义域名。

### 创建主页
#### 创建个人/组织主页
创建新的仓库，并以*username*.github.io命名，*username*是你在github上的用户/组织名。  
`git clone https://github.com/username/username.github.io`
#### 创建项目主页
项目主页的创建只需要创建一个新的名为`gh-pages`的分支即可。
**注**: github提供了自动生成项目主页的方法，并提供了一些漂亮的模板可供选择。

参考: [https://pages.github.com](https://pages.github.com/)

## octopress
![octopress](http://octopress.org/octopress-favicon.png)  
octopress是基于Jekyll博客引擎的一个框架。官方定义为：`A blogging framework for hackers`，可以生成github pages的静态网页。
官方提供了详尽的[文档](http://octopress.org/docs/)，这里只是记录配置的大致步骤。

## 安装ruby & git
* ubuntu: apt-get install ruby git-core
* archlinux: pacman -S ruby git

## 获取和安装Octopress
```
git clone git://github.com/imathis/octopress.git
cd octopress
```
### 安装octopress的依赖
```
gem install bundler
rbenv rehash    # If you use rbenv, rehash to be able to run the bundle command
bundle install
```
### 安装octopress的默认主题
`rake install`

**注意:** 我在archlinux上安装的时候因为本地的rake版本太新了，运行时出错。按照提示，在`rake install`前加上`bundle exec`前缀就能正常运行了。

## 配置octopress
`octopress`的作者使得它的配置尽量的简单，大多数情况下只需要修改`_config.yml`和`Rakefile`就可以正常工作了。
`Rakefile`是blog部署相关的配置，除非使用`rsync`，否则不需要修改。

`_config.yml`是**jekyll**的主要配置文件，`octopress`对其作了一些定制，其中有三大配置项：`Main Configs`， `Jekyll & Plugins` 和 `3rd Party Settings`。
最基本的配置只需要修改`_config.yml`的以下字段就可以了：
```
url:                # For rewriting urls for RSS, etc
title:              # Used in the header and title tags
subtitle:           # A description used in the header
author:             # Your name, for RSS, Copyright, Metadata
```
更多配置，请移步：[Configuring Octopress](http://octopress.org/docs/configuring/)

## 将博客部署到github上
### rake task for github pages
`rake setup_github_pages`
这个task会要求你输入github仓库的URL。如：`https://github.com/sudolee/sudolee.github.io.git`
这条命令将完成以下工作:  
> 要求你输入github pages的仓库url，并存储之。
> 将原来的octopress的git仓库重命名为`octopress`。
> 把你的github pages的仓库设置为默认的远程仓库`origin。
> 从当前分支`master`切换到`source`分支。
> 根据你的github pages仓库配置blog的url。
> clone你的远程仓库到`_deploy`目录，用于部署你的blog。

### 生成静态网页
* 运行命令`rake generate`将以`source`为源，生成静态blog网页保存在`public`目录，并copy到目录`_deploy`。
**注：** 如果你使用了比较新的rake，可能会提示*在你的命令前加上前缀`bundle exec`以解决问题*。

### 提交新主页
* 现在你可以运行`rake deploy`将`_deploy`目录的内容提交到你的github仓库，提交后就可以展现新的blog。
* 运行`rake preview`命令，可以在本地浏览器`http://127.0.0.1:4000`预览呈现效果。

## 开始写blog
博文必须存放在目录 `source/_posts`，并以Jekyll的命名方式`YYYY-MM-DD-post-title.markdown`。
octopress提供了一些rake task，用来以正确的命名格式创建新的博文，并附件一些有用的yaml元数据。语法如下：
`rake new_post["title"]`
`title`是博文的主题，`new_post`会创建一个包含这个主题的文件。默认的扩展名是`markdown`，可以在`Rakefile`里配置不同的扩展名。
例如：
`rake new_post["用github pages和octopress部署blog"]`
运行这条命令将会在生成博文源文件：`source/_posts/2014-04-20-yong-github-pageshe-octopressbu-shu-blog.markdown`

打开这个文件，可以看到像下面这样的yaml元数据(告诉jekyll博客引擎如何处理博文和页面)：
```
---
layout: post
title: "用github pages和octopress部署blog"
date: 2014-04-20 16:24:59 +0800
comments: true
categories: 
---
```
编辑这个文件，就可以撰写博文。完成后用小节**将博客部署到github上**的方法部署或预览博文。

更多内容，请移步：[Blogging Basics](http://octopress.org/docs/blogging)
