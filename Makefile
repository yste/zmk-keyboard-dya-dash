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

draw-keymap:
	mkdir -p keymap-drawer
	keymap -c keymap_drawer.config.yaml parse -z config/dya_dash.keymap -o keymap-drawer/dya_dash.yaml
	keymap -c keymap_drawer.config.yaml draw keymap-drawer/dya_dash.yaml -j config/dya_dash.json -o keymap-drawer/dya_dash.svg
