// input and examine actual word counts from Spevack
version 15.1
set seed 8847105

pwd
ls ../Raw
infile x nx using ../Raw/highFreqSpevack.txt, clear
save ../Data/highFreqSpevack, replace
infile x nx using ../Raw/lowFreqSpevack.txt, clear
save ../Data/lowFreqSpevack, replace
append using ../Data/highFreqSpevack

gen nxsum=sum(nx)

gen sign = (-1)^(x+1)
gen signnx = sign*nx
gen sumalt = sum(signnx)

di nxsum[100]  "  " nxsum[_N]
// This correponds to equation (2.5)
di sumalt[100] "  " sumalt[_N]
