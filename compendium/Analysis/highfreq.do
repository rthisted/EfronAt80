// input and examine high-frequency (x>100) words from Spevack
version 15.1
set seed 8847105

infile x nx using ../Raw/highFreqSpevack.txt, clear
gen nxsum=sum(nx)
di nxsum[_N]
di nxsum[91]
di nxsum[8]
di nxsum[91]-nxsum[8]
di nxsum[203]-nxsum[91]
di nxsum[337]-nxsum[203]
di nxsum[452]-nxsum[337]

gen sign = (-1)^(x+1)
gen signnx = sign*nx
gen sumalt = sum(signnx)
di sumalt[_N]

save ../Data/highfreq, replace
