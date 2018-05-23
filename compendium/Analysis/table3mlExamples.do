version 15.1
set more off
set seed 99574774

clear
capture program drop et et1
run et
run et1
infile nx using ../Raw/Table1-list.txt, clear
gen x=_n

// calculate using beta parameterization
ml model d0 et (nx=) () in 1/40
ml init eq1:_cons=-0.4 eq2:_cons=50
ml maximize, nolog
scalar gamma = _b[#2:_cons]/(1+_b[#2:_cons])
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma) "  Gamma= " %7.5f gamma

// get standard error for gamma hat and for Delta-hat(1)
nlcom _b[#2:_cons]/(1+_b[#2:_cons])
nlcom -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma)

// repeat without supplying initial values
ml model d0 et (nx=) () in 1/40
ml maximize, nolog
scalar gamma = _b[#2:_cons]/(1+_b[#2:_cons])
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma) "  Gamma= " %7.5f gamma

// repeat using gamma parameterization
ml model d0 et1 (nx=) () in 1/40
ml maximize, nolog
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+_b[#2:_cons])^(-_b[_cons]) -1)/(_b[_cons]*_b[#2:_cons])

// repeat calculations using corrected frequency counts to x_0=100 from Spevack
infile x nx using ../Raw/lowFreqSpevack.txt, clear
ml model d0 et (nx=) () in 1/40
ml init eq1:_cons=-0.4 eq2:_cons=50
ml maximize, nolog
scalar gamma = _b[#2:_cons]/(1+_b[#2:_cons])
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma) "  Gamma= " %7.5f gamma
nlcom -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma)
