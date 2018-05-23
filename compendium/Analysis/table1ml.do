version 15.1
set more off
set seed 99574774

clear
capture program drop et et1
run et
run et1
infile nx using ../Raw/Table1-list.txt, clear
gen x=_n
gen unit=1

ml model d0 et (nx=) () in 1/5
ml init eq1:_cons=-0.4 eq2:_cons=50
ml maximize, nolog
scalar gamma = _b[#2:_cons]/(1+_b[#2:_cons])
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma) "  Gamma= " %7.5f gamma

ml model d0 et (nx=) () in 1/10
ml init eq1:_cons=-0.4 eq2:_cons=50
ml maximize, nolog
scalar gamma = _b[#2:_cons]/(1+_b[#2:_cons])
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma) "  Gamma= " %7.5f gamma

ml model d0 et (nx=) () in 1/15
ml init eq1:_cons=-0.4 eq2:_cons=50
ml maximize, nolog
scalar gamma = _b[#2:_cons]/(1+_b[#2:_cons])
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma) "  Gamma= " %7.5f gamma

ml model d0 et (nx=) () in 1/20
ml init eq1:_cons=-0.4 eq2:_cons=50
ml maximize, nolog
scalar gamma = _b[#2:_cons]/(1+_b[#2:_cons])
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma) "  Gamma= " %7.5f gamma

ml model d0 et (nx=) () in 1/30
ml init eq1:_cons=-0.4 eq2:_cons=50
ml maximize, nolog
scalar gamma = _b[#2:_cons]/(1+_b[#2:_cons])
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma) "  Gamma= " %7.5f gamma

ml model d0 et (nx=) () in 1/40
ml init eq1:_cons=-0.4 eq2:_cons=50
ml maximize, nolog
scalar gamma = _b[#2:_cons]/(1+_b[#2:_cons])
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma) "  Gamma= " %7.5f gamma

ml model d0 et (nx=) () in 1/100
ml init eq1:_cons=-0.4 eq2:_cons=50
ml maximize, nolog
scalar gamma = _b[#2:_cons]/(1+_b[#2:_cons])
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+gamma)^(-_b[_cons]) -1)/(_b[_cons]*gamma) "  Gamma= " %7.5f gamma


// ---------  Using gamma parameterization, which should be slightly less stable

ml model d0 et1 (nx=) () in 1/5
ml init eq1:_cons=-0.4 eq2:_cons=.9
ml maximize, nolog
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+_b[#2:_cons])^(-_b[_cons]) -1)/(_b[_cons]*_b[#2:_cons])

ml model d0 et1 (nx=) () in 1/10
ml init eq1:_cons=-0.4 eq2:_cons=.9
ml maximize, nolog
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+_b[#2:_cons])^(-_b[_cons]) -1)/(_b[_cons]*_b[#2:_cons])

ml model d0 et1 (nx=) () in 1/15
ml init eq1:_cons=-0.4 eq2:_cons=.9
ml maximize, nolog
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+_b[#2:_cons])^(-_b[_cons]) -1)/(_b[_cons]*_b[#2:_cons])

ml model d0 et1 (nx=) () in 1/20
ml init eq1:_cons=-0.4 eq2:_cons=.9
ml maximize, nolog
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+_b[#2:_cons])^(-_b[_cons]) -1)/(_b[_cons]*_b[#2:_cons])

ml model d0 et1 (nx=) () in 1/30
ml init eq1:_cons=-0.4 eq2:_cons=.9
ml maximize, nolog
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+_b[#2:_cons])^(-_b[_cons]) -1)/(_b[_cons]*_b[#2:_cons])

ml model d0 et1 (nx=) () in 1/40
ml init eq1:_cons=-0.4 eq2:_cons=.9
ml maximize, nolog
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+_b[#2:_cons])^(-_b[_cons]) -1)/(_b[_cons]*_b[#2:_cons])

ml model d0 et1 (nx=) () in 1/100
ml init eq1:_cons=-0.4 eq2:_cons=.9
ml maximize, nolog
di "Delta-hat_ml(1)= " %8.0f -nx[1]*((1+_b[#2:_cons])^(-_b[_cons]) -1)/(_b[_cons]*_b[#2:_cons])
