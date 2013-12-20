
all: main.pdf

main.pdf: main.tex
	cd ../matlab; make
	pdflatex main.tex
	biber main
	#makeglossaries main
	#makeindex main.idx
	pdflatex main.tex

clean:
	-rm -f *.aux *.log *.blg *.bbl *.toc *.lof *.bcf
	-rm -f *.out *-blx.bib *.xml
	-rm -f *.idx *.ilg *.ind *.idl
	-rm -f main.pdf
