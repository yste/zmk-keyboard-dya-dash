.PHONY: init build-all clean build debug


build-all: build build-reset

build: build-left build-right build-left-ball build-right-ball

build-left:
	bash local_build.sh left
build-right:
	bash local_build.sh right
build-left-ball:
	bash local_build.sh left-ball
build-right-ball:
	bash local_build.sh right-ball

build-reset: build-left-reset build-right-reset

build-left-reset:
	bash local_build.sh left -r
build-right-reset:
	bash local_build.sh right -r

init:
	west init -l config
	west update --narrow

clean:
	rm -rf .west build external

clean-build:
	rm -rf build
