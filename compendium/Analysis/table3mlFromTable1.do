version 15.1
set more off
set seed 99574774

clear

// load the maximum likelihood defining program
// (first deleting any version that already exists)
capture program drop et
run et

// read in the data, generate index numbers -x-,
//      and calculate running sums of frequency counts
infile nx using ../Raw/Table1-list.txt, clear
gen x=_n
gen nxsum=sum(nx)

// This uses the beta-parameterized likelihood for the computations
// "qui" is an abbreviation for 'quietly', which suppresses output
// "noi" is an abbreviation for 'noisily', which forces output

quietly {
noisily di _newline " x0 sum nx    alpha    gamma    beta   chisq"

foreach x0 in 5 10 15 20 30 40 100 {
   // first obtain mle's for NB model based on first x0 word counts
   qui ml model d0 et (nx=) () in 1/`x0'
   qui ml init eq1:_cons=-0.4 eq2:_cons=.9
   qui ml maximize, nolog
   
   // calculate saturated log likelihood for chi-squared computation
   // here, e(ll) is the log likelihood returned from the MLE calculation
   qui gen double satll= nx*ln(nx)
   qui gen double sumsatll = sum(satll)
   scalar SLL = sumsatll[`x0']-nxsum[`x0']*ln(nxsum[`x0'])
   drop satll sumsatll
   scalar chisq = -2*(e(ll)-SLL)
   
   // finally calculate the value for gamma-hat from the estimate for beta-hat
   scalar gamma = _b[#2:_cons]/(1+_b[#2:_cons])
   
   // ... and display the results for comparison to Table 3 of ET
   noi display %3.0f `x0' %7.0f nxsum[`x0'] %9.4f _b[_cons] ///
               %9.4f gamma %8.2f _b[#2:_cons] %8.3f chisq
}
}
