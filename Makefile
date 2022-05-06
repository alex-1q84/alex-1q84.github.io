
preview: build
	raco frog -wp

build:
	raco frog -b

setup:
	raco frog --init

clean:
	raco frog -c
	rm -rf 20* About.html feeds index.html posts sitemap.txt tags
