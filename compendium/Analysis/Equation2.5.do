// explore possibilities for the miscalculation of Delta-hat(1)
// in expression (2.5) of ET 
version 15.1
set more off
set seed 995874121

// load the ET data table
use ../Data/table1, clear
gen nsigned = n*(-1)^(x+1)
// total contains the running alternating sum of frequencies to give (2.5)
// The last entry in the column gives the answer, which ET reports as 11430.
gen total = sum(nsigned)
di total[_N]

// calculate the total number of words in Table 1 of ET
gen foo=sum(n)
di foo[100]

// and add in the 846 words with frequencies x>100
di foo[100]+846

twoway scatter total x if x>4, yline(11430) msize(tiny) ///
   yti("Delta hat (1)") xti("x") ti("Estimated number of new words") ///
   name(delta1hat, replace)
graph export ../Figures/delta1hat.pdf, replace

// generate smoothed version by doing running means of 2
gen ma = (total[_n-1]+total[_n])/2
two scatter ma  x if x>4, yline(11430) msize(tiny) ///
   yti("Delta hat (1)") xti("x") ti("Smoothed estimated number of new words") ///
   name(delta1hatma, replace)
 graph export ../Figures/delta1hatma.pdf, replace

 // what if x_{33} was accidentally skipped?
replace nsigned=0 in 33
gen bar=sum(nsigned)
replace nsigned=56 in 33

di bar[100]

// here we reload the ET data table
use ../Data/table1, clear
rename n nx
count

list in l
gen nxsum=sum(nx)

gen sign = (-1)^(x+1)
gen signnx = sign*nx
gen sumalt = sum(signnx)
gsort - x
gen revsumalt = sum(signnx)
sort x

list in 1/5
list in -5/l

// this explores the possibility of an inadvertent parity error between
// x=37 and x=38, that gets propagated

gen errsign = (-1)^(x+1+(x>=38))
gen errsignnx = errsign*nx
gen errsumalt = sum(errsignnx)
list in l

// repeat for the hand-archived table

// here we load the hand-written frequency counts from Thisted's archives
use ../Data/table1-hand-archived, clear
rename n nx
count

list in l
gen nxsum=sum(nx)

gen sign = (-1)^(x+1)
gen signnx = sign*nx
gen sumalt = sum(signnx)
gsort - x
gen revsumalt = sum(signnx)
sort x

list in 1/5
list in -5/l

// and finally, we do the calculation on the first 100 actual Spevack counts
infile x nx using ../Raw/lowFreqSpevack.txt, clear
count
list in l

gen nxsum=sum(nx)

gen sign = (-1)^(x+1)
gen signnx = sign*nx
gen sumalt = sum(signnx)
gsort - x
gen revsumalt = sum(signnx)
sort x

list in 1/5
list in -5/l

