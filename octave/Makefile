
all: cd1_plot.pdf cd2_plot.pdf \
		dc1_plot.pdf dc2_plot.pdf \
		engine_model_plot.pdf \
		engine_model_rpmtime_plot.pdf \
		stable_rpm_plot.pdf \
		norm_engine_model_plot.pdf \
		norm_engine_plot_close.pdf

%.eps: %.m
	octave $<

%.pdf: %.eps
	epspdf $<

clean:
	-rm -f *.eps
	-rm -f *.pdf
