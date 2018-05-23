version 15.1
set more off
set seed 6719352

// ET NB estimate of Delta(1)
local alpha = -0.3954
local gamma =  0.9905
display "Delta-hat(1) [ET] = " %6.0f -14376*((1+`gamma')^(-`alpha')-1)/(`gamma'*`alpha')

// NB estimate of Delta(1) based on x_0=40 MLEs
// parameter values taken from Example output
local alpha = -0.3973074
local beta  = 112.2214
scalar gamma =  `beta'/(1+`beta')
display "Delta-hat(1) [ML] = " %6.0f -14376*((1+gamma)^(-`alpha')-1)/(gamma*`alpha')


