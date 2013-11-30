
all: cd1_plot.pdf cd2_plot.pdf \
		dc1_plot.pdf dc2_plot.pdf \
		engine_model_plot.pdf

%.eps: %.m
	octave $<

%.pdf: %.eps
	epspdf $<

clean:
	-rm -f *.eps
	-rm -f cd1_plot.pdf cd2_plot.pdf
	-rm -f dc1_plot.pdf dc2_plot.pdf

