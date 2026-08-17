cap log close
use APRS_data, clear
log using APRS_tables.log, replace

gen t2=table_incentive_pr^2 // proportion of table incentivized, squared

**Create new variables with numbers so we can loop more easily
gen auxv1=table_s
gen auxv2=sex_mf
gen auxv3=grade_mod
gen auxv4=black
gen auxv5=hispanic
gen auxv6=free
gen auxv7=grape
gen auxv8=sw
gen auxv9=sc
gen auxv10=grape2
gen y1=sw
gen y2=sc
gen y3=grape2
gen y4=dg

             

********************
**** (1) tables ****
********************


/*
Table 1: table proportion incentivized
*/

tab table_incentive_pr incentive


/*
Table 2: Descriptive statistics by group
*/

matrix table1=J(21,7,.)

forval var=1/6{

sum auxv`var' if group==1
matrix table1[1,`var'+1]=r(mean)
matrix table1[2,`var'+1]=r(sd)
matrix table1[1,1]=r(N)

sum auxv`var' if group==2
matrix table1[3,`var'+1]=r(mean)
matrix table1[4,`var'+1]=r(sd)
matrix table1[3,1]=r(N)

sum auxv`var' if group==3
matrix table1[5,`var'+1]=r(mean)
matrix table1[6,`var'+1]=r(sd)
matrix table1[5,1]=r(N)

sum auxv`var' if group==4
matrix table1[7,`var'+1]=r(mean)
matrix table1[8,`var'+1]=r(sd)
matrix table1[7,1]=r(N)

sum auxv`var' if group==5
matrix table1[9,`var'+1]=r(mean)
matrix table1[10,`var'+1]=r(sd)
matrix table1[9,1]=r(N)

sum auxv`var' if group==6
matrix table1[11,`var'+1]=r(mean)
matrix table1[12,`var'+1]=r(sd)
matrix table1[11,1]=r(N)

sum auxv`var' if group==7
matrix table1[13,`var'+1]=r(mean)
matrix table1[14,`var'+1]=r(sd)
matrix table1[13,1]=r(N)

sum auxv`var' if group==8
matrix table1[15,`var'+1]=r(mean)
matrix table1[16,`var'+1]=r(sd)
matrix table1[15,1]=r(N)

sum auxv`var'
matrix table1[17,`var'+1]=r(mean)
matrix table1[18,`var'+1]=r(sd)
matrix table1[17,1]=r(N)
}

**Test of balance

forval var=1/6 {
xi: qui reg auxv`var' i.strata i.group  ,cluster(cluster)
testparm _Igroup*
mat table1[20,`var'+1]=r(F)
mat table1[21,`var'+1]=r(p)
}





/*
Table 3
*/

**All kids
xi: reg grape incentive i.strata i.table_s i.grade i.sex i.race i.lunch, cl(cluster)
* control group mean
sum grape if incentive==0
**Test differences between public and private
xi: reg grape pub##incentive i.strata i.table_s i.grade i.sex i.race i.lunch, cl(cluster)
lincom 1.pub+1.pub#1.ince




/*
Table 4
*/


qui {
xi: reg dg pub##c.table_incentive_pr incentive##pub i.strata i.table_s i.grade i.sex i.race i.lunch, cl(cluster)
}
lincom table_incentive_pr
lincom 1.pub#c.table_incentive_pr
lincom table_incentive_pr+1.pub#c.table_incentive_pr

qui {
xi: reg dg pub##c.table_incentive_pr incentive##pub i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>0, cl(cluster)
}
lincom table_incentive_pr
lincom 1.pub#c.table_incentive_pr
lincom table_incentive_pr+1.pub#c.table_incentive_pr

qui {
xi: reg dg pub##c.table_incentive_pr incentive##pub i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>.49, cl(cluster)
}
lincom table_incentive_pr
lincom 1.pub#c.table_incentive_pr
lincom table_incentive_pr+1.pub#c.table_incentive_pr


**Average proproportion of table incentivized (only in the grape2 table)
sum table_incentive_pr
sum table_incentive_pr if table_incentive_pr>0
sum table_incentive_pr if table_incentive_pr>.49



/*
Table 6
*/


*************************************************
****    Differential effect of own gender    ****
*************************************************
preserve
keep if nosurvey==0
**All kids
qui xi: reg dg pub##c.table_incentive_pr incentive##pub c.tpr_own##pub i.strata i.table_s i.grade i.sex i.race i.lunch, cluster(cluster)
lincom tpr_own
su dg
qui xi: reg dg pub##c.table_incentive_pr incentive##pub c.tpr_own##pub##incentive i.strata i.table_s i.grade i.sex i.race i.lunch, cluster(cluster)
lincom 1.public#1.incentive#c.tpr_own

**Table incentivized >0
qui xi: reg dg pub##c.table_incentive_pr incentive##pub c.tpr_own##pub i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>0, cluster(cluster)
lincom tpr_own
su dg if table_incentive_pr>0
qui xi: reg dg pub##c.table_incentive_pr incentive##pub c.tpr_own##pub##incentive i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>0, cluster(cluster)
lincom 1.public#1.incentive#c.tpr_own

**Table incentivized >.49
qui xi: reg dg pub##c.table_incentive_pr incentive##pub c.tpr_own##pub i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>.49, cluster(cluster)
lincom tpr_own
su dg if table_incentive_pr>.49
qui xi: reg dg pub##c.table_incentive_pr incentive##pub c.tpr_own##pub##incentive i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>.49, cluster(cluster)
lincom 1.public#1.incentive#c.tpr_own
restore

******************
**Best friends ***
******************
preserve
keep if nosurvey==0 & dbestfriend==1
**All kids
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dbestfriend_i##pub i.strata i.table_s i.grade i.sex i.race i.lunch, cluster(cluster)
lincom 1.dbestfriend_i
su dg
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dbestfriend_i##pub##incentive i.strata i.table_s i.grade i.sex i.race i.lunch, cluster(cluster)
lincom 1.public#1.incentive#1.dbestfriend_i

**Table incentivized >0
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dbestfriend_i##pub i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>0, cluster(cluster)
lincom 1.dbestfriend_i
su dg if table_incentive_pr>0
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dbestfriend_i##pub##incentive i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>0, cluster(cluster)
lincom 1.public#1.incentive#1.dbestfriend_i

**Table incentivized >.49
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dbestfriend_i##pub i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>.49, cluster(cluster)
lincom 1.dbestfriend_i
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dbestfriend_i##pub##incentive i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>.49, cluster(cluster)
lincom 1.public#1.incentive#1.dbestfriend_i
su dg if table_incentive_pr>.49
restore

******************
**Popular kids ***
******************
preserve
keep if nosurvey==0 & dpopular==1
su dg
**All kids
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dpopular_i##pub i.strata i.table_s i.grade i.sex i.race i.lunch, cluster(cluster)
lincom 1.dpopular_i
su dg
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dpopular_i##pub##incentive i.strata i.table_s i.grade i.sex i.race i.lunch, cluster(cluster)
lincom 1.public#1.incentive#1.dpopular_i

**Table incentivized >0
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dpopular_i##pub i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>0, cluster(cluster)
lincom 1.dpopular_i
su dg if table_incentive_pr>0
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dpopular_i##pub##incentive i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>0, cluster(cluster)
lincom 1.public#1.incentive#1.dpopular_i

**Table incentivized >.49
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dpopular_i##pub i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>.49, cluster(cluster)
lincom 1.dpopular_i
qui xi: reg dg pub##c.table_incentive_pr incentive##pub 1.dpopular_i##pub##incentive i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>.49, cluster(cluster)
lincom 1.public#1.incentive#1.dpopular_i
su dg if table_incentive_pr>.49
restore



********************************
****        APPENDIX        ****
********************************


** Table B1
foreach var in sw sc {
xi: reg `var' c.table_incentive_pr##pub incentive##pub i.strata i.table_s i.grade i.sex i.race i.lunch, cl(cluster)
* effects for all kids:
lincom table_incentive_pr
lincom c.table_incentive_pr#1.pub
lincom table_incentive_pr+c.table_incentive_pr#1.pub
xi: reg `var' c.table_incentive_pr##pub##incentive incentive##pub i.strata i.table_s i.grade i.sex i.race i.lunch, cl(cluster)
* effects for non-incentivized kids:
lincom table_incentive_pr
lincom c.table_incentive_pr#1.pub
lincom table_incentive_pr+c.table_incentive_pr#1.pub
* effects for incentivized kids:
lincom table_incentive_pr+1.incentive#c.table_incentive_pr
lincom c.table_incentive_pr#1.pub+1.public#1.incentive#c.table_incentive_pr
lincom table_incentive_pr+c.table_incentive_pr#1.pub+1.incentive#c.table_incentive_pr+1.public#1.incentive#c.table_incentive_pr
* test of whether effect differ for incentivized and non-incentivized kids:
lincom 1.incentive#c.table_incentive_pr
lincom 1.public#1.incentive#c.table_incentive_pr
lincom 1.incentive#c.table_incentive_pr+1.public#1.incentive#c.table_incentive_pr
}


** Table B2
qui xi: reg grape incentive##male i.strata i.table_s i.grade i.race i.lunch, cl(cluster)
lincom 1.incentive
lincom 1.incentive#1.male

qui xi: reg grape incentive##above_grade_median i.strata i.table_s i.grade i.sex i.race i.lunch, cl(cluster)
lincom 1.incentive
lincom 1.incentive#1.above_grade_median


** Table B3
qui {
xi: reg dg pub##c.table_incentive_pr##male incentive##pub i.strata i.table_s i.grade i.race i.lunch, cl(cluster)
}
lincom table_incentive_pr
lincom table_incentive_pr#1.male
lincom 1.pub#c.table_incentive_pr
lincom 1.pub#c.table_incentive_pr#1.male
lincom table_incentive_pr+1.pub#c.table_incentive_pr
lincom table_incentive_pr#1.male+1.pub#c.table_incentive_pr#1.male

qui {
xi: reg dg pub##c.table_incentive_pr##male incentive##pub i.strata i.table_s i.grade i.race i.lunch if table_incentive_pr>0, cl(cluster)
}
lincom table_incentive_pr
lincom table_incentive_pr#1.male
lincom 1.pub#c.table_incentive_pr
lincom 1.pub#c.table_incentive_pr#1.male
lincom table_incentive_pr+1.pub#c.table_incentive_pr
lincom table_incentive_pr#1.male+1.pub#c.table_incentive_pr#1.male

qui {
xi: reg dg pub##c.table_incentive_pr##male incentive##pub i.strata i.table_s i.grade i.race i.lunch if table_incentive_pr>.49, cl(cluster)
}
lincom table_incentive_pr
lincom table_incentive_pr#1.male
lincom 1.pub#c.table_incentive_pr
lincom 1.pub#c.table_incentive_pr#1.male
lincom table_incentive_pr+1.pub#c.table_incentive_pr
lincom table_incentive_pr#1.male+1.pub#c.table_incentive_pr#1.male


** Table B4
qui {
xi: reg dg pub##c.table_incentive_pr##above_grade_median incentive##pub i.strata i.table_s i.grade i.sex i.race i.lunch, cl(cluster)
}
lincom table_incentive_pr
lincom table_incentive_pr#1.above_grade_median
lincom 1.pub#c.table_incentive_pr
lincom 1.pub#c.table_incentive_pr#1.above_grade_median
lincom table_incentive_pr+1.pub#c.table_incentive_pr
lincom table_incentive_pr#1.above_grade_median+1.pub#c.table_incentive_pr#1.above_grade_median

qui {
xi: reg dg pub##c.table_incentive_pr##above_grade_median incentive##pub i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>0, cl(cluster)
}
lincom table_incentive_pr
lincom table_incentive_pr#1.above_grade_median
lincom 1.pub#c.table_incentive_pr
lincom 1.pub#c.table_incentive_pr#1.above_grade_median
lincom table_incentive_pr+1.pub#c.table_incentive_pr
lincom table_incentive_pr#1.above_grade_median+1.pub#c.table_incentive_pr#1.above_grade_median

qui {
xi: reg dg pub##c.table_incentive_pr##above_grade_median incentive##pub i.strata i.table_s i.grade i.sex i.race i.lunch if table_incentive_pr>.49, cl(cluster)
}
lincom table_incentive_pr
lincom table_incentive_pr#1.above_grade_median
lincom 1.pub#c.table_incentive_pr
lincom 1.pub#c.table_incentive_pr#1.above_grade_median
lincom table_incentive_pr+1.pub#c.table_incentive_pr
lincom table_incentive_pr#1.above_grade_median+1.pub#c.table_incentive_pr#1.above_grade_median




*********************
**** (2) figures ****
*********************

/*
Figure 2
*/

global xtitle "Proportion of children incentivized"
global notepartial "Residuals are partialled out from a parametric fit."
global noteconditional "Estimates unconditional on the initial choice of grapes."
global grape2 "Ending up with grapes"
global nonpara "Non-parametric fit."

foreach var in grape2 {
xi: semipar `var' i.strata i.table_size i.grade i.sex i.race i.lunch, nonpar(table_incentive_pr) partial(`var'_hat) nograph robust cluster(table)
}

twoway (lpolyci grape2_hat table_incentive_pr if private==1, level(90) degree(1) lcolor(gs11) fcolor(none) pstyle(p1) clpattern("--...")) ///
(lpolyci grape2_hat table_incentive_pr if private==0, level(90) degree(1) lcolor(black) fcolor(none) pstyle(p2) clpattern(dash)) , ///
ytitle("Final grapes take-up (G2)") xtitle("$xtitle") legend(lab(1 "90% CI") lab(2 "Private" ) lab(3 "90% CI" ) lab(4 "Public") ) ///
ylabel(.45(.05).9,labels) xlabel(,labels)  xmtick(0(.2)1) scheme(s2mono) note("Notes:""$notepartial""$noteconditional", size(vsmall)) 

/*
Figure 3
*/

global xtitle "Proportion of children incentivized"
global notepartial "Residuals are partialled out from a parametric fit."
global grape "Initial grape choice"

foreach var in grape {
xi: semipar `var' i.strata i.table_size i.grade i.sex i.race i.lunch, nonpar(table_incentive_pr) partial(`var'_hat) nograph robust cluster(table)
}

twoway (lpolyci grape_hat table_incentive_pr if private==1, level(90) degree(1) lcolor(gs11) fcolor(none) pstyle(p1) clpattern("--...")) ///
(lpolyci grape_hat table_incentive_pr if private==0, level(90) degree(1) lcolor(black) fcolor(none) pstyle(p2) clpattern(dash)) , ///
ytitle("Initial grapes take-up (G1)") xtitle("$xtitle") legend(lab(1 "90% CI") lab(2 "Private" ) lab(3 "90% CI" ) lab(4 "Public") ) ///
ylabel(.45(.05).9,labels) xlabel(,labels)  xmtick(0(.2)1) scheme(s2mono) note("Notes:""$notepartial", size(vsmall)) 


log close
