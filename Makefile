all: linearAlgebra.pdf

%.pdf: %.tex
	lualatex --shell-escape $<
	lualatex --shell-escape $<

install:
	rm -rf build
	mkdir build
	cp *.pdf build
