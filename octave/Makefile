
all: 	cd_plot1.pdf \
		cd_plot2.pdf \
		dc_plot1.pdf \
		dc_plot2.pdf \
		dd_plot1.pdf \
		dd_plot2.pdf \
		em_plot1.pdf \
		em_plot2.pdf \
		em_plot3.pdf \
		em_plot4.pdf \
		cl_ff01.pdf

%.eps: %.m
	octave --silent $<

%.pdf: %.eps
	epspdf $<

clean:
	-rm -f *.eps
	-rm -f *.pdf
