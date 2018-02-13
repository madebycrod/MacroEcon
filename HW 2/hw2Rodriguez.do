/****************************************************************************** 
* Stata program: 	scratch.do
* --------------
*
* Author: 			Cliff Rodriguez (cliff.rodriguez@ucdenver.edu)
* -------
*
* Date: 			2/11/18
* ----
*
******************************************************************************/
	
	/*****************************************************************
	* (1) Setup basic stata environment variables
	*****************************************************************/
		
		clear				//clear data in memory
		clear all			//clear all variables in memory
		set more off		//turn the "more" option for screen output off
		
	/*****************************************************************
	* (2) Load PWT and prepare data
	*****************************************************************/
	
			use "C:\Users\cliffr\Desktop\Econometrics_GIT\MacroEcon\HW 2\pwt90.dta"
			
			
			//only keep selected variables
			keep year countrycode country cgdpe pop ck
			//keep if year==2011
			
			//compute output per person
			gen ypop = cgdpe/pop
			
			//compute capital per person
			gen kpop = ck/pop

			
			//create varaible for USA ypop
			gen _ypop_USA = ypop if countrycode=="USA"
			
			//take average across countries using _ypop_USA
			by year, sort: egen ypop_USA = mean(_ypop_USA)
			
			//create relative variable using ypop_USA
			gen ypop_rel = ypop/ypop_USA
			
			
			//create varaible for USA kpop
			gen _kpop_USA = ypop if countrycode=="USA"
			
			//take average across countries using _ypop_USA
			by year, sort: egen kpop_USA = mean(_kpop_USA)
			
			//create relative variable using ypop_USA
			gen kpop_rel = kpop/kpop_USA
						
	/*****************************************************************
	* (3) Generate Model(s) Variables
	*****************************************************************/	
	
		//Multi-use Variables
		gen a = 1
		
		// Cobb-Douglas Variables //
		// F(K,L) = A(K^alpha)(L^(1-alpha)) //
		
		gen alpha = 1/3		
		gen ypred_rel = kpop_rel^(alpha)
		label variable ypred_rel "Prediction Cobb-Douglas (A=1)"	
		
			
		// CES Variables //
		// F(K,L) = ((gamma(AK)^n + (1-gamma)L^n)^(1/n))
		gen gamma = .5
		gen n = .21875
		
		gen ypred2_rel = (gamma*(kpop_rel)^n + (1-gamma))^(1/n)
		label variable ypred2_rel "Prediction CES (A=1)"
	
		//implied A
		gen A = ypop_rel/ypred_rel
		gen ln_A = ln(A)
		label variable ln_A "Cobb-Douglas (TFP)"
		
		
		gen A2 = ((ypop_rel^n - (1-gamma))/(gamma*kpop_rel^n))^(1/n)
		gen ln_A2 = ln(A2)
		label variable ln_A2 "CES (Capital Augmenting)"
		
		gen A3 = ypop_rel/ypred2_rel
		gen ln_A3 = ln(A3)
		label variable ln_A3 "CES (TFP)"
		
		gen A4 = (ypop_rel/ypred2_rel)^(1/alpha)
		gen ln_A4 = ln(A4)
		label variable ln_A4 "Cobb-Douglas (Capital Augmenting)"
		
		
		// Take Logs//
		gen ln_ypop_rel = ln(ypop_rel)
		
		gen ln_ypred_rel = ln(ypred_rel)
				
		gen ln_ypred2_rel = ln(ypred2_rel)
		
		gen ln_kpop_rel = ln(kpop_rel)
		
		
// Section for table //

	//List items 
	
	list country ypop_rel kpop_rel ypred_rel ypred2_rel ln_A ln_A3 ln_A2 ln_A4

		
// Add in if statement to country to filter for 
	// China, Chile, India, Norway, Switzerland, Greece, United States, 
	// Japan, United Kingdom, Spain
	//if country == "China" | country =="Norway"
	
	//Generate Slide 31 Graphic 1
	twoway (scatter ypred_rel kpop_rel)(scatter ypred2_rel kpop_rel) 
	
	//Generate Slide 31 Graphic 2
	twoway (scatter ln_ypred2_rel ln_ypop_rel)(scatter ln_ypred_rel ln_ypop_rel)
	
	//Generate Slide 34 Graphic
	twoway (scatter ln_A4 ln_ypop_rel)(scatter ln_A3 ln_ypop_rel)(scatter ln_A2 ln_ypop_rel)(scatter ln_A ln_ypop_rel)
	
