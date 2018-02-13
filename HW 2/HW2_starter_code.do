/****************************************************************************** 
* Stata program: 	S17_hw2.do
* --------------
*
* Author: 			Philip Luck (philip.luck@ucdenver.edu)
* -------
*
* Date: 			2/1/17
* ----
*
******************************************************************************/
	
	/*****************************************************************
	* (1) Setup basic stata environment variables
	*****************************************************************/
		#delimit cr 		// make carriage return the command delimiter
		clear				//clear data in memory
		clear all			//clear all variables in memory
		set more off		//turn the "more" option for screen output off


		//path for the dataset
		local dataPath "C:\Users\cliffr\Desktop\Econometrics_GIT\MacroEcon\HW 2\pwt90.dta"
		
		//paths for picture files
		local picsPath "C:\Users\cliffr\Desktop\Econometrics_GIT\MacroEcon\HW 2\"
		
		
	/*****************************************************************
	* (2) Load PWT and prepare data
	*****************************************************************/
			
			use `dataPath'/pwt81.dta
			
			
			//only keep selected variables
			keep year countrycode country cgdpe pop ck
			//keep if year==2010
			
			//compute output per person
			gen ypop = cgdpe/pop
			
			//compute capital per person
			gen kpop = ck/pop
			
			
			//divide output by output in the USA\
				//Step 1: Make has missing values except for the USA.
					gen _ypop_USA = ypop if countrycode=="USA"
				
				//Step 2: Within each year, take the average across countries of
				//this auxiliary variable. Since only the USA has a non-missing
				//value the mean will be equal to exactly that value.
					by year, sort: egen ypop_USA = mean(_ypop_USA)
				
				//Step 3: divide Y/L by this this new variable that has the USA value stored
					gen ypop_rel = ypop/ypop_USA
				//Step 4: drop the quxiliary variables. I commented this
				//out for now because I want you to see what is in those
				//variables. But in general it is good practice to delete
				//auxiliary variables that you don't need for anything.
					//drop _ypop_USA ypop_USA
				
			//divide capital by capital in the USA (same as above for capital
				gen _kpop_USA = kpop if countrycode=="USA"
				by year, sort: egen kpop_USA = mean(_kpop_USA)
				gen kpop_rel = kpop/kpop_USA
				//drop kpop_USA _kpop_USA
			
			
			/*
			This loop below does the same steps as above except I only
			had to write the the four steps once even though I computed it
			for two variables. This is "commented out" because we
			already did these steps above "by hand". Feel free to try it with 
			the above code, running the loop instead.
			*/
			
			/*
			local vars "ypop kpop"
			foreach v of local vars {
			
				gen _`v'_USA = `v' if countrycode=="USA"
				by year, sort: egen `v'_USA = mean(_`v'_USA)
				gen `v'_rel = `v'/`v'_USA
				drop _`v'_USA
				
			}
			
			*/
			
			
			//predicted output
			local alpha=1/3
			local eta=0.21875 
			local gamma=1/2
			
			gen ypred_rel = kpop_rel^(alpha)
			label variable ypred_rel "Prediction Cobb-Douglas (A=1)"
			
			gen ypred2_rel = (`gamma'*(kpop_rel)^`eta' + (1-`gamma'))^(1/`eta')
			label variable ypred2_rel "Prediction CES (A=1)"
			
			
			//implied A
			gen A = ypop_rel/ypred_rel
			gen ln_A = ln(A)
			label variable ln_A "Cobb-Douglas (TFP)"
			
			
			gen A2 = ((ypop_rel^`eta' - (1-`gamma'))/(`gamma'*kpop_rel^`eta'))^(1/`eta')
			gen ln_A2 = ln(A2)
			label variable ln_A2 "CES (Capital Augmenting)"
			
			gen A3 = ypop_rel/ypred2_rel
			gen ln_A3 = ln(A3)
			label variable ln_A3 "CES (TFP)"
			
			gen A4 = (ypop_rel/ypred2_rel)^(1/alpha)
			gen ln_A4 = ln(A4)
			label variable ln_A4 "Cobb-Douglas (Capital Augmenting)"
			
			
			
			//take logs (now with a loop)
			local lvars "ypop ypred ypred2 kpop"
			foreach v of local lvars {
			
				gen ln_`v'_rel = ln(`v'_rel) //take the natural log of each variable in the list above
			}
			
			label variable ln_ypred_rel "Prediction Cobb-Douglas (A=1)"
			label variable ln_ypred2_rel "Prediction CES (A=1)"
			
	
						
								
		
