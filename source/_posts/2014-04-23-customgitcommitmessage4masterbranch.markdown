---
layout: post
title: "自定义octopress博客master分支的git提交信息"
date: 2014-04-23 00:47:09 +0800
comments: true
categories: [octopress, rake, git, makefile]
---

## 背景
octopress提供了快速部署blog的方法，但是在deploy时发现所提交的信息每次都一样，不利于从log上直观的查看提交历史。

<!--more-->

## idea
本来打算从rake命令行给传递参数，但是google了一下，不的要领。所以...
因为自己对ruby不了解，所以想到从Makefile入手(本来已经给source分支添加了Makefile以方便操作), 将log写入文件。然后从rakefile里面获取Makefile的结果。

## 在Makefile里创建log
``` makefile
# Makefile
deploy:
	$(shell [ ! -d _deploy ] && git clone --single-branch https://github.com/sudolee/sudolee.github.io.git _deploy)
	@ [[ -n $$MSG ]] || { echo 'Pls set git commit message via: make deploy MSG="some commit"'; exit 1; }
	echo "${MSG}" > .mygitcommitmsg
	bundle exec rake deploy
```
这段代码检查makefile命令行所传递的message，如果没有就报错退出。
如果MSG被传递进来就将其输出到本地文件`.mygicommitmsg`。

## 在Rakefile里读取log
``` diff
-    puts "\n## Committing: Site updated at #{Time.now.utc}"
-    message = "Site updated at #{Time.now.utc}"
+    fgitcommitmsg = File.new("../.mygitcommitmsg")
+    message = fgitcommitmsg.read
+    puts "\n## Committing: #{message}"
```
* rakefile在执行depoly task的时候会cd到_deploy目录，所以需要制定上层目录  
**Note:**如果在创建的时候直接保存到_deploy目录，在`rake deploy`的时候会一起被提交。
* 从`.mygitcommitmsg`文件读取之前写入的log
