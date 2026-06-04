
preview: build
	raco frog -wp

build:
	raco frog -b

setup:
	raco frog --init

deps:
	raco pkg install --auto frog || true
	pip3 install pygments

clean:
	raco frog -c
	rm -rf 20* About.html CLAUDE.html feeds index.html posts sitemap.txt tags
