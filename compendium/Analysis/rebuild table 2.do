version 15.1
set more off
set seed 9948285

// Table 2
use ../Data/table1,clear
drop in 11/l
set obs 10

local eta1 = 14376
local alpha = -0.3954
local gamma =  0.9905

gen eta = `eta1'
replace eta = eta[_n-1]*(_n-1+`alpha')*`gamma'/_n in 2/l

format eta %6.0f
order x eta n
list, noobs sep(0)

// Fitted value for eta-hat-1 under NB with x0==40
use ../Data/table1, clear
drop in 41/l
set obs 40

local eta1 = 14376
local alpha = -0.3954
local gamma =  0.9905

gen eta = `eta1'
replace eta = eta[_n-1]*(_n-1+`alpha')*`gamma'/_n in 2/l

gen etasum=sum(eta)
gen nsum=sum(n)
local ntot=nsum[_N]
local etot=etasum[_N]

local ratio = `ntot'/`etot'

di `ntot' "  " `etot'
replace eta = eta*`ratio'

di %6.0f eta[1] "   ratio = " %7.4f `ratio'

// Delta-hat-40(1) from NB model

local delta   = -`eta1'*((1+`gamma')^(-`alpha')-1)/(`gamma'*`alpha')
local delta10 = -`eta1'*((1+`gamma'*10)^(-`alpha')-1)/(`gamma'*`alpha')


di _newline ///
    "Estimated Delta(1)  from x0=40 NB model is " `delta' _newline ///
    "Estimated Delta(10) from x0=40 NB model is " `delta10' 
	

