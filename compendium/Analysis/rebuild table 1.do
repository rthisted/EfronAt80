version 15.1
set more off
set seed 996742

// read row-wise data from Table 1 OCR'd PDF, with decade indicator -i-
infile i n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 using ../Raw/table1.txt, clear
list

// confirm row totals as a check on OCR process
gen rowtotal = n1+n2+n3+n4+n5+n6+n7+n8+n9+n10
list

drop rowtotal
reshape long n, i(i) j(j)

gen x=i+j
drop i j
order x n
list in 1/15

save ../Data/table1, replace

// repeat the process for the (slightly different) data table on the hand-
// written page in Thisted's archive

// read row-wise data from Table 1 OCR'd PDF, with decade indicator -i-
infile i n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 using ../Raw/table1-hand-archived.txt, clear
list

// confirm row totals as a check on OCR process
gen rowtotal = n1+n2+n3+n4+n5+n6+n7+n8+n9+n10
list

drop rowtotal
reshape long n, i(i) j(j)

gen x=i+j
drop i j
order x n
list in 1/15

save ../Data/table1-hand-archived, replace
