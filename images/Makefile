pics=$(patsubst %.fig,%,$(wildcard *.fig))

all: ${pics:=.tex} ${pics:=.eps}

%.png: %.fig
	fig2dev -Lpng -j -m3.75 $< $@

%.eps: %.fig
	fig2dev -Lpstex -j $< $@

%.tex: %.fig
	fig2dev -Lpstex_t -p ${@:.tex=.eps} -j $< $@

clean:
	rm -f *.tex  *.eps
