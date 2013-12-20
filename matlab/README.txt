
matlab/

DESCRIPTION
-----------

These M-Files are used to perform the calculations and produce
the plots for the main document.  They were all built and tested
using Octave but most of them work with Matlab as well.

To build all the files run:

  $ make

MODELS
------

  cd_* - Steady state to discrete calculations.
  cd_*

  cl_* - Control Law Designs

  dc_* - Discrete to steady state calculations.
  dc_*

  dd_* - Direct design controllers.

  em_* - Engine model plots and calculations.
		 All controllers are for this plant/model.

FUNCTIONS
---------

  engine_model.m - Linear engine model.

  sylvester.m - Calculate nth order Sylvester matrix.

  zerotime.m - Reset cummulative times to start at zero.

  lsim1.m - lsim1 that also removes small values which skew results.

  rpmtime.m - Convert rpm's to time.

