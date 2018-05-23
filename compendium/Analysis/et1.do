program define et1
	// This is the gamma parameterized likelihood
    version 15.1
	args todo b lnf g negH
	tempname alpha gamma psnormalizer nsum
	tempvar lnpxstar pxstar pstarsum nxsum llcomponent llsum nxtemp
	mleval `alpha'  = `b', scalar eq(1)
	mleval `gamma'  = `b', scalar eq(2)
	// di `alpha' " " `beta' " " `gamma'
	qui gen double `lnpxstar' = lngamma(x+`alpha') ///
	                           +(x-1)*ln(`gamma') ///
							   - lnfactorial(x)   ///
							   -lngamma(1+`alpha') if $ML_samp==1
	qui gen double `pxstar'   = exp(`lnpxstar') if $ML_samp==1
	qui gen double `pstarsum' = sum(`pxstar')
	scalar `psnormalizer' = `pstarsum'[_N]
	qui gen double `nxtemp' = $ML_y1*$ML_samp
	qui gen double `nxsum'  = sum(`nxtemp')
	scalar `nsum' = `nxsum'[_N]
	qui gen double `llcomponent' = $ML_y1*`lnpxstar'*$ML_samp
	qui gen double `llsum' = sum(`llcomponent')
	scalar `lnf' = `llsum'[_N]-ln(`psnormalizer')*`nsum'	
end

