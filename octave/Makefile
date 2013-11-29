
all: cd1_plot.pdf cd2_plot.pdf

%.eps: %.m
	octave $<

%.pdf: %.eps
	epspdf $<

clean:
	-rm -f *.eps
	-rm -f cd1_plot.pdf

