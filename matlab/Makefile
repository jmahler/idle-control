
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
		cl_ff01.pdf \
		cl_fonp02.pdf cl_fonp03.pdf \
		cd_plot1.eps \
		cd_plot2.eps \
		dc_plot1.eps \
		dc_plot2.eps \
		dd_plot1.eps \
		dd_plot2.eps \
		em_plot1.eps \
		em_plot2.eps \
		em_plot3.eps \
		em_plot4.eps \
		cl_ff01.eps \
		cl_fonp02.eps cl_fonp03.eps

%.eps: %.m
	octave --silent $<

%.pdf: %.eps
	epspdf $<

clean:
	-rm -f *.eps
	-rm -f *.pdf
	-rm -f *.ps
