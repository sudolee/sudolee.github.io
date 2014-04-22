all:
	cp -rfv orig_post/* source/_posts/
	bundle exec rake generate

deploy:
	bundle exec rake deploy

preview:
	cd public
	bundle exec rake preview

install_oct2:
	bundle exec rake install[oct2]

clean:
	rm -rf source/ public/ sass/

install_classic:
	bundle exec rake install[classic]

github_pages:
	bundle exec rake setup_github_pages

updateOctopress:
	git remote add octopress git://github.com/imathis/octopress.git
	git pull
	git remote remove octopress
