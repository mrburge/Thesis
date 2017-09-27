
set more off 

insheet using mainRegressionHotelStata.csv 

xtset metrosegment year, yearly 

label variable demandvolatility "Demand Volatility" 
label variable logwage "Log(Avg. Salary)" 
label variable logrent "Log(Fair Market Rent 3-bedroom)"
label variable logelecprice "Log(Avg. Electricity Price)" 
label variable logpipc "Log(Personal Income/capita)"
label variable logempllh "Log(Emp in Leisure \& Hospitality)"
label variable ur "Unemployment Rate" 
label variable logllhsqmile "Log(Emp in Leisure \& Hospitality/sq. mile)"
label variable logllhshare "Log(Share of Total Emp in Leisure \& Hospitality)"
label variable logpi "Log(Personal Income)"
label variable logpi5yr "5 year log diff in Personal Income" 
label variable logpipc5yr "5 year log diff in Personal Income/capita"
label variable logempllh5yr "5 year log diff in Emp in Leisure \& Hospitality" 

eststo model1: regress logcaputil demandvolatility, vce(cluster metro)
estadd ysumm
estadd local hasfe " "
estadd local hascon " "
estadd local drop7 " "
estadd local drop08 " "
estadd local hasiv " "
estadd local empiv " "

eststo model2: regress logcaputil demandvolatility logwage logrent logelecprice logpipc logpi logempllh ur logllhshare logllhsqmile logpipc5yr logpi5yr logempllh5yr i.segment i.year, vce(cluster metro)
estadd ysumm
estadd local hasfe "Yes"
estadd local hascon "Yes"
estadd local drop7 " "
estadd local drop08 " "
estadd local hasiv " "
estadd local empiv " "

eststo model3: ivregress 2sls logcaputil logwage logrent logelecprice logpipc logpi logempllh ur logllhshare logllhsqmile logpipc5yr logpi5yr logempllh5yr i.segment i.year (demandvolatility = instrument), vce(cluster metro) first
estadd ysumm
estadd local hasfe "Yes"
estadd local hascon "Yes"
estadd local drop7 " "
estadd local drop08 " "
estadd local hasiv "Yes"
estadd local empiv " "
estat endogenous 
estadd scalar haus = r(p_regF)
estat firststage
matrix F3 = r(singleresults)
estadd scalar r2first = F3[1,2]

eststo model4: ivregress 2sls logcaputil logwage logrent logelecprice logpipc logpi logempllh ur logllhshare logllhsqmile logpipc5yr logpi5yr logempllh5yr i.segment i.year (demandvolatility = instrument) if segment~=7, vce(cluster metro) first
estadd ysumm
estadd local hasfe "Yes"
estadd local hascon "Yes"
estadd local drop7 "Yes"
estadd local drop08 " "
estadd local hasiv "Yes"
estadd local empiv " "
estat endogenous 
estadd scalar haus = r(p_regF)
estat firststage
matrix F4 = r(singleresults)
estadd scalar r2first = F4[1,2]

eststo model5: ivregress 2sls logcaputil logwage logrent logelecprice logpipc logpi logempllh ur logllhshare logllhsqmile logpipc5yr logpi5yr logempllh5yr i.segment i.year (demandvolatility = instrument) if year~=2008, vce(cluster metro) first
estadd ysumm
estadd local hasfe "Yes"
estadd local hascon "Yes"
estadd local drop7 " "
estadd local drop08 "Yes"
estadd local hasiv "Yes"
estadd local empiv " "
estat endogenous 
estadd scalar haus = r(p_regF)
estat firststage
matrix F5 = r(singleresults)
estadd scalar r2first = F5[1,2]

eststo model6: ivregress 2sls logcaputil logwage logrent logelecprice logpipc logpi logempllh ur logllhshare logllhsqmile logpipc5yr logpi5yr logempllh5yr i.segment i.year (demandvolatility = empinstrument), vce(cluster metro) first
estadd ysumm
estadd local hasfe "Yes"
estadd local hascon "Yes"
estadd local drop7 " "
estadd local drop08 " "
estadd local hasiv "Yes"
estadd local empiv "Yes"
estat endogenous 
estadd scalar haus = r(p_regF)
estat firststage
matrix F6 = r(singleresults)
estadd scalar r2first = F6[1,2]


esttab model1 model2 model3 model4 model5 model6 using ..\..\sections\mainRegressionHotelsCoefs.tex, b(%5.2f) se(%5.2f) stats(ymean, fmt(2) labels("Dep. Variable Mean")) replace nostar mtitles("(a)" "(b)" "(c)" "(d)" "(e)" "(f)") nodepvars label keep(demandvolatility) fragment nonumbers nonotes

esttab model1 model2 model3 model4 model5 model6 using ..\..\sections\mainRegressionHotelsLabels.tex, cells(none) stats(hasfe hascon drop7 drop08 hasiv empiv, fmt(%-3s %-3s %-3s %-3s %-3s %-3s) labels("Year/Segment FEs" "Controls" "Drop Independents" "Drop 2008" "Instrument" "Use Employment")) replace nostar nomtitles nodepvars fragment nonumbers nonotes nolines

esttab model1 model2 model3 model4 model5 model6 using ..\..\sections\mainRegressionHotelsStats.tex, cells(none) stats(haus r2first r2_a N, fmt(2 2 2 0) labels("Hausman Test" "Adj. R-squared (1st Stage)" "Adj. R-squared" "Num. Observations")) replace nostar nomtitles nodepvars fragment nonumbers nonotes nolines

esttab model2 model3 model4 model5 model6 using ..\..\sections\mainRegressionHotelsControlCoefs.tex, b(%5.2f) se(%5.2f) replace nostar mtitles("(b)" "(c)" "(d)" "(e)" "(f)") nodepvars label keep(logwage logrent logelecprice logpipc logpi logempllh ur logllhshare logllhsqmile logpipc5yr logpi5yr logempllh5yr) fragment noobs nonumbers nonotes


