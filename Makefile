
parts=00_int 01_weak  02_esr-sco 03_us 04_esr-scod 05_concl 99_incl
parts_a=auto 99_incl

TEXs=$(parts:%=%.tex)
aTEXs=$(parts_a:%=%.tex)
PDFs=$(TEXs:.tex=.pdf)


all: images auto text


auto: images auto.pdf
auto_b: images auto_b.pdf

text:  text.pdf


all_pdfs: $(PDFs)

images:
	make -C images

text.bbl: bibl.bib
	latex text
	bibtex text || true
	latex text
	latex text

auto.bbl my.bbl:
	latex auto
	bibtex auto || true
	bibtex my || true
	latex auto
	latex auto

# for book printing uncomment 'twoside' options in auto.tex
auto_b.ps: auto.ps
	psbook $< | psnup -l -pa4 -2 > auto_b.ps;


%.spell:  # %.bak
	aspell -d ru -c  $*

spell: $(TEXs:%=%.spell)
aspell: $(aTEXs:%=%.spell)


text.dvi: text.tex text.bbl  ${parts:=.tex}
	make -C images
	latex $<

auto.dvi: auto.tex auto.bbl my.bbl ${parts_a:=.tex}
	make -C images
	latex $<

%.pdf: %.ps
	ps2pdf $<

%.ps: %.dvi
	dvips $<

%.dvi: %.tex
	make -C images
	latex $<


clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.dvi *.eps *.pdf *.bbl *.blg *.ps
	make clean -C images


distclean: clean
	rm -f *.pdf


.PHONY:  images auto.tex text.tex bibl.bib
