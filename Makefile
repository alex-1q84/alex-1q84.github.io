
preview: build
	raco frog -p

build:
	raco frog -b

setup:
	raco frog --init

clean:
	rm -rf 20* About.html feeds index.html posts sitemap.txt tags
