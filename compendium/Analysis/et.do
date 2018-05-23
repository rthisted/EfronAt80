program define et
    // This is the beta parameterized likelihood
	// Assumption: the index x for each frequency count is stored in a variable
	//             in the dataset named -x-
	//              (this is because I couldn't figure out how to pass it to
	//              the maximizer as a parameter)
    version 15.1                                // Stata version
	args todo b lnf g negH                      // standard Stata ML parameters
	
	// set up local variable names for use here
	tempname alpha beta gamma psnormalizer nsum
	tempvar lnpxstar pxstar pstarsum nxsum llcomponent llsum nxtemp
	
	// obtain current estimates for alpha and beta from the passed parameters
	mleval `alpha' = `b', scalar eq(1)
	mleval `beta'  = `b', scalar eq(2)
	
	// infer the value of gamma
	scalar `gamma' = `beta'/(1+`beta')
	
	// calculate unnormalized log likelihood contribution from counts of
	// words with frequency x
	// All calculations are done 'quietly' ("qui") to suppress  results of
	//     intermediate calculations during iterations
	qui gen double `lnpxstar' = lngamma(x+`alpha') ///
	                           +(x-1)*ln(`gamma') ///
	                           - lnfactorial(x)   ///
	                           -lngamma(1+`alpha') if $ML_samp==1
	// calculate the norming constant to make probabilities sum to one
	qui gen double `pxstar'   = exp(`lnpxstar') if $ML_samp==1
	qui gen double `pstarsum' = sum(`pxstar')
	scalar `psnormalizer' = `pstarsum'[_N]
	
	// zero out any counts for x>x0, and calculate sum of counts
	qui gen double `nxtemp' = $ML_y1*$ML_samp
	qui gen double `nxsum'  = sum(`nxtemp')
	scalar `nsum' = `nxsum'[_N]
	
	// finally calculate the actual log likelihood contribution of each row,
	//     add them up, and return them, normalized appropriately
	qui gen double `llcomponent' = $ML_y1*`lnpxstar'*$ML_samp
	qui gen double `llsum' = sum(`llcomponent')
	scalar `lnf' = `llsum'[_N]-ln(`psnormalizer')*`nsum'	
end

