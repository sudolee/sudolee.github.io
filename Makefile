all:
	bundle exec rake generate

deploy:
	$(shell [ ! -d _deploy ] && git clone --single-branch https://github.com/sudolee/sudolee.github.io.git _deploy)
	bundle exec rake deploy

preview:
	cd public
	bundle exec rake preview

install_oct2:
	bundle exec rake install[oct2]

install_classic:
	bundle exec rake install[classic]

github_pages:
	bundle exec rake setup_github_pages

updateOctopress:
	git remote add octopress git://github.com/imathis/octopress.git
	git pull
	git remote remove octopress
