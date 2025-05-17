.PHONY: init clean build debug

build: build-left build-right

build-left:
	bash local_build.sh left
build-right:
	bash local_build.sh right -s

debug:
	bash local_build.sh left -d
	bash local_build.sh right -sd

init:
	west init -l config
	west update --narrow

clean:
	rm -rf .west build external
