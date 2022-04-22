//Importing data
{
import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/RawData/TLC_BaseCohort_COVIDCases_30PerCaseControlPool20210901083448.csv", clear 
save "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/Base_Cohort.dta" , replace

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/RawData/AVF1_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20210914021734.csv", encoding(ISO-8859-9) clear 
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/PropensityScoreVariables.dta" , replace

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/RawData/AVF2_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20210927051034.csv", clear 
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/Smoking.dta" , replace

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/RawData/AVF3_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211004095843.csv" , clear
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/SmokingStatus_NonSmoker.dta" , replace

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/RawData/AVF4_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211004102434.csv", clear
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/BMI.dta" , replace

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/RawData/AVF5_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211004121915.csv", clear 
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/LongCOVID.dta" , replace

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/RawData/AVF7_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211006052113.csv", clear 
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/COVIDRecordsCheck.dta" , replace

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/RawData/AVF8_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211011111520.csv"
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/VaccineStatus.dta" , replace
}

//Symptom data within the first 4 weeks of diagnosis
{
//first 495 variables is of interest 
local b = 0
forval i = 1/9 {
local a = 1 + `b'
local b = 50 * `i'
import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF9_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211028031400.csv", colrange(`a':`b') clear
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_`i'.dta" , replace
}
import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF9_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211028031400.csv", colrange(451:495) clearsave "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_10.dta" , replace

forval i = 1/4 {
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_`i'.dta" , clear
drop b_*
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_`i'.dta" , replace
}
//

use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_5.dta" , clear
drop b_* o_*
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_5.dta" , replace

forval i = 6/10 {
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_`i'.dta" , clear
drop o_*
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_`i'.dta" , replace
}
//
import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF17_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211122095349.csv", encoding(ISO-8859-2) clear 
keep practice_patient_id bd_medihyperacusis_tlc10 od_medihyperacusis_tlc4 bd_medidysgeusia_tlc9 od_medidysgeusia_tlc3
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_Dysgeusia_Hyperacusis.dta" , replace

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF26_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211129113302.csv", encoding(ISO-8859-2) clear
keep practice_patient_id bd_medineuropathic_pain_tlc9 bd_medisorethroat_tlc_v210 bd_meditinnitus_tlc11 od_meditinnitus_tlc3 od_medineuropathic_pain_tlc4 od_medisorethroat_tlc_v25
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_Nueropathic_Tinnitus_SoreThroat.dta" , replace

use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_1.dta" , clear
forval i = 2/10 {
merge 1:1 _n using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_`i'.dta" 
drop _merge
}
drop bd_medihyperacusis_tlc122 od_medihyperacusis_tlc117 bd_medidysgeusia_tlc121 od_medidysgeusia_tlc116 bd_medisorethroat_tlc81 od_medisorethroat_tlc76
sort practice_patient_id
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_Dysgeusia_Hyperacusis.dta" 
drop _merge 
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_Nueropathic_Tinnitus_SoreThroat.dta" 
drop _merge
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1.dta" , replace

use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1.dta" , clear
generate IndexDate = date(index_date, "YMD")
format IndexDate %tdDD/NN/CCYY
drop bd_medilongcovid_diagnosisreferr bd_medilongcovid_assessmentcodes od_medilongcovid_diagnosisreferr od_medilongcovid_assessmentcodes 
rename bd_medidifficulty_understanding_ bd_medidiff_understanding_tlc
rename bd_medierectiledysfunctionsympto bd_medierectiledysfunction_tlc
rename bd_mediejaculationdiffsymptom_tl bd_mediejaculationdiff_tlc
rename bd_medichangestomenstrualperiod_ bd_medimenstrualchanges_tlc
rename bd_mediorthostatichypotension_tl bd_mediorthostatichypotens_tlc
rename bd_mediptsd131 bd_mediptsd_tlc

rename od_medidifficulty_understanding_ od_medidiff_understanding_tlc
rename od_medierectiledysfunctionsympto od_medierectiledysfunction_tlc
rename od_mediejaculationdiffsymptom_tl od_mediejaculationdiff_tlc
rename od_medichangestomenstrualperiod_ od_medimenstrualchanges_tlc
rename od_mediorthostatichypotension_tl od_mediorthostatichypotens_tlc
rename od_mediptsd3 od_mediptsd_tlc

ds bd_*
foreach var in `r(varlist)' {
local newname = substr("`var'", 8, strpos("`var'", "_tlc")-8)
di "`var'"
di "`newname'"
gen BD_`newname' = date(`var', "YMD")
format BD_`newname' %tdDD/NN/CCYY

gen B_`newname' = 0 
replace B_`newname' = 1 if BD_`newname' != .

gen B12M_`newname' = 0 
replace B12M_`newname' = 1 if BD_`newname' != . & BD_`newname' > IndexDate - 365
drop `var'
}
//
ds od_*
foreach var in `r(varlist)' {
local newname = substr("`var'", 8, strpos("`var'", "_tlc")-8)
di "`newname'"
gen OD_`newname' = date(`var', "YMD")
format OD_`newname' %tdDD/NN/CCYY

gen O_`newname' = 0 
replace O_`newname' = 1 if OD_`newname' != .

gen O4W_`newname' = 0 
replace O4W_`newname' = 1 if OD_`newname' != . & OD_`newname' < IndexDate + 28
}
//
keep practice_patient_id O4W* OD*
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_Processed.dta"  , replace

erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1.dta"
forval i = 1/10 {
erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_`i'.dta"
}
}

//Symptom data after 12 weeks of diganosis (Long COVID)
{
//first 248 variables is of interest 
local b = 0
forval i = 1/5 {
local a = 1 + `b'
local b = 50 * `i'
import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF10_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211108043244.csv", colrange(`a':`b') clear
drop b_*
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_`i'.dta" , replace
}

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF21_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211122012030.csv", clear 
keep practice_patient_id bd_medihyperacusis_tlc9 bd_medidysgeusia_tlc10
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Dysgeusia_Hyperacusis.dta" , replace

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF28_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211129113444.csv" , clear 
keep practice_patient_id bd_meditinnitus_tlc9 bd_medineuropathic_pain_tlc10 bd_medisorethroat_tlc_v211
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Nueropathic_Tinnitus_SoreThroat.dta" , replace


use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_1.dta" , clear
forval i = 2/5 {
merge 1:1 _n using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_`i'.dta" 
drop _merge
}
drop bd_medihyperacusis_tlc122 bd_medidysgeusia_tlc121 bd_medisorethroat_tlc81
merge 1:1 _n using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Dysgeusia_Hyperacusis.dta"
drop _merge 
merge 1:1 _n using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Nueropathic_Tinnitus_SoreThroat.dta"
drop _merge
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2.dta" , replace


use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2.dta" , clear
generate IndexDate = date(index_date, "YMD")
format IndexDate %tdDD/NN/CCYY
drop bd_medilongcovid_diagnosisreferr bd_medilongcovid_assessmentcodes 
rename bd_medidifficulty_understanding_ bd_medidiff_understanding_tlc
rename bd_medierectiledysfunctionsympto bd_medierectiledysfunction_tlc
rename bd_mediejaculationdiffsymptom_tl bd_mediejaculationdiff_tlc
rename bd_medichangestomenstrualperiod_ bd_medimenstrualchanges_tlc
rename bd_mediorthostatichypotension_tl bd_mediorthostatichypotens_tlc
rename bd_mediptsd131 bd_mediptsd_tlc

ds bd_*
foreach var in `r(varlist)' {
local newname = substr("`var'", 8, strpos("`var'", "_tlc")-8)
di "`var'"
di "`newname'"
gen OD_`newname' = date(`var', "YMD")
format OD_`newname' %tdDD/NN/CCYY

gen O12W_`newname' = 0 
replace O12W_`newname' = 1 if OD_`newname' != . & OD_`newname' > IndexDate + 84
drop `var'

}
//
keep practice_patient_id O12W* OD*
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Processed.dta"  , replace

erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2.dta"
forval i = 1/5 {
erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_`i'.dta"
}
}

//Symptom data between 4 to 12 weeks of diagnosis
{
//first 248 variables is of interest 
local b = 0
forval i = 1/5 {
local a = 1 + `b'
local b = 50 * `i'
import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF11_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211108043708.csv", colrange(`a':`b') clear
drop b_*
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_`i'.dta" , replace
}

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF19_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211122095501.csv" , clear
keep practice_patient_id bd_medidysgeusia_tlc9 bd_medihyperacusis_tlc10
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_Dysgeusia_Hyperacusis.dta" , replace

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF27_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211129113406.csv", clear 
keep practice_patient_id bd_meditinnitus_tlc9 bd_medineuropathic_pain_tlc10 bd_medisorethroat_tlc_v211
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_Nueropathic_Tinnitus_SoreThroat.dta" , replace


use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_1.dta" , clear
forval i = 2/5 {
merge 1:1 _n using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_`i'.dta" 
drop _merge
}
drop bd_medihyperacusis_tlc122 bd_medidysgeusia_tlc121  bd_medisorethroat
sort practice_patient_id
merge 1:1 practice_patient_id using  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_Dysgeusia_Hyperacusis.dta"  , sorted
drop _merge
merge 1:1 practice_patient_id using  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_Nueropathic_Tinnitus_SoreThroat.dta"  , sorted
drop _merge
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3.dta" , replace


use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3.dta" , clear
generate IndexDate = date(index_date, "YMD")
format IndexDate %tdDD/NN/CCYY
drop bd_medilongcovid_diagnosisreferr bd_medilongcovid_assessmentcodes 
rename bd_medidifficulty_understanding_ bd_medidiff_understanding_tlc
rename bd_medierectiledysfunctionsympto bd_medierectiledysfunction_tlc
rename bd_mediejaculationdiffsymptom_tl bd_mediejaculationdiff_tlc
rename bd_medichangestomenstrualperiod_ bd_medimenstrualchanges_tlc
rename bd_mediorthostatichypotension_tl bd_mediorthostatichypotens_tlc
rename bd_mediptsd131 bd_mediptsd_tlc

ds bd_*
foreach var in `r(varlist)' {
local newname = substr("`var'", 8, strpos("`var'", "_tlc")-8)
di "`var'"
di "`newname'"
gen OD_`newname' = date(`var', "YMD")
format OD_`newname' %tdDD/NN/CCYY

gen O4to12W_`newname' = 0 
replace O4to12W_`newname' = 1 if OD_`newname' != . & OD_`newname' > IndexDate + 28 & OD_`newname' < IndexDate + 84
drop `var'

}
//
keep practice_patient_id O4to12W* OD*
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_Processed.dta"  , replace

erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3.dta"
forval i = 1/5 {
erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_`i'.dta"
}
}

//Symptom data between 3 to 12 months before index date
{
//248 variables is of interest 
local b = 0
forval i = 1/5 {
local a = 1 + `b'
local b = 50 * `i'
import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF12_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211115101837.csv", colrange(`a':`b') clear
drop b_*
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_`i'.dta" , replace
}

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF20_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211122095646.csv", clear 
keep practice_patient_id bd_medidysgeusia_tlc9 bd_medihyperacusis_tlc10
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Dysgeusia_Hyperacusis.dta" , replace

import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/AVF29_TLC_BaseCohort_COVIDCases_30PerCaseControlPool20211129113514.csv", clear 
keep practice_patient_id bd_meditinnitus_tlc9 bd_medineuropathic_pain_tlc10 bd_medisorethroat_tlc_v211
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Nueropathic_Tinnitus_SoreThroat.dta" , replace

use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_1.dta" , clear
forval i = 2/5 {
merge 1:1 _n using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_`i'.dta" 
drop _merge
}
drop bd_medidysgeusia_tlc122 bd_medihyperacusis_tlc123 bd_medisorethroat bd_medijointpain2_tlc51
sort practice_patient_id
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Dysgeusia_Hyperacusis.dta", sorted
drop _merge
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Nueropathic_Tinnitus_SoreThroat.dta", sorted
drop _merge
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4.dta" , replace

use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4.dta" , clear
generate IndexDate = date(index_date, "YMD")
format IndexDate %tdDD/NN/CCYY
drop bd_medilongcovid_diagnosisreferr bd_medilongcovid_assessmentcodes 
rename bd_medidifficulty_understanding_ bd_medidiff_understanding_tlc
rename bd_medierectiledysfunctionsympto bd_medierectiledysfunction_tlc
rename bd_mediejaculationdiffsymptom_tl bd_mediejaculationdiff_tlc
rename bd_medichangestomenstrualperiod_ bd_medimenstrualchanges_tlc
rename bd_mediorthostatichypotension_tl bd_mediorthostatichypotens_tlc
rename bd_mediptsd132 bd_mediptsd_tlc

ds bd_*
foreach var in `r(varlist)' {
local newname = substr("`var'", 8, strpos("`var'", "_tlc")-8)
di "`var'"
di "`newname'"
gen D_`newname' = date(`var', "YMD")
format D_`newname' %tdDD/NN/CCYY

gen B12M_`newname' = 0 
replace B12M_`newname' = 1 if D_`newname' != . & D_`newname' > IndexDate - 365
drop `var'

}
//
keep practice_patient_id B12M* 
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed.dta"  , replace

erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4.dta"
forval i = 1/5 {
erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_`i'.dta"
}
}

//Obtaining IMD data
{
import delimited "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/RawData/patient_imd2015_21_000423.txt", clear 
tostring pracid, replace
tostring patid, replace format(%20.0f)
gen practice_patient_id = "p" + pracid + "_" + patid 
sort practice_patient_id
keep practice_patient_id imd2015_20
save "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/IMD.dta" , replace
}

//Obtaining baseline variables (comorbidities) for PS matching
{
use "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/Base_Cohort.dta"  , clear 
keep practice_patient_id exposed
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/PropensityScoreVariables.dta" 
drop _merge
drop b_medihf_bham_camv1153 bd_medihf_bham_camv1153 
drop b_medi*
ds bd_medi* 
foreach var in `r(varlist)' {
local newname = substr("`var'" , 8, .)
foreach x in __bham_cam _bham_cam _nosurg _bh _mm _birm _bi _12 _vfinal _v2 _v3 mm 177 180 20 _sh_20092020 _sh_20092020 _b v1 v2 _11_3_21 _200421 _09 _11 _sh {
if strpos("`newname'", "`x'") > 0 {
local newname = substr("`newname'" , 1, strpos("`newname'", "`x'")-1)
}
}
if substr("`newname'", strlen("`newname'"), .) == "_" {
local newname = substr("`newname'" , 1 , strlen("`newname'")-1)
}
di "`var'                              `newname'" 
di 
gen D_`newname' = date(`var' , "YMD")
format D_`newname' %tdDD/NN/CCYY
}
save "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/V1.dta" , replace

******Cancer*******
gen Cov_Cancer = 0 
foreach var in D_primarylungcancer D_breastcancer D_colon_cancer D_primaryprostateca_prevale D_primaryprostateca_inciden D_leukaemia_prevalence D_leukaemia_incidence D_lymphoma_incidence D_lymphoma_prevalence D_plasmacell_neoplasm D_skincancer D_allca_nobcc D_metastaticcancer {
replace Cov_Cancer = 1 if `var' != .
}
******Cardiovascular*******
gen Cov_arrhythmia = 0 
replace Cov_arrhythmia = 1 if D_arrhythmia != .

gen Cov_AF = 0 
replace Cov_AF = 1 if D_af != .

gen Cov_hypertension = 0 
replace Cov_hypertension = 1 if D_hypertension != .

gen Cov_HeartFailure = 0 
replace Cov_HeartFailure = 1 if D_hf != .

gen Cov_IHD = 0 
replace Cov_IHD = 1 if D_ihd_nomi != .

gen Cov_MyocardialInfarction = 0 
replace Cov_MyocardialInfarction = 1 if D_minfarction != .

gen Cov_ValvularHeartDisease = 0 
replace Cov_ValvularHeartDisease = 1 if D_valvulardiseases != . 

gen Cov_Cardiomyopathy = 0 
replace Cov_Cardiomyopathy = 1 if D_cardiomyopathy != .

gen Cov_CongenitalHeartDisease = 0 
replace Cov_CongenitalHeartDisease = 1 if D_congenitalhrtdx != .

gen Cov_PVD = 0 
replace Cov_PVD = 1 if D_pvd != .

gen Cov_AorticAneurysm = 0 
replace Cov_AorticAneurysm = 1 if D_aorticaneurysm != . 

gen Cov_TIA = 0 
replace Cov_TIA = 1 if D_tia != . 

gen Cov_IschaemicStroke = 0 
replace Cov_IschaemicStroke = 1 if D_ischaemicstroke != . 

gen Cov_HaemorrhagicStroke = 0 
replace Cov_HaemorrhagicStroke = 1 if D_stroke_haemrgic != . 

gen Cov_StrokeUnspec = 0 
replace Cov_StrokeUnspec = 1 if D_strokeunspecified != .

******Dermatology*******
gen Cov_Eczema = 0 
replace Cov_Eczema = 1 if D_atopiceczema != .

gen Cov_Psoriasis = 0 
replace Cov_Psoriasis = 1 if D_psoriasis != . 

gen Cov_AutoimmuneSkinCond = 0 
replace Cov_AutoimmuneSkinCond = 1 if D_vitiligo ! = . | D_alopeciaareata != . 
gen Cov_Acne = 0 
replace Cov_Acne = 1 if D_acne != . 

******Ear Nose Throat*******
gen Cov_hayfever = 0 
replace Cov_hayfever = 1 if D_allergicrhinitisconj != . 

gen Cov_ChronicSinusitis = 0 
replace Cov_ChronicSinusitis = 1 if D_chronicsinusitis != .

gen Cov_Deafness = 0 
replace Cov_Deafness = 1 if D_severedeafhearingloss != .

******Eye*******
gen Cov_Blindness = 0 
replace Cov_Blindness = 1 if D_visual_impairment != . 

gen Cov_Cataract = 0 
replace Cov_Cataract = 1 if D_cataract_incidence != . | D_cataract_prevalence != . 

gen Cov_Glaucoma = 0 
replace Cov_Glaucoma = 1 if  D_glaucoma_incid != . | D_glaucoma_prevalence != .

gen Cov_AMD = 0 
replace Cov_AMD = 1 if D_amd != . 

gen Cov_DiabeticRetinopathy = 0 
replace Cov_DiabeticRetinopathy = 1 if D_diabetic_retinopathy != . 

gen Cov_InflammatoryEyeDisease = 0 
replace Cov_InflammatoryEyeDisease = 1 if D_uveitisall != . | D_scleritis != . | D_episcleritis != . | D_retinaldetach_incidence != . | D_retinaldetach_prevalence != .

******Gastrointenstinal*******
gen Cov_PepticUlcer = 0 
replace Cov_PepticUlcer = 1 if D_pepticulcer != .
 
gen Cov_InflammatoryBowelDisease = 0 
replace Cov_InflammatoryBowelDisease = 1 if D_ulcerative_colitis != . | D_crohns_disease != . 

gen Cov_IrritableBowelSyndrome = 0 
replace Cov_IrritableBowelSyndrome = 1 if D_prevalentibs != . | D_incidentibs != . 

gen Cov_Hepatitis_B = 0 
replace Cov_Hepatitis_B = 1 if D_hepatitis != . 

gen Cov_Hepatitis_C = 0 
replace Cov_Hepatitis_C = 1 if D_hepatitis_c != . 

gen Cov_ChronicLiverDisease_Alc = 0 
replace Cov_ChronicLiverDisease_Alc = 1 if D_chronic_liver_disease_alc != . 

gen Cov_ChronicLiverDisease_All = 0 
replace Cov_ChronicLiverDisease_All = 1 if D_chronicliverdisease_vs != . 

gen Cov_NAFLD = 0 
replace Cov_NAFLD = 1 if D_nafld != . 

gen Cov_DiverticularDisease = 0 
replace Cov_DiverticularDisease = 1 if D_diverticular_disease != . 

gen Cov_CoeliacDisease = 0 
replace Cov_CoeliacDisease = 1 if D_coeliac_disease != . 

gen Cov_ChronicPancreatitis = 0 
replace Cov_ChronicPancreatitis = 1 if D_chronicpancreatitis != . 

******Gynaecology*******
gen Cov_Endometriosis = 0 
replace Cov_Endometriosis = 1 if D_endometriosisadenomyosis != . 

gen Cov_PCOS = 0 
replace Cov_PCOS = 1 if D_polycysticovariansyndrome != . 

******Haematology*******
gen Cov_LowHb = 0 
replace Cov_LowHb = 1 if D_b12deficiency != . | D_b12defincidence != . | D_folatedeficiency != .

gen Cov_VTE = 0 
replace Cov_VTE = 1 if D_vtenope != . | D_vtenopeincidence != . | D_pulmonaryembolismpe != . | D_pulmonaryembolismpeincide != . 

gen Cov_Coagulopathy = 0 
replace Cov_Coagulopathy = 1 if D_coagulopathy != . | D_haemophilia != . | D_primarythrombocytopeniait != . | D_sicklecelldisease != . | D_sicklecelldiseaseincidenc != . | D_thalassaemia != . 

gen Cov_PerniciousAnaemia = 0 
replace Cov_PerniciousAnaemia = 1 if D_perniciousanaemia != . 

******Mental Health*******
gen Cov_Depression = 0 
replace Cov_Depression = 1 if D_depression != . 

gen Cov_Anxiety = 0 
replace Cov_Anxiety = 1 if D_anxiety != .

gen Cov_SeriousMentalIllness = 0 
replace Cov_SeriousMentalIllness = 1 if D_bipolar != . | D_schizophrenia != . | D_affectivepsychosis != . | D_nonaffectivepsychosis != .

gen Cov_SubstanceMisuse = 0 
replace Cov_SubstanceMisuse = 1 if D_substancemisuse != . 

gen Cov_AlcoholMisuse = 0 
replace Cov_AlcoholMisuse = 1 if D_alcoholmisuse != . 

gen Cov_ADHD = 0 
replace Cov_ADHD = 1 if D_adhd != . 

gen Cov_EatingDisorder = 0 
replace Cov_EatingDisorder = 1 if D_eatingdisorders != . 

gen Cov_LearningDisability = 0 
replace Cov_LearningDisability = 1 if D_learningdisability != . 

gen Cov_Alzheimers = 0 
replace Cov_Alzheimers = 1 if D_alzheimers != .

gen Cov_VascularDementia = 0 
replace Cov_VascularDementia = 1 if D_vasculadementia != . 

gen Cov_DementiaUnspecified = 0 
replace Cov_DementiaUnspecified = 1 if D_dementiaother != . 

******Neurology*******
gen Cov_Parkinsons = 0 
replace Cov_Parkinsons = 1 if D_parkinsons != . 

gen Cov_Migraine = 0 
replace Cov_Migraine = 1 if D_migraineincident != . | D_migraineprevalent != .

gen Cov_MultipleSclerosis = 0 
replace Cov_MultipleSclerosis = 1 if D_ms != . 

gen Cov_Epilepsy = 0 
replace Cov_Epilepsy = 1 if D_epilepsy != . 

gen Cov_Hemiplegia = 0 
replace Cov_Hemiplegia = 1 if D_hemi_para_quadriplegia != .

gen Cov_ChronicFatigueSyndrome = 0 
replace Cov_ChronicFatigueSyndrome = 1 if D_chronicfatiguesyndrome != .

gen Cov_Fibromyalgia = 0 
replace Cov_Fibromyalgia = 1 if D_fibromyalgia != . 

gen Cov_ClusterHeadache = 0 
replace Cov_ClusterHeadache = 1 if D_clusterheadache != .

******Musculoskeletal*******
gen Cov_Osteoarthritis = 0 
replace  Cov_Osteoarthritis = 1 if D_osteoarthritis != . 

gen Cov_BackPain = 0 
replace Cov_BackPain = 1 if D_chronicbackpain != .

gen Cov_FragilityFracture = 0 
replace Cov_FragilityFracture = 1 if D_distalforearmfracture != . | D_hip_fracture != . | D_humerus_fracture != . | D_spinal_fractures != .

gen Cov_Falls = 0 
replace Cov_Falls = 1 if D_falls != . 

gen Cov_PolymyalgiaRheumatica = 0 
replace Cov_PolymyalgiaRheumatica = 1 if D_polymyalgiarheumatica != . 

gen Cov_RheumatoidArthritis = 0 
replace Cov_RheumatoidArthritis = 1 if D_rheumatoidarthritis != . 

gen Cov_RaynaudsDisease = 0 
replace Cov_RaynaudsDisease = 1 if D_raynauds != . 

gen Cov_SjogrensSyndrome = 0 
replace Cov_SjogrensSyndrome = 1 if D_sjogrenssyndrome != . 

gen Cov_SystemicLupusErythematosus = 0 
replace Cov_SystemicLupusErythematosus = 1 if D_systemic_lupus_erythemato != .

gen Cov_SystemicSclerosis = 0 
replace Cov_SystemicSclerosis = 1 if D_systemic_sclerosis != .

gen Cov_PsoriaticArthritis = 0 
replace Cov_Psoriasis = 1 if D_psoriaticarthritis != . 

gen Cov_AnkylosingSpondylitis = 0 
replace Cov_AnkylosingSpondylitis = 1 if D_ankylosingspondylitis != . 

gen Cov_Gout = 0 
replace Cov_Gout = 1 if D_gout != . 


******Renal*******
gen Cov_ChronicKidneyDisease = 0 
replace Cov_ChronicKidneyDisease = 1 if D_ckdstage3to5 != . 

******Respiratory*******
gen Cov_Asthma = 0 
replace Cov_Asthma = 1 if D_asthma_pushasthma != . 

gen Cov_COPD = 0 
replace Cov_COPD = 1 if D_copd != . 

gen Cov_OSA = 0 
replace Cov_OSA = 1 if D_osa != . 

gen Cov_OtherPulmonaryDisease = 0 
replace Cov_OtherPulmonaryDisease = 1 if D_bronchiectasis != . | D_cysticfibrosis != . | D_ild != . 

******Metabolic*******
gen Cov_Hyperthyroidism = 0 
replace Cov_Hyperthyroidism = 1 if D_hyperthyroidism!= . 

gen Cov_Hypothyroidism = 0 
replace  Cov_Hypothyroidism = 1 if D_hypothyroidismdraft != . 

gen Cov_Type1Diabetes = 0 
replace Cov_Type1Diabetes = 1 if D_type1dm !=. 

gen Cov_Type2Diabetes = 0 
replace Cov_Type2Diabetes = 1 if D_type2diabetes != . 

******InfectiousDisease*******
gen Cov_AIDS = 0 
replace Cov_AIDS = 1 if D_hivaids != . 

******Male Conditions*******
gen Cov_BenignProstaticHyperplasia = 0 
replace Cov_BenignProstaticHyperplasia = 1 if D_benignprostatehyperplasia != . 

gen Cov_ErectileDysfunction = 0 
replace Cov_ErectileDysfunction = 1 if D_erectiledysfunction != .

keep practice_patient_id Cov_* D_*
sort practice_patient_id
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/PS Matching Variables.dta" , replace
}

//Merging base cohort with additional baseline data required for PS matching
{
use "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/Base_Cohort.dta" , clear 
sort practice_patient_id
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/PS Matching Variables.dta" , sorted
drop _merge
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/Smoking.dta" , sorted
drop _merge
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/SmokingStatus_NonSmoker.dta" , sorted 
drop _merge
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/BMI.dta" , sorted
drop _merge
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/LongCOVID.dta" , sorted
drop _merge
replace practice_id = substr(practice_id, 2 , .)
sort practice_patient_id
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/IMD.dta" , sorted
keep if _merge == 3 | _merge == 1
drop _merge
sort practice_patient_id
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Propensity Score Matching/Temp/VaccineStatus.dta" , sorted
drop _merge
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Data.dta" , replace
}

//Encoding other baseline demographic variables for PS matching
{
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Data.dta" , clear
****Converting dates 
generate IndexDate = date(index_date, "YMD")
generate YearofBirth = date(year_of_birth, "YMD")
generate CollectionDate = date(collection_date, "YMD")
generate TransferDate = date(transfer_date, "YMD")
generate DeathDate = date(death_date, "YMD")
replace DeathDate = TransferDate if registration_status == 99 & DeathDate == . 
generate COVID_Date = date(exposedconfirmedcovid_aurum_date, "YMD") 
generate Hosp_Date = date(bd_medihospital_admission_tlc0, "YMD") 

generate PatientEndDate = min(TransferDate,  DeathDate)
format IndexDate YearofBirth CollectionDate TransferDate DeathDate COVID_Date Hosp_Date PatientEndDate %tdDD/NN/CCYY


*****labelling sex
gen gender = 1 if sex == "M"
replace gender = 2 if sex == "F"
label define Sexlab 2 "Female" 1 "Male"
label value gender Sexlabel 
drop sex 
recode gender (1=1 "Men") (2=2 "Women"), gen(COV_sex)
drop gender
tab COV_sex
***************

****age
gen COV_age = (IndexDate - YearofBirth)/ 365.25
sum COV_age, detail
recode COV_age (min/29.9999=1 "16 - 30 years")  (30/39.9999=2 "30 - 40 years")  (40/49.9999=3 "40 - 50 years")  (50/59.9999=4 "50 - 60 years") (60/69.9999=5 "60 - 70  years") (70/max=6 ">70  years"), gen (COV_agecat)
label var COV_agecat "age categories (grouped)"
***************

*********Long COVID diagnosis by a GP
generate D_LongCOVID_Diagnosis = date(bd_medilongcovid_diagnosisreferr, "YMD")
generate D_LongCOVID_Assessment = date(bd_medilongcovid_assessmentcodes, "YMD")
format D_LongCOVID_* %tdDD/NN/CCYY
gen LongCOVID = 0 
replace LongCOVID = 1 if D_LongCOVID_Diagnosis != .


******Vaccination 
generate BD_VaccineProcedure = date(bd_medicovid19_vaccineprocedure6, "YMD")
generate BD_VaccineSecondDose = date(bd_medicovid19_vaccine_seconddos, "YMD")
generate BD_VaccineFirstDose = date(bd_medicovid19_vaccine_firstdose, "YMD")
generate OD_VaccineProcedure = date(od_medicovid19_vaccineprocedure0, "YMD")
generate OD_VaccineSecondDose = date(od_medicovid19_vaccine_seconddos, "YMD")
generate OD_VaccineFirstDose = date(od_medicovid19_vaccine_firstdose, "YMD")

generate BD_ModernaVaccine = date(bd_drugcovid19_vaccine_moderna9, "YMD")
generate BD_AstraZenecaVaccine = date(bd_drugcovid19_vaccine_astrazene, "YMD")
generate BD_PfizerVaccine = date(bd_drugcovid19_vaccine_pfizerbio, "YMD")
generate OD_ModernaVaccine = date(od_drugcovid19_vaccine_moderna3, "YMD")
generate OD_AstraZenecaVaccine = date(od_drugcovid19_vaccine_astrazene, "YMD")
generate OD_PfizerVaccine = date(od_drugcovid19_vaccine_pfizerbio, "YMD")

gen COV_VaccineProcedure = 0 
replace COV_VaccineProcedure = 1 if BD_VaccineProcedure != . | BD_ModernaVaccine != . | BD_AstraZenecaVaccine != . | BD_PfizerVaccine != .

gen COV_VaccineFirstDose = 0 
replace COV_VaccineFirstDose = 1 if BD_VaccineFirstDose != . 

gen COV_VaccineSecondDose = 0 
replace COV_VaccineSecondDose = 1 if BD_VaccineSecondDose != . 

gen COV_PfizerVaccine = 0 
replace COV_PfizerVaccine = 1 if BD_PfizerVaccine != .

gen COV_AstraZenecaVaccine = 0 
replace COV_AstraZenecaVaccine = 1 if BD_AstraZenecaVaccine != . 

gen COV_ModernaVaccine = 0 
replace COV_ModernaVaccine = 1 if BD_ModernaVaccine != . 


gen D_VaccineProcedure = min(BD_VaccineProcedure, OD_VaccineProcedure)
gen D_VaccineFirstDose = min(BD_VaccineFirstDose, OD_VaccineFirstDose)
gen D_VaccineSecondDose = min(BD_VaccineSecondDose, OD_VaccineSecondDose)
format D_Vaccine* OD_Vaccine* BD_Vaccine* %tdDD/NN/CCYY

gen D_ModernaVaccine = min(BD_ModernaVaccine, OD_ModernaVaccine)
gen D_PfizerVaccine = min(BD_PfizerVaccine, OD_PfizerVaccine)
gen D_AstraZenecaVaccine = min(BD_AstraZenecaVaccine, OD_AstraZenecaVaccine)
format *D_Moderna* *D_Pfizer* *D_AstraZeneca* %tdDD/NN/CCYY

gen VaccineProcedure = 0 
replace VaccineProcedure = 1 if D_VaccineProcedure != . | D_ModernaVaccine != . | D_PfizerVaccine != . | D_AstraZeneca != .

gen VaccineFirstDose = 0 
replace VaccineFirstDose = 1 if D_VaccineFirstDose != . 

gen VaccineSecondDose = 0 
replace VaccineSecondDose = 1 if D_VaccineSecondDose != . 

gen PfizerVaccine = 0 
replace PfizerVaccine = 1 if D_PfizerVaccine != .

gen AstraZenecaVaccine = 0 
replace AstraZenecaVaccine = 1 if D_AstraZenecaVaccine != . 

gen ModernaVaccine = 0 
replace ModernaVaccine = 1 if D_ModernaVaccine != . 


******ethnicity 
gen D_Ethnicity_White = date(bd_mediwhite1, "YMD")
gen D_Ethnicity_Other = date(bd_mediother2, "YMD")
gen D_Ethnicity_Black = date(bd_mediblack3, "YMD")
gen D_Ethnicity_Mixed = date(bd_medimixed4, "YMD")
gen D_Ethnicity_Asian = date(bd_mediasian5, "YMD")

gen D_Ethnicity = max(D_Ethnicity_White, D_Ethnicity_Other, D_Ethnicity_Black, D_Ethnicity_Mixed, D_Ethnicity_Asian)
format D_Ethnicity_*

gen Ethnicity1 = 6 
replace Ethnicity1 = 1 if D_Ethnicity == D_Ethnicity_White & D_Ethnicity_White != .
replace Ethnicity1 = 2 if D_Ethnicity == D_Ethnicity_Mixed & D_Ethnicity_Mixed != .
replace Ethnicity1 = 3 if D_Ethnicity == D_Ethnicity_Other & D_Ethnicity_Other != .
replace Ethnicity1 = 4 if D_Ethnicity == D_Ethnicity_Black & D_Ethnicity_Black != .
replace Ethnicity1 = 5 if D_Ethnicity == D_Ethnicity_Asian & D_Ethnicity_Asian != .
recode Ethnicity1 (1 = 1 "White" ) (2 = 2 "Mixed Race" ) (3 = 3 "Others" )(4 = 4 "Black" ) (5 = 5 "Asians" )(6 = 6 "Missing" ), gen(COV_Ethnicity)

*******BMI
gen COV_BMI = value_0 
misstable summarize COV_BMI
replace COV_BMI = . if (COV_BMI < 14 | COV_BMI > 75)
misstable summarize COV_BMI
recode COV_BMI (min/18.4999999 = 1 "Underweight 1<8.5 kg/m2") (18.5/25 = 2 "Under/Normal weight 18.5-25 kg/m2") (25.00001/30 = 3 "Overweight 25-30 kg/m2") (30.00001/max = 4 "Obese >30 kg/m2")(. = 5 "missing"), gen(COV_BMIcat)
label var COV_BMIcat "BMI categories at baseline (grouped)"
sum COV_BMI
***************

****townsend score
drop townsend
rename imd2015_20 COV_Townsend
replace COV_Townsend = 21 if COV_Townsend == .
***************

****smoking
gen D_CurSmoker = date(bd_medicurrent_smoker11, "YMD")
gen D_ExSmoker = date(bd_mediex_smoker9, "YMD")
gen D_NeverSmoker = date(bd_medinever_smoked10, "YMD")
gen D_NonSmoker = date(bd_medismokingstatus_nonsmoker9, "YMD")
format D_CurSmoker D_ExSmoker D_NeverSmoker D_NonSmoker %tdDD/NN/CCYY

gen D_Smoking = max(D_CurSmoker, D_ExSmoker, D_NeverSmoker)
gen Smoker = .
replace Smoker = 1 if D_NeverSmoker == D_Smoking & D_Smoking != .
replace Smoker = 2 if D_ExSmoker == D_Smoking & D_Smoking != .
replace Smoker = 3 if D_CurSmoker == D_Smoking & D_Smoking != .

replace Smoker = 2 if Smoker == 1 & (D_ExSmoker != . | D_CurSmoker != .)
replace Smoker = 2 if Smoker == 3 & D_NonSmoker > D_Smoking & D_Smoking != . & D_NonSmoker != .
//If a smoking record present, then non-smoker gets replaced by ex-smoker 
//If a non-smoking record was the latest, then replace current smoker by ex-smoker
recode Smoker (1 = 1 "Never Smoked") (2 = 2 "Ex-Smoker")(1 = 3 "Current Smoker")(. = 4 "Smoking data missing"), gen(COV_SmokingStatus)
tab COV_SmokingStatus
***************

sort IndexDate
br IndexDate
gen Ref_IndexTime = td(06/02/2020) //First ever index date
gen COV_IndexTime = 1 
forval i = 1/100 {
replace COV_IndexTime = COV_IndexTime + 1 if IndexDate > 7 + Ref_IndexTime
replace Ref_IndexTime = Ref_IndexTime + 7
}

save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/V1.dta" , replace
}

//Applying I/E criteria and obtaining base cohort
{
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/V1.dta" , clear
sort practice_patient_id

//I/E criteria:
//Age --> 18+
//Hospitalization within 42 days (28 days + 14 days grace period) after index date
//Hospitalization within 14 days grace period before index date 
gen BaseCohort = 1 
replace BaseCohort = 0 if ((Hosp_Date > (IndexDate - 14)) & (Hosp_Date < (IndexDate + 42)) )
keep if BaseCohort == 1 

gen COVID2021 = 0
replace COVID2021 = 1 if IndexDate > td(01/01/2021)
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/BaseCohort_Patients.dta" , replace
**********************************************************************************************************************************
}

//PScore generation
{
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/BaseCohort_Patients.dta" , clear 
sort practice_patient_id
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed.dta" , sorted
keep if _merge == 3 
drop B12M_anxiety B12M_depression B12M_eyepressure B12M_hospital_admission B12M_orthop_pnd B12M_raisediop B12M_blurredvision B12M_pots B12M_orthostatichypotens

//Check for missingness
ds Cov_* COV_* B12M*
foreach var in `r(varlist)' {
quietly count if `var' == .
if `r(N)' > 0 {
di "`var' missing"
}
}
//

tab exposed

ds Cov_* B12M*
local Varlist Cov_* B12M*
local Varlist Cov_*
_rmcoll `Varlist' , forcedrop 
tab Cov_PsoriaticArthritis
drop Cov_PsoriaticArthritis
***********************************************************

//ds Cov_* 
//local Varlist Cov_* 
ds Cov_* B12M*
local Varlist Cov_* B12M*
_rmcoll `Varlist' , forcedrop 
di r(varlist)
local NewVarlist `r(varlist)'
logit exposed COV_sex COV_age i.COV_Ethnicity i.COV_BMIcat i.COV_SmokingStatus COV_IndexTime i.COV_Townsend `NewVarlist' , or

sort practice_patient_id 
set seed 3000
psmatch2 exposed COV_sex COV_age i.COV_Ethnicity i.COV_BMIcat i.COV_SmokingStatus COV_IndexTime i.COV_Townsend `NewVarlist' , logit caliper(0.2) noreplace warnings 
gen PScore = _pscore
egen ID = group(practice_patient_id)
sort ID
drop _merge
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PScore_Patients.dta" , replace
}

//Ps matching (1:4) using generated P scores
{
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PScore_Patients.dta"  , clear
keep if _support == 1 
keep ID _n1 _id PScore exposed _weight
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/SmallCohort.dta" , replace
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/Subset.dta" , replace

forval i = 1/4 {
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/Subset.dta" , clear 
keep if _weight == 1 
gen case_control_group = .
sort PScore 
forval j = 1/30 {
replace case_control_group = ID[_n-`j'] if exposed == 0 & _id[_n] == _n1[_n-`j']
replace case_control_group = ID[_n+`j'] if exposed == 0 & _id[_n] == _n1[_n+`j']
}
//
keep if _weight == 1 & exposed == 0
gen ControlSet = `i'
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/ControlSet`i'.dta" , replace

use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/Subset.dta" , clear 
drop if _weight == 1 & exposed == 0
sort ID 
set seed 3000
psmatch2 exposed, pscore(PScore) caliper(0.2) noreplace warnings 
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/Subset.dta" , replace
}
//
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/SmallCohort.dta"  , clear 
keep if _weight == 1 & exposed == 1
gen ControlSet = .
forval i = 1/4 {
append using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/ControlSet`i'.dta"  
}
replace case_control_group = ID if exposed == 1 
keep ID case_control_group PScore ControlSet exposed
sort ID
merge 1:1 ID using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PScore_Patients.dta" , sorted
keep if _merge == 3 

save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PS_Matched_Patients.dta" , replace
keep practice_patient_id exposed PScore
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/x.dta" , replace

//Kernel density plot 
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PScore_Patients.dta"  , clear
keep practice_patient_id PScore exposed
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/x.dta"
twoway (kdensity PScore if exposed==1) (kdensity PScore if exposed==0, ///
lpattern(dash)), legend( label( 1 "Patients with COVID-19") label( 2 "Control patients" ) ) ///
xtitle("propensity scores BEFORE matching") saving(before, replace)

twoway (kdensity PScore if exposed==1) (kdensity PScore if exposed==0 ///
& _merge == 3, lpattern(dash)), legend( label( 1 "Patients with COVID-19") label( 2 "Control patients" )) ///
xtitle("propensity scores AFTER matching") saving(after, replace)
graph combine before.gph after.gph, ycommon
}
//

//Long COVID definition based on WHO criteria
{
***********************************************************************************************************
//after 12 weeks of diganosis (Long COVID)
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Processed.dta", clear 
drop O12W_anxiety O12W_depression O12W_eyepressure O12W_hospital_admission O12W_orthop_pnd O12W_raisediop O12W_blurredvision
ds O12W*
foreach var in `r(varlist)' {
local newname = substr("`var'", 6, . )
di "`newname'"
replace OD_`newname' = . if `var' == 0
}
gen O12W_LongCOVID_WHO = 0 
gen Date_O12W_LongCOVID_WHO = .
foreach var in O12W_anosmia O12W_fatigue O12W_fever O12W_palipitations O12W_cough O12W_blurvision_diplopia O12W_chestpain O12W_shortnessofbreath O12W_paresthesia O12W_diarrhoea O12W_headache O12W_allergies O12W_insomnia O12W_constipation O12W_jointpain O12W_difficulty_thinking O12W_abdominalpain O12W_gastritis O12W_dizziness O12W_menorrhagia O12W_hyperacusis O12W_musclepain O12W_amnesia O12W_musclecramping O12W_gastricreflux O12W_depressionsym O12W_dysgeusia O12W_anxietyanddepression O12W_menstrualchanges O12W_premenstrualsyndrome O12W_excessivesleep O12W_hearingloss O12W_postexert_fatigue {
replace O12W_LongCOVID_WHO = 1 if `var' == 1 
local newname = substr("`var'", 6, . )
di "`newname'"
replace OD_`newname' = . if `var' == 0
replace Date_O12W_LongCOVID_WHO = min(Date_O12W_LongCOVID_WHO, OD_`newname')
}
format Date_O12W_LongCOVID_WHO %tdDD/NN/CCYY
//
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Processed_V2.dta" , replace 
***********************************************************************************************************
//Sample symptoms between 3 to 12 months before index date (to consider this variable for adjustment in the cox model looking at Long COVID as an outcome)
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed.dta", clear 
drop B12M_anxiety B12M_depression B12M_eyepressure B12M_hospital_admission B12M_orthop_pnd B12M_raisediop B12M_blurredvision
gen B12M_LongCOVID_WHO = 0 
foreach var in B12M_anosmia B12M_fatigue B12M_fever B12M_palipitations B12M_cough B12M_blurvision_diplopia B12M_chestpain B12M_shortnessofbreath B12M_paresthesia B12M_diarrhoea B12M_headache B12M_allergies B12M_insomnia B12M_constipation B12M_jointpain B12M_difficulty_thinking B12M_abdominalpain B12M_gastritis B12M_dizziness B12M_menorrhagia B12M_hyperacusis B12M_musclepain B12M_amnesia B12M_musclecramping B12M_gastricreflux B12M_depressionsym B12M_dysgeusia B12M_anxietyanddepression B12M_menstrualchanges B12M_premenstrualsyndrome B12M_excessivesleep B12M_hearingloss B12M_postexert_fatigue {
replace B12M_LongCOVID_WHO = 1 if `var' == 1 
}
//
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed_V2.dta" , replace 
***********************************************************************************************************
//between 4 to 12 weeks of diagnosis
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_Processed.dta", clear 
drop O4to12W_anxiety O4to12W_depression O4to12W_eyepressure O4to12W_hospital_admission O4to12W_orthop_pnd O4to12W_raisediop O4to12W_blurredvision
ds O4to12W*
foreach var in `r(varlist)' {
local newname = substr("`var'", 9, . )
di "`newname'"
replace OD_`newname' = . if `var' == 0
}
gen O4to12W_LongCOVID_WHO = 0 
gen Date_O4to12W_LongCOVID_WHO = .
foreach var in O4to12W_anosmia O4to12W_fatigue O4to12W_fever O4to12W_palipitations O4to12W_cough O4to12W_blurvision_diplopia O4to12W_chestpain O4to12W_shortnessofbreath O4to12W_paresthesia O4to12W_diarrhoea O4to12W_headache O4to12W_allergies O4to12W_insomnia O4to12W_constipation O4to12W_jointpain O4to12W_difficulty_thinking O4to12W_abdominalpain O4to12W_gastritis O4to12W_dizziness O4to12W_menorrhagia O4to12W_hyperacusis O4to12W_musclepain O4to12W_amnesia O4to12W_musclecramping O4to12W_gastricreflux O4to12W_depressionsym O4to12W_dysgeusia O4to12W_anxietyanddepression O4to12W_menstrualchanges O4to12W_premenstrualsyndrome O4to12W_excessivesleep O4to12W_hearingloss O4to12W_postexert_fatigue {
replace O4to12W_LongCOVID_WHO = 1 if `var' == 1 
local newname = substr("`var'", 9, . )
di "`newname'"
replace OD_`newname' = . if `var' == 0
replace Date_O4to12W_LongCOVID_WHO = min(Date_O4to12W_LongCOVID_WHO, OD_`newname')
}
format Date_O4to12W_LongCOVID_WHO %tdDD/NN/CCYY
//
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_Processed_V2.dta" , replace 
***********************************************************************************************************
//first 4 weeks of diagnosis
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_Processed.dta", clear 
drop O4W_anxiety O4W_depression O4W_eyepressure O4W_hospital_admission O4W_orthop_pnd O4W_raisediop O4W_blurredvision
ds O4W*
foreach var in `r(varlist)' {
local newname = substr("`var'", 5, . )
di "`newname'"
replace OD_`newname' = . if `var' == 0
}
gen O4W_LongCOVID_WHO = 0 
gen Date_O4W_LongCOVID_WHO = .
foreach var in O4W_anosmia O4W_fatigue O4W_fever O4W_palipitations O4W_cough O4W_blurvision_diplopia O4W_chestpain O4W_shortnessofbreath O4W_paresthesia O4W_diarrhoea O4W_headache O4W_allergies O4W_insomnia O4W_constipation O4W_jointpain O4W_difficulty_thinking O4W_abdominalpain O4W_gastritis O4W_dizziness O4W_menorrhagia O4W_hyperacusis O4W_musclepain O4W_amnesia O4W_musclecramping O4W_gastricreflux O4W_depressionsym O4W_dysgeusia O4W_anxietyanddepression O4W_menstrualchanges O4W_premenstrualsyndrome O4W_excessivesleep O4W_hearingloss O4W_postexert_fatigue {
replace O4W_LongCOVID_WHO = 1 if `var' == 1 
local newname = substr("`var'", 5, . )
di "`newname'"
replace OD_`newname' = . if `var' == 0
replace Date_O4W_LongCOVID_WHO = min(Date_O4W_LongCOVID_WHO, OD_`newname')
}
format Date_O4W_LongCOVID_WHO %tdDD/NN/CCYY
//
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_Processed_V2.dta" , replace 
***********************************************************************************************************
}

//Baseline Table [n(%) among the exposed and unexposed, standardised differences]
{
	
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
//Using the user defined stddiff program frm http://fmwww.bc.edu/repec/bocode/s/stddiff.ado 
//to obtain standardised difference 
clear all
program define stddiff, rclass
	version 13.0
	* Ahmed Bayoumi
	* version 2.1
	* 8Mar2021
	* Changes: 
	* 1. Embeds mata code into the ado file
	* 2. No longer exits with error when there are spaces in value label names
	
	syntax varlist(fv) [if] [in] , BY(varname numeric) [ ///
		COHensd  ///  report cohensd as calculated by esize
		HEDgesg ///  report hedgesg as calculated by esize 
		abs /// report absolute values
	]
	tempname sds  output 
	qui inspect `by' `if' `in' // check that by has only 2 levels
	if (r(N_unique)!=2){
		di as error "`by' can only have 2 categories"
		error 420
	}

	foreach v in `varlist'{
		fvexpand(`v')
		capture assert r(fvops)=="true"
		if(_rc==0){
			_ms_parse_parts 1.`v'
			local v=r(name)
			_stddiffm  `v' `if' `in', by(`by') `opts' `cohensd' `hedgesg' categorical	// for each, call stddiff program
		}
		else{
			_stddiffm  `v' `if' `in', by(`by') `opts' `cohensd' `hedgesg' continuous `abs' // for each, call stddiff program

		}
		matrix `sds'= nullmat(`sds') \ r(sds)
		matrix `output' = nullmat(`output') \ r(output)
		local llist ="`llist' " + r(llist)
	}
	
	stddiff_display, output(`output') llist(`llist') by("`by'")

	matrix rownames `sds' = `vlist'	
	matrix rownames `output' = `llist'
	matrix colnames `sds'=Std_Diff
	matrix colnames `output' = Mean_or_N SD_or_% Mean_or_N SD_or_% Std_Diff Var_type
	matrix coleq `output'= `by'=`l1' `by'=`l1' `by'=`l2' `by'=`l2'  .
	
	return matrix stddiff=`sds'
	return matrix output = `output'
end program	

	
program define stddiff_display
	syntax [if] [in], output(name) llist(string) by(string)
//	di as text "Standardized Differences" _n
	tempname rt
	qui tab `by' `if' `in', matrow(`rt')
	mata: st_local("isvallab",st_varvaluelabel("`by'"))
	if("`isvallab'"==""){
		mata: st_local("rstring",invtokens(strofreal(st_matrix("`rt'")')))
	}
	else{
		mata: rlist=subinstr(st_vlmap(st_varvaluelabel("`by'"),st_matrix("`rt'")')," ","_",.)
		mata: st_local("rstring",invtokens(rlist))
	}

	local l1=usubinstr(word("`rstring'",1),"_"," ",.)
	local l2=usubinstr(word("`rstring'",2),"_"," ",.)

	di as text _n "{hline 13}{c TT}{hline 25}{c TT}{hline 25}{c TT}{hline 12}" _n /*
		*/ _col(14) "{c |}" "{rcenter 25:`=abbrev("`by'=`l1'",24)' }" /*
		*/ _col(40) "{c |}" "{rcenter 25:`=abbrev("`by'=`l2'",24)' }" /*
		*/ _col(66) "{c |}" _n /*
		*/ _col(14) "{c |}{ralign 10:Mean or N} {ralign 13:SD or (%)} " /*
		*/  		"{c |}{ralign 10:Mean or N} {ralign 13:SD or (%)} " /*
		*/  "{c |}{ralign 10:Std Diff}" _n /*
		*/ "{hline 13}{c +}{hline 25}{c +}{hline 25}{c +}{hline 12}"  

	forv r=1/`=rowsof(`output')'{
		if!(`r'==1 & word("`llist'",1)=="." ) & ! (word("`llist'",`r')=="." & word("`llist'",`r'+1)==".") ///
		& !(`r'==rowsof(`output') & word("`llist'",`r')=="." ){
			di as text  %12s  abbrev(subinstr(subinstr(word("`llist'",`r'),".","",.),"_"," ",.),12) as text _col(14) "{c |} "  _c
			if(`output'[`r',1]!=.z) {
				di as result %9.4g `output'[`r',1] "  "  _c
			}
			if(`output'[`r',2]!=.z) {
				if(`output'[`r',6]==1){
					di as result %12.5g `output'[`r',2] " {c |} "  _c
				}
				else{
					di as result _skip(6) "(" %4.1f `output'[`r',2]	") {c |} "  _c
				}
			}
			else{
				di as result _col(40) as text "{c |} "  _c
			}
			if(`output'[`r',3]!=.z) {
				di as result %9.4g `output'[`r',3] "  "  _c
			}

			
			if(`output'[`r',4]!=.z) {
				if(`output'[`r',6]==1){
					di as result %12.5g `output'[`r',4] " {c |} "  _c
				}
				else{
					di as result _skip(6) "(" %4.1f `output'[`r',4]	") {c |} "  _c
				}
			}
			else{
				di as text _col(66)   "{c |}"  _c
			}
			
			if(`output'[`r',5]!=.z) {
				di as result %10.5f `output'[`r',5] 
			}
			else{
				di "" 
			}
		}
	}
	di as text "{hline 13}{c BT}{hline 25}{c BT}{hline 25}{c BT}{hline 12}"  

end program	

program define _stddiffm, rclass
        version 13.0
        syntax varlist  [if] [in], by(varname) [continuous categorical cohensd hedgesg abs]
        tempname m1 m2 v1 v2 s1 s2 res table output r
        if("`continuous'"=="" & "`categorical'"==""){
                local continuous="continuous"
        }
        if("`continuous'"=="continuous" ){
                foreach v of varlist `varlist'{
                        qui tabstat `v' `if' `in', by(`by') stat(mean n v sd) save
                        mat `s1'=r(Stat1)
                        mat `s2'=r(Stat2)
                        scalar `v1'=`s1'[3,1]
                        scalar `v2'=`s2'[3,1]
                        scalar `m1'=`s1'[1,1]
                        scalar `m2'=`s2'[1,1]
                        
                        if( "`hedgesg'"=="hedgesg"){
                                qui esize twosample `v' `if' `in' , by(`by') `hedgesg'
                                local sd=r(g)
                        }
                        else if("`cohensd'"=="cohensd"){
                                qui esize twosample `v' `if' `in', by(`by') `cohensd'
                                local sd=r(d)
                        }
                        else{
                                local sd= (`m1'-`m2') /  sqrt((`v1'+`v2' )/2)
                        }
                mat `res'=nullmat(`res') \ `sd'
                if("`abs'"=="abs") local sd=abs(`sd')
                mat `output' = nullmat(`output') \ `m1', `s1'[4,1], `m2', `s2'[4,1], `sd' , 1
                local vlist "`vlist' `v'"
                local llist "`llist' `v'"
                }
        }
        else{ // categorical varaibles
                foreach v of varlist `varlist'{
                        qui tab `v' `by' `if' `in', matcell(`table') matrow(`r')
                        mata: _matasd(st_matrix("`table'"))
                        mat `res'=nullmat(`res') \ r(std)
                        mat `output'=nullmat(`output') \ J(2,6,.z) \ (r(output) , J(rowsof(r(output)),1,2)) \ J(1,6,.z) 
                        local vv="`v' " *rowsof(r(output))
                        local vlist "`vlist' `vv'" 
                        mata: st_local("isvallab",st_varvaluelabel("`v'"))
                        if("`isvallab'"==""){
                                mata: st_local("rstring",invtokens(strofreal(st_matrix("`r'")')))
                        }
                        else{
								mata: rlist=subinstr(st_vlmap(st_varvaluelabel("`v'"),st_matrix("`r'"))," ","_",.)
                                mata: st_local("rstring",invtokens(rlist'))
                        }
                        local llist = "`llist' . `v' `rstring' ."
                }
        }
        return matrix sds = `res'
        return matrix output = `output'
        return local vlist = "`vlist'"
        return local llist = "`llist'"
end program

mata:
        void _matasd(real matrix f){
                        p=f:/colsum(f)
                        out=f[,1],p[,1]*100,f[,2],p[,2]*100,J(rows(p),1,.z)
                        T=p[|2,1 \ .,1|]
                        C=p[|2,2 \ .,2|]
                        S=-(T*T' + C*C' )/2
                        s=rowsum(p:*(1:-p))/2
                        for(i=1;i<rows(p);i++){
                                S[i,i]=s[i+1]
                        }
                        std=sqrt((T-C)'*invsym(S)*(T-C))
                        out[1,5]=std
                        st_numscalar("r(std)",std)
                        st_matrix("r(output)",out)
        }
end


**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************


foreach subgroup in BaseCohort_Patients PS_Matched_Patients  {
log using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/Table1_`subgroup'.smcl" , replace
clear
set more off
**** Loading data
use  "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/`subgroup'.dta" ,  clear 
//merge 1:1 practice_patient_id using  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational study/Temp/Symptoms_Processed.dta" , force
keep COV* Cov* LongCOVID Vaccine* *Vaccine exposed
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData", replace //create new file
tab exposed

**** Gathering the data
//columns		
local COVID_19 exposed==1
local Controls exposed==0


local columns COVID_19 Controls
local run = 0
foreach column in `columns' {
dis in r "`column'"
	use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData", clear
		keep if ``column''
		preserve //keeps data even after the dofile stops

	use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/table1_lookup.dta", clear	
	levelsof table, local(tables) //shows the number of rows
	
	foreach x in `tables' {
		dis in r "`x'"
		local run = `run' + 1
		use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/table1_lookup.dta", clear	//load the lookup table
			keep if table == `x' //focuses on 1 row at a time and moves down the variable list
			local crit = crit[1] 
			local ref = ref[1]  
			local type = type[1]   
		
		restore, pres
		
		if `type'==. {
			local txt = ""
		}
		
		if `type'==0 { // All
			count if `crit'	
			local txt = "(n=" + string(`r(N)',"%9.0fc") + ")"
			
		}
		
		if `type'==1 { // Categorical [n(%)]
			count if `ref' 
			local total = `r(N)'
			di `total'
			count if `crit' 
			local num = `r(N)'
			local percentage = (`num' / `total' ) * 100
	
			local txt = string(`num',"%9.0f") + " (" + string(`percentage', "%04.2fc") + ")"
			if `num'==0 local txt = "0 (0%)"
		}
		
		if `type'==3 { // Median (IQR)
			sum `crit', detail
			local txt = string(floor(`r(p50)'),"%04.2fc") + " (" + string(floor(`r(p25)'),"%04.2fc") + " ; " + string(floor(`r(p75)' ),"%04.2fc") + ")"
		}
		
		if `type'==2 { // Mean (SD)
			sum `crit' , detail
			local txt = string(`r(mean)',"%04.2fc")	+ " (" +  string(`r(sd)',"%04.2fc") + ")"		
		}
			
		clear
		set obs 1
		gen txt = "`txt'"
		gen table = `x'
		gen column = "`column'"
		if `run'!=1 append using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_TempTable.dta"
		save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_TempTable.dta", replace 
	}
restore		
}			
****************
		
** Finalising and creating the table
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/table1_lookup.dta", clear
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_tempinstruction.dta", replace
local columns COVID_19 Controls

foreach x in `columns'  {
	use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_TempTable.dta", clear
		keep if column=="`x'"
	joinby table using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_tempinstruction.dta", unm(using)
		drop _merge
		ren txt `x'
	save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_tempinstruction.dta", replace	
}
//
local columns COVID_19 Controls

sort table
keep table tabletxt `columns'
order tabletxt `columns'	

save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/Table1_Part1_`subgroup'.dta", replace



**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************



use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData", clear
preserve //keeps data even after the dofile stops
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/table1_lookup.dta", clear	
levelsof table, local(tables) //shows the number of rows
	
local run = 0
foreach x in `tables' {
dis in r "`x'"
local run = `run' + 1
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/table1_lookup.dta", clear	//loads that contains type of data and teh variables needed
keep if table == `x' //focuses on 1 row at a time and moves down the 
local VarNameSTD = VarNameSTD[1]    
restore, pres

if "`VarNameSTD'" == "" {
di "*********" "`VarNameSTD'"
			local txt = ""
}

if "`VarNameSTD'" != "Cov_CalenderTime" & "`VarNameSTD'" != "Cov_Ethnicity" & "`VarNameSTD'" !="Cov_townsend" & "`VarNameSTD'" != "" {
di "*********" "`VarNameSTD'"
			stddiff `VarNameSTD', by(exposed) abs
			matrix define A = r(output)
			matrix list A
			local STD = A[1,5]
			local txt = string(`STD', "%9.3f") 
			}
			
if "`VarNameSTD'" =="Cov_CalenderTime" | "`VarNameSTD'" == "Cov_Ethnicity" | "`VarNameSTD'" == "Cov_townsend" {
di "*********" "`VarNameSTD'"
			stddiff i.`VarNameSTD', by(exposed) abs
			matrix define A = r(output)
			matrix list A
			local STD = A[3,5]
			local txt = string(`STD', "%9.3f") 
			}
		clear
		set obs 1
		gen txt = "`txt'"
		gen table = `x'
		if `run' != 1 append using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_TempTable2.dta"
		save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_TempTable2.dta", replace 
		}
		//

		
** Finalising and creating part 2 of the baseline table with STDs
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/table1_lookup.dta", clear
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_tempinstruction.dta", replace

	use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_TempTable2.dta", clear
	joinby table using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_tempinstruction.dta", unm(using)
	drop _merge
	save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_tempinstruction.dta", replace	
	
sort table
keep table tabletxt txt 
order tabletxt txt

save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/Table1_Part2_`subgroup'.dta", replace

**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************
**************************************************************************************************


use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/Table1_Part2_`subgroup'.dta", clear
merge 1:1 table using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/Table1_Part1_`subgroup'.dta"
keep table tabletxt `columns' txt 
order table tabletxt `columns' txt


export excel "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/Table1_`subgroup'.xlsx", firstrow(variables) replace



log close
erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_TempTable.dta"
erase  "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_tempinstruction.dta" 
erase  "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Baseline Table/work_TempTable2.dta"
erase  "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData.dta"

restore, not
}
//
}

//Outcome Table [n(%) among the exposed and unexposed, unadjusted and adjusted HR] - after twelve weeks from index date 
{
	
foreach subgroup in New_PS_Matched_Patients  {
log using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/Log/Table2_O12W`subgroup'.smcl" , replace
clear
set more off
**** Loading data
use  "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/`subgroup'.dta" ,  clear 
sort practice_patient_id
//keep practice_patient_id exposed COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus
keep practice_patient_id exposed case_control_group COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus IndexDate TransferDate DeathDate CollectionDate
sort practice_patient_id
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Processed_V2.dta", force sorted
keep if _merge == 3
drop _merge
sort practice_patient_id
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed_V2.dta", force sorted
keep if _merge == 3
drop _merge
rename Date_O12W_LongCOVID_WHO OD_LongCOVID_WHO
//keep practice_patient_id exposed B* O* COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus
keep practice_patient_id case_control_group exposed B* O* COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus IndexDate TransferDate DeathDate CollectionDate OD_LongCOVID_WHO

save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData1", replace //create new file
tab exposed

use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData1", clear
tab exposed 

ds O12W_*
local SymptomsList `r(varlist)'
foreach Symptom in `SymptomsList' {
local vartype: type `Symptom'
local newname = substr("`Symptom'" , 6, . )
di "`newname'"

foreach ExposurePeriod in O12W {
gen ExitDate = min(TransferDate, DeathDate, CollectionDate, OD_`newname')
gen NewIndexDate = IndexDate + 84
format ExitDate NewIndexDate %tdDD/NN/CCYY
replace `ExposurePeriod'_`newname' = 0 if OD_`newname' > ExitDate

stset ExitDate, failure(`ExposurePeriod'_`newname'==1) enter(NewIndexDate)
stphplot, by(exposed) 
estat phtest, detail
capture noisily eststo: stcox exposed
di _rc
if _rc != 430 {
estout , cells(b ci) eform
matrix A = r(coefs)
matrix list A, format(%12.0e)
estout , cells(p)
matrix B = r(coefs)
matrix list B, format(%9.3f)
local pval = (B[1,1])
if `pval' >= 0.001 {
local txt1 = "p=" + string(`pval',"%9.3f") 
}
if `pval' < 0.001 {
local txt1 = "p<0.001" 
}
local HR = string(A[1,1],"%04.2fc")
local lowerCI = string(A[1,2],"%04.2fc")
local upperCI = string(A[1,3],"%04.2fc")
}
if _rc == 430 {
local HR = ""
local lowerCI = ""
local upperCI = ""
}
global U`ExposurePeriod'_`newname' = "`HR'" + " (" + "`lowerCI'" + "-" + "`upperCI'" + "); " + "`txt1'"
global UHR`ExposurePeriod'_`newname' = "`HR'" 
global UPV`ExposurePeriod'_`newname' = "`pval'" 
eststo clear

count if exposed == 1 & `ExposurePeriod'_`newname' == 1 & NewIndexDate < ExitDate
local E_N = `r(N)'
count if exposed == 1 & NewIndexDate < ExitDate
local E_Per = string(((`E_N' / `r(N)') * 100), "%04.2fc")
global E_N_`ExposurePeriod'_`newname' = "`E_N'" + " (" + "`E_Per'" + "%)"

count if exposed == 0 & `ExposurePeriod'_`newname' == 1 & NewIndexDate < ExitDate
local U_N = `r(N)'
count if exposed == 0 & NewIndexDate < ExitDate
local U_Per = string(((`U_N' / `r(N)') * 100), "%04.2fc")
global U_N_`ExposurePeriod'_`newname' = "`U_N'" + " (" + "`U_Per'" + "%)"

stset ExitDate, failure(`ExposurePeriod'_`newname'==1) enter(NewIndexDate)
capture noisily eststo: stcox exposed COV_age i.COV_sex i.COV_BMIcat i.COV_Ethnicity i.COV_Townsend i.COV_SmokingStatus
di _rc
if _rc != 430 {
estout , cells(b ci) eform
matrix A = r(coefs)
matrix list A, format(%12.0e)
estout , cells(p)
matrix B = r(coefs)
matrix list B, format(%9.3f)
local Adj_pval = (B[1,1])
if `Adj_pval' >= 0.001 {
local Adj_txt1 = "p=" + string(`Adj_pval',"%9.3f") 
}
if `Adj_pval' < 0.001 {
local Adj_txt1 = "p<0.001" 
}
local Adj_HR = string(A[1,1],"%04.2fc")
local Adj_lowerCI = string(A[1,2],"%04.2fc")
local Adj_upperCI = string(A[1,3],"%04.2fc")
}
if _rc == 430 {
local Adj_HR = ""
local Adj_lowerCI = ""
local Adj_upperCI = ""
}
global A`ExposurePeriod'_`newname' = "`Adj_HR'" + " (" + "`Adj_lowerCI'" + "-" + "`Adj_upperCI'" + "); " + "`Adj_txt1'"
global AHR`ExposurePeriod'_`newname' = "`Adj_HR'" 
global APV`ExposurePeriod'_`newname' = "`Adj_pval'" 
eststo clear

stset ExitDate, failure(`ExposurePeriod'_`newname'==1) enter(NewIndexDate)
capture noisily eststo: stcox exposed COV_age i.COV_sex i.COV_BMIcat i.COV_Ethnicity i.COV_Townsend i.COV_SmokingStatus B12M_`newname'
di _rc 
if _rc != 430 {
estout , cells(b ci) eform
matrix A = r(coefs)
matrix list A, format(%12.0e)
estout , cells(p)
matrix B = r(coefs)
matrix list B, format(%9.3f)
local BA_pval = (B[1,1])
if `BA_pval' >= 0.001 {
local BA_txt1 = "p=" + string(`BA_pval',"%9.3f") 
}
if `BA_pval' < 0.001 {
local BA_txt1 = "p<0.001" 
}
local BA_HR = string(A[1,1],"%04.2fc")
local BA_lowerCI = string(A[1,2],"%04.2fc")
local BA_upperCI = string(A[1,3],"%04.2fc")
}
if _rc == 430 {
local BA_HR = ""
local BA_lowerCI = ""
local BA_upperCI = ""
}
global BA`ExposurePeriod'_`newname' = "`BA_HR'" + " (" + "`BA_lowerCI'" + "-" + "`BA_upperCI'" + "); " + "`BA_txt1'"
global BAHR`ExposurePeriod'_`newname' = "`BA_HR'" 
global BAPV`ExposurePeriod'_`newname' = "`BA_pval'" 
eststo clear
}
drop ExitDate NewIndexDate
}
//}
ds  O12W_*
local count : word count `r(varlist)'
di `count'
ds O12W_*
local SymptomsList `r(varlist)'

clear 
set obs `count'
gen Symptom = ""
gen O12W_Exp_N = ""
gen O12W_Unexp_N = ""
gen O12W_Unadj_HR = ""
gen O12W_Unadj_HRWithCI = ""
gen O12W_Unadj_PVal = ""
gen O12W_Adj_HR = ""
gen O12W_Adj_HRWithCI = ""
gen O12W_Adj_PVal = ""
gen O12W_Base_Adj_HR = ""
gen O12W_Base_Adj_HRWithCI = ""
gen O12W_Base_Adj_PVal = ""


local i = 1
foreach Symptom in `SymptomsList' {
local newname = substr("`Symptom'" , 6, . )
di in r "`newname'" 
replace Symptom = "`newname'" if _n == `i'
di in r "`newname'" 

replace O12W_Exp_N = "${E_N_O12W_`newname'}" if _n == `i'
replace O12W_Unexp_N = "${U_N_O12W_`newname'}" if _n == `i'
replace O12W_Unadj_HR = "${UHRO12W_`newname'}" if _n == `i'
replace O12W_Unadj_HRWithCI = "${UO12W_`newname'}" if _n == `i'
replace O12W_Unadj_PVal = "${UPVO12W_`newname'}" if _n == `i'
replace O12W_Adj_HR = "${AHRO12W_`newname'}" if _n == `i'
replace O12W_Adj_HRWithCI = "${AO12W_`newname'}" if _n == `i'
replace O12W_Adj_PVal = "${APVO12W_`newname'}" if _n == `i'
replace O12W_Base_Adj_HR = "${BAHRO12W_`newname'}" if _n == `i'
replace O12W_Base_Adj_HRWithCI = "${BAO12W_`newname'}" if _n == `i'
replace O12W_Base_Adj_PVal = "${BAPVO12W_`newname'}" if _n == `i'

local i = `i' + 1
}
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results.dta", replace
			
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results.dta" , clear
foreach var in O12W_Unadj_PVal O12W_Adj_PVal O12W_Base_Adj_PVal {
gen XX`var' = real(`var')
drop `var'
rename XX`var' `var'
}
//

foreach var in O12W_Unadj_PVal O12W_Adj_PVal O12W_Base_Adj_PVal {
local newname = substr("`var'" , 1 , strpos("`var'" , "PVal")-2)
di "`newname'"

multproc, puncor(0.05) pvalue(`var') method(simes) critical(`newname'_Crit_PVal_Corr) reject(`newname'_StatSign) float
	       	
di "`r(puncor)'      uncorrected critical p-value"
di "`r(pcor)'        corrected critical p-value"
di "`r(npvalues)'    number of p-values"
di "`r(nreject)'     number of p-values rejected"

}
//

local VarOrder Symptom
foreach var in O12W {
local VarOrder `VarOrder' `var'_Exp_N `var'_Unexp_N `var'_Unadj_HR `var'_Unadj_HRWithCI `var'_Unadj_PVal `var'_Unadj_Crit_PVal_Corr `var'_Unadj_StatSign `var'_Adj_HR `var'_Adj_HRWithCI `var'_Adj_PVal `var'_Adj_Crit_PVal_Corr `var'_Adj_StatSign `var'_Base_Adj_HR `var'_Base_Adj_HRWithCI `var'_Base_Adj_PVal `var'_Base_Adj_Crit_PVal_Corr `var'_Base_Adj_StatSign
}
//

local ORDER `VarOrder'
order `VarOrder'

rename *Exp_N* *Case_N*
rename *Unexp_N* *Control_N*

save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results_V2_`subgroup'_O12W.dta" , replace
erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results.dta"
}
//
log close

}

//Generating forest plot figure 
{
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results_V2_New_PS_Matched_Patients_O12W.dta" , clear
keep Symptom
gen N = _n
gen M = _n
reshape wide N, i(M) j(Symptom) string
drop M
rename N* *
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/SymptomList.dta"  , replace

use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results_V2_New_PS_Matched_Patients_O12W.dta" , clear
merge 1:1 _n using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/SymptomList.dta"  
gen Domain  = ""
gen N = .
foreach var in shortnessofbreath sobar soboe orthopnoea pnd tachypnoea wheezing {
replace Domain = "Breathing" if Symptom == "`var'"
replace N = 1 if Symptom == "`var'"
}
foreach var in chestpain pain pleuritic_cp {
replace Domain = "Pain" if Symptom == "`var'"
replace N = 2 if Symptom == "`var'"
}
foreach var in palipitations tachycardia presyncope orthostatichypotens limbswelling coldextremeties pots {
replace Domain = "Circulation" if Symptom == "`var'"
replace N = 3 if Symptom == "`var'"
}
foreach var in fatigue postexert_fatigue {
replace Domain = "Fatigue" if Symptom == "`var'"
replace N = 4 if Symptom == "`var'"
}
foreach var in amnesia difficulty_thinking dysphasia diff_understanding readingdifficulty dysarthria {
replace Domain = "Memory, Thinking and Communication" if Symptom == "`var'"
replace N = 5 if Symptom == "`var'"
}
foreach var in tremors balancedifficulty apraxia {
replace Domain = "Movement" if Symptom == "`var'"
replace N = 6 if Symptom == "`var'"
}
foreach var in excessivesleep insomnia {
replace Domain = "Sleep" if Symptom == "`var'"
replace N = 7 if Symptom == "`var'"
}
foreach var in hyperacusis anosmia dysgeusia sneezing nasalcongest mucus cough sorethroat hoarse dysphagia earpain hearingloss {
replace Domain = "Ear, Nose, Throat" if Symptom == "`var'"
replace N = 8 if Symptom == "`var'"
}
foreach var in abdominalpain bloating nausea gastritis gastricreflux weight_loss weightgain diarrhoea constipation bowel_incontinence vomiting {
replace Domain = "Stomach and Digestion" if Symptom == "`var'"
replace N = 9 if Symptom == "`var'"
}
foreach var in musclepain asthenia jointpain jointstiffness muscle_twitch musclecramping paresthesia {
replace Domain = "Muscles and Joints" if Symptom == "`var'"
replace N = 10 if Symptom == "`var'"
}
foreach var in anhedonia anxietysym depressionsym anxietyanddepression anorexia appetiteincreased loneliness ptsd moodswings {
replace Domain = "Mental Health and Wellbeing" if Symptom == "`var'"
replace N = 11 if Symptom == "`var'"
}
foreach var in dryandscalyskin itchyskin purpura rash hiveurticariasymp hairloss nailchanges {
replace Domain = "Skin and Hair" if Symptom == "`var'"
replace N = 12 if Symptom == "`var'"
}
foreach var in eyepain redeye itchyeyes blurvision_diplopia flashinglights photophobia watery_eyes dryeyes {
replace Domain = "Eyes" if Symptom == "`var'"
replace N = 13 if Symptom == "`var'"
}
foreach var in menstrualchanges premenstrualsyndrome menorrhagia vaginaldischarge vaginaldryness anorgasm reducedlibido {
replace Domain = "Female Reproductive Health" if Symptom == "`var'"
replace N = 14 if Symptom == "`var'"
}
foreach var in erectiledysfunction ejaculationdiff reducedlibido {
replace Domain = "Male Reproductive Health" if Symptom == "`var'"
replace N = 15 if Symptom == "`var'"
}
foreach var in fever chills_shivering sweating hotflushes bodyache lymph_nodes dizziness vertigo angioedemasymp allergies urinaryincontinence urinaryretention polyuria polydipsia mouthulcer drymouth headache haemoptysis seizures hallucinations neurasthenia {
replace Domain = "Other symptoms" if Symptom == "`var'"
replace N = 16 if Symptom == "`var'"
}

drop if Domain == ""

keep if O12W_Base_Adj_StatSign == 1 
keep Symptom Domain O12W_Base_Adj_HRWithCI O12W_Base_Adj_StatSign N
rename O12W_* *
gen HR = real(substr(Base_Adj_HRWithCI, 1 , 4))
replace HR = round(HR,.01)
gen Lower = real(substr(Base_Adj_HRWithCI, 7 , 4))
replace Lower = round(Lower,.01)
gen Upper = real(substr(Base_Adj_HRWithCI, 12 , 4))
replace Upper = round(Upper,.01)
drop if HR == .
drop  Base_Adj_StatSign

gsort N -HR 

//Renaming the symptoms with spaces
replace Symptom = "Shortness of breath at rest" in 1
replace Symptom = "Wheezing" in 2
replace Symptom = "Shortness of breath" in 3
replace Symptom = "Shortness of breath on exertion" in 4

replace Symptom = "Pleuritic chest pain" in 5
replace Symptom = "Chest pain" in 6
replace Symptom = "Pain" in 7

replace Symptom = "Palpitations" in 8
replace Symptom = "Tachycardia" in 9
replace Symptom = "Limb swelling" in 10

replace Symptom = "Fatigue" in 11

replace Symptom = "Brain Fog" in 12

replace Symptom = "Insomnia" in 13

replace Symptom = "Anosmia" in 14
replace Symptom = "Sneezing" in 15
replace Symptom = "Hoarse voice" in 16
replace Symptom = "Dysphagia" in 17
replace Symptom = "Cough" in 18
replace Symptom = "Nasal congestion" in 19
replace Symptom = "Phlegm" in 20
replace Symptom = "Ear pain" in 21

replace Symptom = "Bowel incontinence" in 22
replace Symptom = "Vomitting" in 23
replace Symptom = "Nausea" in 24
replace Symptom = "Weight loss" in 25
replace Symptom = "Bloating" in 26
replace Symptom = "Diarrhoea" in 27
replace Symptom = "Abdominal pain" in 28
replace Symptom = "Constipation" in 29
replace Symptom = "Gastritis" in 30


replace Symptom = "Asthenia" in 31
replace Symptom = "Parasthesia" in 32
replace Symptom = "Joint pain" in 33

replace Symptom = "Anhedonia" in 34
replace Symptom = "Anorexia" in 35
replace Symptom = "Anxiety" in 36
replace Symptom = "Depression" in 37

replace Symptom = "Hairloss" in 38
replace Symptom = "Itchy skin" in 39
replace Symptom = "Dry and scaly skin" in 40
replace Symptom = "Rash" in 41
replace Symptom = "Nail changes" in 42

replace Symptom = "Red eye" in 43
replace Symptom = "Dry eye" in 44

replace Symptom = "Vaginal discharge" in 45
replace Symptom = "Menorrhagia" in 46
replace Symptom = "Ejaculation difficulty" in 47
replace Symptom = "Reduced libido" in 48
replace Symptom = "Erectile dysfunction" in 49

replace Symptom = "Fever" in 50
replace Symptom = "Mouth ulcer" in 51
replace Symptom = "Urinary retention" in 52
replace Symptom = "Dry mouth" in 53
replace Symptom = "Hot flushes" in 54
replace Symptom = "Body ache" in 55
replace Symptom = "Haemoptysis" in 56
replace Symptom = "Urinary incontinence" in 57
replace Symptom = "Allergies" in 58
replace Symptom = "Headache" in 59
replace Symptom = "Polyuria" in 60
replace Symptom = "Dizziness" in 61
replace Symptom = "Vertigo" in 62

replace HR = log(HR)
replace Lower = log(Lower)
replace Upper = log(Upper)
meta set HR Lower Upper, civartol(0.5) studylabel(Symptom) eslabel("") 
foreach var in  _meta_es _meta_se _meta_cil _meta_ciu {
replace `var' = round(`var', 0.01)
}

*******************************************
meta forestplot _id _plot _esci, ///
nowmarkers noomarker noohetstats noosigtest noohomtest noghetstats nooverall nonote ///
xscale(log range(0.25 20) lwidth(vvthin)) xlabel(0.25 1 4 20 , labsize(1.5) noticks) xmtick(none)  ///
 markeropts(msize(.0001cm)) ///
 ciopts(lwidth(vvthin) mlwidth(none)) ///
 bodyopts(size(1.5pt)) ///
 coltitleopts(size(2pt)) ///
  hruleopts(lwidth(vvthin)) ///
  graphregion(margin(zero)) ///
  itemopts(linegap(1.5)) ///
  columnopts(_es, mask("%-6.2fc") margin(0 1 0 0 ) ) ///
  columnopts(_lb, mask("[%3.2fc,")) ///
  columnopts(_ub, mask("%-3.2fc]")) ///
  eform nullrefline(lpattern(dot) lcolor(red) lwidth(0.15pt))  ///
  ysize(2.2) xsize(1.5) 

graph save "Graph" "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Results/V2/ForestPlot.gph", replace
graph export "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Results/V2/ForestPlot.pdf", as(pdf) name("Graph") replace	
}

//Outcome Table [n(%) among the exposed and unexposed, unadjusted and adjusted HR]- between four to twelve weeks from index date 
{

foreach subgroup in New_PS_Matched_Patients  {
log using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/Log/Table2_O4to12W`subgroup'.smcl" , replace
clear
set more off
**** Loading data
use  "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/`subgroup'.dta" ,  clear 
sort practice_patient_id
//keep practice_patient_id exposed COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus
keep practice_patient_id exposed case_control_group COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus IndexDate TransferDate DeathDate CollectionDate
sort practice_patient_id
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_Processed_V2.dta", force sorted
keep if _merge == 3
drop _merge
sort practice_patient_id
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed_V2.dta", force sorted
keep if _merge == 3
drop _merge
rename Date_O4to12W_LongCOVID_WHO OD_LongCOVID_WHO
//keep practice_patient_id exposed B* O* COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus
keep practice_patient_id case_control_group exposed B* O* COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus IndexDate TransferDate DeathDate CollectionDate OD_LongCOVID_WHO

save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData2", replace //create new file
tab exposed

use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData2", clear
tab exposed 

ds O4to12W_*
local SymptomsList `r(varlist)'
foreach Symptom in `SymptomsList' {
local vartype: type `Symptom'
local newname = substr("`Symptom'" , 9, . )
di "`newname'"

foreach ExposurePeriod in O4to12W {
gen ExitDate = min(TransferDate, DeathDate, CollectionDate, (IndexDate+84), OD_`newname')
format ExitDate %tdDD/NN/CCYY
gen NewIndexDate = IndexDate + 24
format NewIndexDate %tdDD/NN/CCYY 
replace `ExposurePeriod'_`newname' = 0 if OD_`newname' > ExitDate

stset ExitDate, failure(`ExposurePeriod'_`newname'==1) enter(NewIndexDate)
capture noisily eststo: stcox exposed
di _rc 
if _rc != 430 {
estout , cells(b ci) eform
matrix A = r(coefs)
matrix list A, format(%12.0e)
estout , cells(p)
matrix B = r(coefs)
matrix list B, format(%9.3f)
local pval = (B[1,1])
if `pval' >= 0.001 {
local txt1 = "p=" + string(`pval',"%9.3f") 
}
if `pval' < 0.001 {
local txt1 = "p<0.001" 
}
local HR = string(A[1,1],"%04.2fc")
local lowerCI = string(A[1,2],"%04.2fc")
local upperCI = string(A[1,3],"%04.2fc")
}
if _rc == 430 {
local HR = ""
local lowerCI = ""
local upperCI = ""
}
global U`ExposurePeriod'_`newname' = "`HR'" + " (" + "`lowerCI'" + "-" + "`upperCI'" + "); " + "`txt1'"
global UHR`ExposurePeriod'_`newname' = "`HR'" 
global UPV`ExposurePeriod'_`newname' = "`pval'" 
eststo clear

count if exposed == 1 & `ExposurePeriod'_`newname' == 1 & NewIndexDate < ExitDate
local E_N = `r(N)'
count if exposed == 1 & NewIndexDate < ExitDate
local E_Per = string(((`E_N' / `r(N)') * 100), "%04.2fc")
global E_N_`ExposurePeriod'_`newname' = "`E_N'" + " (" + "`E_Per'" + "%)"

count if exposed == 0 & `ExposurePeriod'_`newname' == 1 & NewIndexDate < ExitDate
local U_N = `r(N)'
count if exposed == 0 & NewIndexDate < ExitDate
local U_Per = string(((`U_N' / `r(N)') * 100), "%04.2fc")
global U_N_`ExposurePeriod'_`newname' = "`U_N'" + " (" + "`U_Per'" + "%)"

stset ExitDate, failure(`ExposurePeriod'_`newname'==1) enter(NewIndexDate)
capture noisily eststo: stcox exposed COV_age i.COV_sex i.COV_BMIcat i.COV_Ethnicity i.COV_Townsend i.COV_SmokingStatus
di _rc 
if _rc != 430 {
estout , cells(b ci) eform
matrix A = r(coefs)
matrix list A, format(%12.0e)
estout , cells(p)
matrix B = r(coefs)
matrix list B, format(%9.3f)
local Adj_pval = (B[1,1])
if `Adj_pval' >= 0.001 {
local Adj_txt1 = "p=" + string(`Adj_pval',"%9.3f") 
}
if `Adj_pval' < 0.001 {
local Adj_txt1 = "p<0.001" 
}
local Adj_HR = string(A[1,1],"%04.2fc")
local Adj_lowerCI = string(A[1,2],"%04.2fc")
local Adj_upperCI = string(A[1,3],"%04.2fc")
}
if _rc == 430 {
local Adj_HR = ""
local Adj_lowerCI = ""
local Adj_upperCI = ""
}
global A`ExposurePeriod'_`newname' = "`Adj_HR'" + " (" + "`Adj_lowerCI'" + "-" + "`Adj_upperCI'" + "); " + "`Adj_txt1'"
global AHR`ExposurePeriod'_`newname' = "`Adj_HR'" 
global APV`ExposurePeriod'_`newname' = "`Adj_pval'" 
eststo clear

stset ExitDate, failure(`ExposurePeriod'_`newname'==1) enter(NewIndexDate)
capture noisily eststo: stcox exposed COV_age i.COV_sex i.COV_BMIcat i.COV_Ethnicity i.COV_Townsend i.COV_SmokingStatus B12M_`newname'
di _rc 
if _rc != 430 {
estout , cells(b ci) eform
matrix A = r(coefs)
matrix list A, format(%12.0e)
estout , cells(p)
matrix B = r(coefs)
matrix list B, format(%9.3f)
local BA_pval = (B[1,1])
if `BA_pval' >= 0.001 {
local BA_txt1 = "p=" + string(`BA_pval',"%9.3f") 
}
if `BA_pval' < 0.001 {
local BA_txt1 = "p<0.001" 
}
local BA_HR = string(A[1,1],"%04.2fc")
local BA_lowerCI = string(A[1,2],"%04.2fc")
local BA_upperCI = string(A[1,3],"%04.2fc")
}
if _rc == 430 {
local BA_HR = ""
local BA_lowerCI = ""
local BA_upperCI = ""
}
global BA`ExposurePeriod'_`newname' = "`BA_HR'" + " (" + "`BA_lowerCI'" + "-" + "`BA_upperCI'" + "); " + "`BA_txt1'"
global BAHR`ExposurePeriod'_`newname' = "`BA_HR'" 
global BAPV`ExposurePeriod'_`newname' = "`BA_pval'" 
eststo clear
}
drop ExitDate NewIndexDate
}
//}
ds  O4to12W_*
local count : word count `r(varlist)'
di `count'
ds O4to12W_*
local SymptomsList `r(varlist)'

clear 
set obs `count'
gen Symptom = ""
gen O4to12W_Exp_N = ""
gen O4to12W_Unexp_N = ""
gen O4to12W_Unadj_HR = ""
gen O4to12W_Unadj_HRWithCI = ""
gen O4to12W_Unadj_PVal = ""
gen O4to12W_Adj_HR = ""
gen O4to12W_Adj_HRWithCI = ""
gen O4to12W_Adj_PVal = ""
gen O4to12W_Base_Adj_HR = ""
gen O4to12W_Base_Adj_HRWithCI = ""
gen O4to12W_Base_Adj_PVal = ""


local i = 1
foreach Symptom in `SymptomsList' {
local newname = substr("`Symptom'" , 9, . )
di in r "`newname'" 
replace Symptom = "`newname'" if _n == `i'
di in r "`newname'" 

replace O4to12W_Exp_N = "${E_N_O4to12W_`newname'}" if _n == `i'
replace O4to12W_Unexp_N = "${U_N_O4to12W_`newname'}" if _n == `i'
replace O4to12W_Unadj_HR = "${UHRO4to12W_`newname'}" if _n == `i'
replace O4to12W_Unadj_HRWithCI = "${UO4to12W_`newname'}" if _n == `i'
replace O4to12W_Unadj_PVal = "${UPVO4to12W_`newname'}" if _n == `i'
replace O4to12W_Adj_HR = "${AHRO4to12W_`newname'}" if _n == `i'
replace O4to12W_Adj_HRWithCI = "${AO4to12W_`newname'}" if _n == `i'
replace O4to12W_Adj_PVal = "${APVO4to12W_`newname'}" if _n == `i'
replace O4to12W_Base_Adj_HR = "${BAHRO4to12W_`newname'}" if _n == `i'
replace O4to12W_Base_Adj_HRWithCI = "${BAO4to12W_`newname'}" if _n == `i'
replace O4to12W_Base_Adj_PVal = "${BAPVO4to12W_`newname'}" if _n == `i'

local i = `i' + 1
}
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results.dta", replace
			
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results.dta" , clear
foreach var in O4to12W_Unadj_PVal O4to12W_Adj_PVal O4to12W_Base_Adj_PVal {
gen XX`var' = real(`var')
drop `var'
rename XX`var' `var'
}
//

foreach var in O4to12W_Unadj_PVal O4to12W_Adj_PVal O4to12W_Base_Adj_PVal {
local newname = substr("`var'" , 1 , strpos("`var'" , "PVal")-2)
di "`newname'"

multproc, puncor(0.05) pvalue(`var') method(simes) critical(`newname'_Crit_PVal_Corr) reject(`newname'_StatSign) float
	       	
di "`r(puncor)'      uncorrected critical p-value"
di "`r(pcor)'        corrected critical p-value"
di "`r(npvalues)'    number of p-values"
di "`r(nreject)'     number of p-values rejected"

}
//

local VarOrder Symptom
foreach var in O4to12W {
local VarOrder `VarOrder' `var'_Exp_N `var'_Unexp_N `var'_Unadj_HR `var'_Unadj_HRWithCI `var'_Unadj_PVal `var'_Unadj_Crit_PVal_Corr `var'_Unadj_StatSign `var'_Adj_HR `var'_Adj_HRWithCI `var'_Adj_PVal `var'_Adj_Crit_PVal_Corr `var'_Adj_StatSign `var'_Base_Adj_HR `var'_Base_Adj_HRWithCI `var'_Base_Adj_PVal `var'_Base_Adj_Crit_PVal_Corr `var'_Base_Adj_StatSign
}
//

local ORDER `VarOrder'
order `VarOrder'

rename *Exp_N* *Case_N*
rename *Unexp_N* *Control_N*

save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results_V2_`subgroup'_O4to12W.dta" , replace
erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results.dta"
}
//
log close
	
}

//Outcome Table [n(%) among the exposed and unexposed, unadjusted and adjusted HR]- within the first four weeks from index date 
{

foreach subgroup in New_PS_Matched_Patients  {
log using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/Log/Table2_O4W`subgroup'.smcl" , replace
clear
set more off
**** Loading data
use  "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/`subgroup'.dta" ,  clear 
sort practice_patient_id
//keep practice_patient_id exposed COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus
keep practice_patient_id exposed case_control_group COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus IndexDate TransferDate DeathDate CollectionDate
sort practice_patient_id
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_Processed_V2.dta", force sorted
keep if _merge == 3
drop _merge
sort practice_patient_id
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed_V2.dta", force sorted
keep if _merge == 3
drop _merge
rename Date_O4W_LongCOVID_WHO OD_LongCOVID_WHO
//keep practice_patient_id exposed B* O* COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus
keep practice_patient_id case_control_group exposed B* O* COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus IndexDate TransferDate DeathDate CollectionDate

save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData3", replace //create new file
tab exposed

use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData3", clear
tab exposed 

ds O4W*
local SymptomsList `r(varlist)'
foreach Symptom in `SymptomsList' {
local vartype: type `Symptom'
local newname = substr("`Symptom'" , 5, . )
di "`newname'"

foreach ExposurePeriod in O4W {
gen ExitDate = min(TransferDate, DeathDate, CollectionDate, (IndexDate+28), OD_`newname')
format ExitDate %tdDD/NN/CCYY
replace `ExposurePeriod'_`newname' = 0 if OD_`newname' > ExitDate

stset ExitDate, failure(`ExposurePeriod'_`newname'==1) enter(IndexDate)
capture noisily eststo: stcox exposed
di _rc 
if _rc != 430 {
estout , cells(b ci) eform
matrix A = r(coefs)
matrix list A, format(%12.0e)
estout , cells(p)
matrix B = r(coefs)
matrix list B, format(%9.3f)
local pval = (B[1,1])
if `pval' >= 0.001 {
local txt1 = "p=" + string(`pval',"%9.3f") 
}
if `pval' < 0.001 {
local txt1 = "p<0.001" 
}
local HR = string(A[1,1],"%04.2fc")
local lowerCI = string(A[1,2],"%04.2fc")
local upperCI = string(A[1,3],"%04.2fc")
}
if _rc == 430 {
local HR = ""
local lowerCI = ""
local upperCI = ""
}
global U`ExposurePeriod'_`newname' = "`HR'" + " (" + "`lowerCI'" + "-" + "`upperCI'" + "); " + "`txt1'"
global UHR`ExposurePeriod'_`newname' = "`HR'" 
global UPV`ExposurePeriod'_`newname' = "`pval'" 
eststo clear

count if exposed == 1 & `ExposurePeriod'_`newname' == 1
local E_N = `r(N)'
count if exposed == 1
local E_Per = string(((`E_N' / `r(N)') * 100), "%04.2fc")
global E_N_`ExposurePeriod'_`newname' = "`E_N'" + " (" + "`E_Per'" + "%)"

count if exposed == 0 & `ExposurePeriod'_`newname' == 1
local U_N = `r(N)'
count if exposed == 0
local U_Per = string(((`U_N' / `r(N)') * 100), "%04.2fc")
global U_N_`ExposurePeriod'_`newname' = "`U_N'" + " (" + "`U_Per'" + "%)"

stset ExitDate, failure(`ExposurePeriod'_`newname'==1) enter(IndexDate)
capture noisily eststo: stcox exposed COV_age i.COV_sex i.COV_BMIcat i.COV_Ethnicity i.COV_Townsend i.COV_SmokingStatus
di _rc 
if _rc != 430 {
estout , cells(b ci) eform
matrix A = r(coefs)
matrix list A, format(%12.0e)
estout , cells(p)
matrix B = r(coefs)
matrix list B, format(%9.3f)
local Adj_pval = (B[1,1])
if `Adj_pval' >= 0.001 {
local Adj_txt1 = "p=" + string(`Adj_pval',"%9.3f") 
}
if `Adj_pval' < 0.001 {
local Adj_txt1 = "p<0.001" 
}
local Adj_HR = string(A[1,1],"%04.2fc")
local Adj_lowerCI = string(A[1,2],"%04.2fc")
local Adj_upperCI = string(A[1,3],"%04.2fc")
}
if _rc == 430 {
local Adj_HR = ""
local Adj_lowerCI = ""
local Adj_upperCI = ""
}
global A`ExposurePeriod'_`newname' = "`Adj_HR'" + " (" + "`Adj_lowerCI'" + "-" + "`Adj_upperCI'" + "); " + "`Adj_txt1'"
global AHR`ExposurePeriod'_`newname' = "`Adj_HR'" 
global APV`ExposurePeriod'_`newname' = "`Adj_pval'" 
eststo clear

stset ExitDate, failure(`ExposurePeriod'_`newname'==1) enter(IndexDate)
capture noisily eststo: stcox exposed COV_age i.COV_sex i.COV_BMIcat i.COV_Ethnicity i.COV_Townsend i.COV_SmokingStatus B12M_`newname'
di _rc 
if _rc != 430 {
estout , cells(b ci) eform
matrix A = r(coefs)
matrix list A, format(%12.0e)
estout , cells(p)
matrix B = r(coefs)
matrix list B, format(%9.3f)
local BA_pval = (B[1,1])
if `BA_pval' >= 0.001 {
local BA_txt1 = "p=" + string(`BA_pval',"%9.3f") 
}
if `BA_pval' < 0.001 {
local BA_txt1 = "p<0.001" 
}
local BA_HR = string(A[1,1],"%04.2fc")
local BA_lowerCI = string(A[1,2],"%04.2fc")
local BA_upperCI = string(A[1,3],"%04.2fc")
}
if _rc == 430 {
local BA_HR = ""
local BA_lowerCI = ""
local BA_upperCI = ""
}
global BA`ExposurePeriod'_`newname' = "`BA_HR'" + " (" + "`BA_lowerCI'" + "-" + "`BA_upperCI'" + "); " + "`BA_txt1'"
global BAHR`ExposurePeriod'_`newname' = "`BA_HR'" 
global BAPV`ExposurePeriod'_`newname' = "`BA_pval'" 
eststo clear
}
drop ExitDate
}
//}
ds  O4W*
local count : word count `r(varlist)'
di `count'
ds O4W*
local SymptomsList `r(varlist)'

clear 
set obs `count'
gen Symptom = ""
gen O4W_Exp_N = ""
gen O4W_Unexp_N = ""
gen O4W_Unadj_HR = ""
gen O4W_Unadj_HRWithCI = ""
gen O4W_Unadj_PVal = ""
gen O4W_Adj_HR = ""
gen O4W_Adj_HRWithCI = ""
gen O4W_Adj_PVal = ""
gen O4W_Base_Adj_HR = ""
gen O4W_Base_Adj_HRWithCI = ""
gen O4W_Base_Adj_PVal = ""


local i = 1
foreach Symptom in `SymptomsList' {
local newname = substr("`Symptom'" , 5, . )
di in r "`newname'" 
replace Symptom = "`newname'" if _n == `i'
di in r "`newname'" 

replace O4W_Exp_N = "${E_N_O4W_`newname'}" if _n == `i'
replace O4W_Unexp_N = "${U_N_O4W_`newname'}" if _n == `i'
replace O4W_Unadj_HR = "${UHRO4W_`newname'}" if _n == `i'
replace O4W_Unadj_HRWithCI = "${UO4W_`newname'}" if _n == `i'
replace O4W_Unadj_PVal = "${UPVO4W_`newname'}" if _n == `i'
replace O4W_Adj_HR = "${AHRO4W_`newname'}" if _n == `i'
replace O4W_Adj_HRWithCI = "${AO4W_`newname'}" if _n == `i'
replace O4W_Adj_PVal = "${APVO4W_`newname'}" if _n == `i'
replace O4W_Base_Adj_HR = "${BAHRO4W_`newname'}" if _n == `i'
replace O4W_Base_Adj_HRWithCI = "${BAO4W_`newname'}" if _n == `i'
replace O4W_Base_Adj_PVal = "${BAPVO4W_`newname'}" if _n == `i'

local i = `i' + 1
}
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results.dta", replace
			
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results.dta" , clear
foreach var in O4W_Unadj_PVal O4W_Adj_PVal O4W_Base_Adj_PVal {
gen XX`var' = real(`var')
drop `var'
rename XX`var' `var'
}
//

foreach var in O4W_Unadj_PVal O4W_Adj_PVal O4W_Base_Adj_PVal {
local newname = substr("`var'" , 1 , strpos("`var'" , "PVal")-2)
di "`newname'"

multproc, puncor(0.05) pvalue(`var') method(simes) critical(`newname'_Crit_PVal_Corr) reject(`newname'_StatSign) float
	       	
di "`r(puncor)'      uncorrected critical p-value"
di "`r(pcor)'        corrected critical p-value"
di "`r(npvalues)'    number of p-values"
di "`r(nreject)'     number of p-values rejected"

}
//

local VarOrder Symptom
foreach var in O4W {
local VarOrder `VarOrder' `var'_Exp_N `var'_Unexp_N `var'_Unadj_HR `var'_Unadj_HRWithCI `var'_Unadj_PVal `var'_Unadj_Crit_PVal_Corr `var'_Unadj_StatSign `var'_Adj_HR `var'_Adj_HRWithCI `var'_Adj_PVal `var'_Adj_Crit_PVal_Corr `var'_Adj_StatSign `var'_Base_Adj_HR `var'_Base_Adj_HRWithCI `var'_Base_Adj_PVal `var'_Base_Adj_Crit_PVal_Corr `var'_Base_Adj_StatSign
}
//

local ORDER `VarOrder'
order `VarOrder'

rename *Exp_N* *Case_N*
rename *Unexp_N* *Control_N*

save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results_V2_`subgroup'_O4W.dta" , replace
erase "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results.dta"
}
//
log close

}

//Long COVID definition according to the UOB criteria (at least one of the symptoms observed to be statistically significant between patients with and without COVID-19 after twelve weeks from index date)
{
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Outcome Table/results_V2_New_PS_Matched_Patients_O12W.dta", clear

forval i = 1/121 {
quietly count if O12W_Base_Adj_StatSign[`i'] == 1 & real(O12W_Base_Adj_HR[`i']) >= 1
if `r(N)' > 0 {
di Symptom[`i']
}
}
	
//fever anorexia reducedlibido dizziness vertigo drymouth insomnia urinaryincontinence asthenia mouthulcer nasalcongest anhedonia diarrhoea cough palipitations tachycardia limbswelling anosmia abdominalpain jointpain fatigue shortnessofbreath haemoptysis dysphagia gastritis soboe sobar sneezing earpain paresthesia anxietysym bowel_incontinence depressionsym bodyache hotflushes chestpain headache redeye wheezing vomiting rash weight_loss constipation polyuria urinaryretention pain pleuritic_cp mucus dryandscalyskin itchyskin menorrhagia hairloss erectiledysfunction ejaculationdiff vaginaldischarge hoarse nailchanges difficulty_thinking allergies bloating nausea dryeyes

***********************************************************************************************************
//after 12 weeks of diganosis (Long COVID)
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Processed_V2.dta", clear 

gen O12W_LongCOVID_UOB = 0 
gen Date_O12W_LongCOVID_UOB = .
foreach var in fever anorexia reducedlibido dizziness vertigo drymouth insomnia urinaryincontinence asthenia mouthulcer nasalcongest anhedonia diarrhoea cough palipitations tachycardia limbswelling anosmia abdominalpain jointpain fatigue shortnessofbreath haemoptysis dysphagia gastritis soboe sobar sneezing earpain paresthesia anxietysym bowel_incontinence depressionsym bodyache hotflushes chestpain headache redeye wheezing vomiting rash weight_loss constipation polyuria urinaryretention pain pleuritic_cp mucus dryandscalyskin itchyskin menorrhagia hairloss erectiledysfunction ejaculationdiff vaginaldischarge hoarse nailchanges difficulty_thinking allergies bloating nausea dryeyes {
replace O12W_LongCOVID_UOB = 1 if O12W_`var' == 1 
replace OD_`var' = . if O12W_`var' == 0
replace Date_O12W_LongCOVID_UOB = min(Date_O12W_LongCOVID_UOB, OD_`var')
}
format Date_O12W_LongCOVID_UOB %tdDD/NN/CCYY
//
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Processed_V3.dta" , replace 
***********************************************************************************************************
//between 3 to 12 months before index date
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed_V2.dta", clear 
gen B12M_LongCOVID_UOB = 0 
foreach var in fever anorexia reducedlibido dizziness vertigo drymouth insomnia urinaryincontinence asthenia mouthulcer nasalcongest anhedonia diarrhoea cough palipitations tachycardia limbswelling anosmia abdominalpain jointpain fatigue shortnessofbreath haemoptysis dysphagia gastritis soboe sobar sneezing earpain paresthesia anxietysym bowel_incontinence depressionsym bodyache hotflushes chestpain headache redeye wheezing vomiting rash weight_loss constipation polyuria urinaryretention pain pleuritic_cp mucus dryandscalyskin itchyskin menorrhagia hairloss erectiledysfunction ejaculationdiff vaginaldischarge hoarse nailchanges difficulty_thinking allergies bloating nausea dryeyes {
replace B12M_LongCOVID_UOB = 1 if B12M_`var' == 1 
}
//
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed_V3.dta" , replace 
***********************************************************************************************************
//between 4 to 12 weeks of diagnosis
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_Processed_V2.dta", clear 
gen O4to12W_LongCOVID_UOB = 0 
gen Date_O4to12W_LongCOVID_UOB = .
foreach var in fever anorexia reducedlibido dizziness vertigo drymouth insomnia urinaryincontinence asthenia mouthulcer nasalcongest anhedonia diarrhoea cough palipitations tachycardia limbswelling anosmia abdominalpain jointpain fatigue shortnessofbreath haemoptysis dysphagia gastritis soboe sobar sneezing earpain paresthesia anxietysym bowel_incontinence depressionsym bodyache hotflushes chestpain headache redeye wheezing vomiting rash weight_loss constipation polyuria urinaryretention pain pleuritic_cp mucus dryandscalyskin itchyskin menorrhagia hairloss erectiledysfunction ejaculationdiff vaginaldischarge hoarse nailchanges difficulty_thinking allergies bloating nausea dryeyes {
replace O4to12W_LongCOVID_UOB = 1 if O4to12W_`var' == 1 
replace OD_`var' = . if O4to12W_`var' == 0
replace Date_O4to12W_LongCOVID_UOB = min(Date_O4to12W_LongCOVID_UOB, OD_`var')
}
format Date_O4to12W_LongCOVID_UOB %tdDD/NN/CCYY
//
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms3_Processed_V3.dta" , replace 
***********************************************************************************************************
//first 4 weeks of diagnosis
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_Processed_V2.dta", clear 

gen O4W_LongCOVID_UOB = 0 
gen Date_O4W_LongCOVID_UOB = .
foreach var in fever anorexia reducedlibido dizziness vertigo drymouth insomnia urinaryincontinence asthenia mouthulcer nasalcongest anhedonia diarrhoea cough palipitations tachycardia limbswelling anosmia abdominalpain jointpain fatigue shortnessofbreath haemoptysis dysphagia gastritis soboe sobar sneezing earpain paresthesia anxietysym bowel_incontinence depressionsym bodyache hotflushes chestpain headache redeye wheezing vomiting rash weight_loss constipation polyuria urinaryretention pain pleuritic_cp mucus dryandscalyskin itchyskin menorrhagia hairloss erectiledysfunction ejaculationdiff vaginaldischarge hoarse nailchanges difficulty_thinking allergies bloating nausea dryeyes {
replace O4W_LongCOVID_UOB = 1 if O4W_`var' == 1 
replace OD_`var' = . if O4W_`var' == 0
replace Date_O4W_LongCOVID_UOB = min(Date_O4W_LongCOVID_UOB, OD_`var')
}
format Date_O4W_LongCOVID_UOB %tdDD/NN/CCYY
//
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms1_Processed_V3.dta" , replace 
***********************************************************************************************************
}

//Checking for unobserved confounding
{
log using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Results/V2/UnobservedConfoundingCheck1.smcl" , replace
****************E-value*****************************************************
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PS_Matched_Patients.dta" , clear
sort practice_patient_id
keep practice_patient_id
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Subset.dta"
keep if _merge == 3 
gen NewIndexDate = IndexDate + 84
gen ExitDate = min(TransferDate, CollectionDate, DeathDate, Date_O12W_LongCOVID_WHO)
replace O12W_LongCOVID_WHO = 0 if Date_O12W_LongCOVID_WHO > ExitDate

gen ExitDate2 = min(TransferDate, CollectionDate, DeathDate, Date_O12W_LongCOVID_UOB)
replace O12W_LongCOVID_UOB = 0 if Date_O12W_LongCOVID_UOB > ExitDate2

tab O12W_LongCOVID_WHO exposed if NewIndexDate < ExitDate, col
tab O12W_LongCOVID_UOB exposed if NewIndexDate < ExitDate2, col

stset ExitDate, enter(NewIndexDate) failure(O12W_LongCOVID_WHO == 1)
stcox exposed, hr
stcox exposed COV_age i.COV_sex i.COV_BMIcat i.COV_Ethnicity i.COV_Townsend i.COV_SmokingStatus , hr
stcox exposed COV_age i.COV_sex i.COV_BMIcat i.COV_Ethnicity i.COV_Townsend i.COV_SmokingStatus B12M_LongCOVID_WHO , hr
//HR: 1.26 (1.25-1.28)
evalue rr 1.26, lcl(1.25) ucl(1.28) figure
//E-value - 1.832,1.832

stset ExitDate2, enter(NewIndexDate) failure(O12W_LongCOVID_UOB == 1)
stcox exposed, hr
stcox exposed COV_age i.COV_sex i.COV_BMIcat i.COV_Ethnicity i.COV_Townsend i.COV_SmokingStatus , hr
stcox exposed COV_age i.COV_sex i.COV_BMIcat i.COV_Ethnicity i.COV_Townsend i.COV_SmokingStatus B12M_LongCOVID_WHO , hr
//HR: 1.29 (1.28-1.31)
evalue rr 1.29, lcl(1.28) ucl(1.31) figure
//E-value - 1.902,1.902

************************MH bounds*******************************************
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PScore_Patients.dta" , clear
keep exposed ID practice_patient_id PScore _support _weight B12M_pain COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus IndexDate TransferDate CollectionDate DeathDate
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Processed_V3.dta"
keep if _merge == 3  
keep exposed ID practice_patient_id PScore _support _weight B12M_pain COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus IndexDate CollectionDate TransferDate DeathDate Date_O12W_LongCOVID_WHO O12W_LongCOVID_WHO Date_O12W_LongCOVID_UOB O12W_LongCOVID_UOB
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed_V3.dta"
keep if _merge == 3
keep exposed ID practice_patient_id PScore _support _weight B12M_pain COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus IndexDate CollectionDate TransferDate DeathDate Date_O12W_LongCOVID_WHO O12W_LongCOVID_WHO B12M_LongCOVID_WHO Date_O12W_LongCOVID_UOB O12W_LongCOVID_UOB B12M_LongCOVID_UOB 
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Subset.dta"  , replace

use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Subset.dta"   , clear 
sort ID
mhbounds O12W_LongCOVID_WHO, gamma(1(0.01)2) treated(exposed) 
//A confounder with a gamma (OR) of 1.26 with treatment selection and that can perfectly predict the outcome LongCOVID will explain the who effect of COVID on the outcome.
mhbounds O12W_LongCOVID_UOB, gamma(1(0.01)2) treated(exposed) 
log close
*****************************************************************************
//glm O12W_LongCOVID_WHO exposed, fam(poisson) link(log) nolog vce(robust) eform //naive treatment effect 
log using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Results/V2/UnobservedConfoundingCheck2.smcl" , replace
//Finding the biggest confounder
//Findng the covariate that has the maximum impact on the OR after adjustment.
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PScore_Patients.dta" , clear
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Processed_V3.dta"
keep exposed ID practice_patient_id PScore _support _weight COV_VaccineProcedure O12W_LongCOVID_WHO O12W_LongCOVID_UOB Cov_* COV_* B12M*
********
eststo: logit O12W_LongCOVID_WHO exposed, or 
estout , cells(b) eform
matrix A = r(coefs)
local UnadjOR = A[1,1]
di "`UnadjOR'"
eststo clear
********
ds Cov_* COV_* B12M*
foreach var in `r(varlist)' {
quietly eststo: logit O12W_LongCOVID_WHO exposed i.`var', or 
quietly estout , cells(b) eform 
matrix A = r(coefs)
local AdjOR = A[1,1]
//di "`AdjOR'"
local PercentageChange = (( `AdjOR' - `UnadjOR' ) / `UnadjOR' ) * 100
di "`var' -------->" _column(100) "`PercentageChange'"
eststo clear
}
//
logit O12W_LongCOVID_WHO exposed , or 
logit O12W_LongCOVID_WHO exposed B12M_pain, or 
 //Pain is decided as the biggest confounder, reducing the effect estimate by 5%

use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Subset.dta"   , clear 
sort ID
attnd O12W_LongCOVID_WHO exposed, pscore(PScore)
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Subset.dta"   , clear 
sort ID
sensatt O12W_LongCOVID_WHO exposed , p(B12M_pain) r(100) pscore(PScore) alg(attnd) bootstrap
log close
}

//Coding candidate predictors for Long COVID risk factor model 
{
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/BaseCohort_Patients.dta", clear 
keep if exposed == 1
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed_V3.dta"
keep if _merge == 3 
keep practice_patient_id practice_id exposed *Date Cov_* COV_* B12M_LongCOVID_WHO B12M_LongCOVID_UOB *_VaccineProcedure *_VaccineSecondDose *_VaccineFirstDose
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Processed_V3.dta" 
keep if _merge == 3 
keep practice_patient_id practice_id exposed *Date Cov_* COV_* B12M_LongCOVID_WHO *_VaccineProcedure *_VaccineSecondDose *_VaccineFirstDose O12W_LongCOVID_WHO Date_O12W_LongCOVID_WHO O12W_LongCOVID_UOB Date_O12W_LongCOVID_UOB

gen LongCOVID_ExitDate = min(DeathDate, TransferDate, CollectionDate, Date_O12W_LongCOVID_WHO, td(24/08/2021))
format LongCOVID_ExitDate %tdDD/NN/CCYY

gen LongCOVID_ExitDate2 = min(DeathDate, TransferDate, CollectionDate, Date_O12W_LongCOVID_UOB, td(24/08/2021))
format LongCOVID_ExitDate2 %tdDD/NN/CCYY

gen PY = LongCOVID_ExitDate - IndexDate
sum PY, detail
keep if PY> 84
gen NewIndexDate = IndexDate + 84
format NewIndexDate %tdDD/NN/CCYY


rename COV_agecat P_agecat 
rename COV_sex P_sex
rename COV_Ethnicity P_Ethnicity 
gen P_IndexYear = year(IndexDate)
rename COV_BMIcat P_BMIcat
rename COV_SmokingStatus P_SmokingStatus
rename B12M_LongCOVID_WHO P_B12M_LongCOVID_WHO

gen P_Townsend = 1 if COV_Townsend <= 4
replace P_Townsend = 2 if COV_Townsend <= 8 & COV_Townsend > 4
replace P_Townsend = 3 if COV_Townsend <= 12 & COV_Townsend > 8
replace P_Townsend = 4 if COV_Townsend <= 16 & COV_Townsend > 12
replace P_Townsend = 5 if COV_Townsend <= 20 & COV_Townsend > 16
replace P_Townsend = 6 if COV_Townsend == 21

recode P_Townsend (1=1 "1 (least deprived)") (2=2 "2") (3=3 "3") (4=4 "4") (5=5 "5 (most deprived)") (6=6 "Missing"), gen(P_IMD)
drop P_Townsend

ds Cov_*
foreach var in `r(varlist)' {
local newname = substr("`var'", 5, .)
rename `var' P_`newname'
}
keep practice_patient_id practice_id CollectionDate TransferDate DeathDate P_*  LongCOVID_ExitDate LongCOVID_ExitDate2 NewIndexDate O12W_LongCOVID_WHO O12W_LongCOVID_UOB Date_O12W_LongCOVID_WHO Date_O12W_LongCOVID_UOB 
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/PredictionModel_Cohort.dta", replace 
}

//Risk factor model among patients with COVID-19
{
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/PredictionModel_Cohort.dta", clear 
gen PY = ( LongCOVID_ExitDate - NewIndexDate ) 
bysort P_VaccinationStatus : sum PY if PY > 0 , detail

log using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Results/V2/FullyAdjustmentRiskFactorModel.smcl", replace
//Selecting the candidate predictor variables and considering all categories within a variable to be considered together as a single entity
local x = ""
local IndependentVariables = ""
local i = 0
ds P_*
foreach var in `r(varlist)' {
di "`var'"
di "`i'"
	if `i' > 0 & ///
	("`var'" == "P_Townsend" | "`var'" == "P_Ethnicity" | "`var'" == "P_SmokingStatus" | "`var'" == "P_VaccinationStatus") {
	local IndependentVariables = "`IndependentVariables' " + "(i." + "`var'" + ")"
	}
	
	if `i' > 0 & ///
	("`var'" == "P_BMIcat" ) {
	local IndependentVariables = "`IndependentVariables' " + "(ib2." + "`var'" + ")"
	}
	
	if `i' > 0 & ///
	("`var'" != "P_Townsend" & "`var'" != "P_Ethnicity" & "`var'" != "P_BMIcat" & "`var'" != "P_SmokingStatus" & "`var'" != "P_VaccinationStatus" ) {
	local IndependentVariables = "`IndependentVariables' " + "i." + "`var'"
	}
	
	if `i' == 0 {
	local IndependentVariables = "i." + "`var'"
	}
	
local i = `i' + 1
}
di "stcox `IndependentVariables'"
//Fully adjusted model for WHO definition of Long COVID
stset LongCOVID_ExitDate, enter(NewIndexDate) failure(O12W_LongCOVID_WHO==1) origin(NewIndexDate)
stcox P_VaccinationStatus if NewIndexDate > td(01/12/2020), hr 
stcox `IndependentVariables' , hr 

//Fully adjusted model for UOB definition of Long COVID
stset LongCOVID_ExitDate2, enter(NewIndexDate) failure(O12W_LongCOVID_UOB==1) origin(NewIndexDate)
stcox `IndependentVariables' , hr 
log close
}

//Cluster Analysis - consolidation of symptoms to create indicator categorical variables
{
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/BaseCohort_Patients.dta" , clear
keep practice_patient_id exposed transfer_date collection_date death_date  index_date
keep if exposed == 1

gen TransferDate = date(transfer_date, "YMD")
gen DeathDate = date(death_date, "YMD")
gen CollectionDate = date(collection_date, "YMD")
gen IndexDate = date(index_date, "YMD")
format TransferDate DeathDate CollectionDate IndexDate %tdDD/NN/CCYY
keep if (min(CollectionDate, DeathDate, TransferDate) - IndexDate) > 84
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Cluster Analysis/TwoByTwo/Symptoms2_Processed_V3.dta" , force
keep if _merge == 3

gen I1_SOB = 0 
replace I1_SOB = 1 if O12W_shortnessofbreath == 1 | O12W_sobar == 1 | O12W_soboe == 1 | O12W_tachypnoea == 1
gen I2_Wheezing = O12W_wheezing
gen I3_ChestPain = 0 
replace I3_ChestPain = 1 if O12W_chestpain == 1 | O12W_pleuritic_cp == 1
gen I4_LimbSwelling = O12W_limbswelling
gen I5_Palpitations = 0 
replace I5_Palpitations = 1 if O12W_palipitations == 1 | O12W_tachycardia == 1 
gen I6_PresyncopeDizzy = 0 
replace I6_PresyncopeDizzy = 1 if O12W_presyncope == 1 | O12W_dizziness == 1
gen I7_Fatigue = 0 
replace I7_Fatigue = 1 if O12W_fatigue == 1 | O12W_postexert_fatigue  == 1 |O12W_neurasthenia  == 1 |O12W_asthenia == 1 
gen I8_CognitiveProblems = 0 
replace I8_CognitiveProblems = 1 if O12W_amnesia == 1 | O12W_diff_understanding == 1 | O12W_difficulty_thinking == 1 | O12W_readingdifficulty == 1 
gen I9_insomnia = O12W_insomnia 
gen I10_anosmia = O12W_anosmia 
gen I11_cough = O12W_cough
gen I12_dysphagia = O12W_dysphagia 
gen I13_EarPain = O12W_earpain 
gen I14_HoarseVoice = O12W_hoarse
gen I15_NasalCongestion_Sneeze = 0 
replace I15_NasalCongestion_Sneeze = 1 if O12W_nasalcongest == 1 | O12W_sneezing
gen I16_Phlegm = O12W_mucus
gen I17_AbdominalPain = O12W_abdominalpain 
gen I18_Bloating = O12W_bloating 
gen I19_BowelIncontinence = O12W_bowel_incontinence 
gen I20_Constipation = O12W_constipation 
gen I21_Diarrhoea = O12W_diarrhoea
gen I22_GastricReflux = 0 
replace I22_GastricReflux = 1 if O12W_gastricreflux == 1 | O12W_gastritis == 1 
gen I23_NauseaVomitting = 0 
replace I23_NauseaVomitting = 1 if O12W_nausea == 1 | O12W_vomiting == 1 
gen I24_WeightLoss = O12W_weight_loss 
gen I25_JointPain = O12W_jointpain
gen I26_Parasthenia = O12W_paresthesia
gen I27_AnxietyDepression = 0 
replace I27_AnxietyDepression = 1 if O12W_anxietyanddepression == 1 | O12W_anxietysym == 1 |O12W_anhedonia == 1 | O12W_depressionsym == 1
gen I28_Anorexia = O12W_anorexia
gen I29_DryScalySkin = O12W_dryandscalyskin
gen I30_HairLoss = O12W_hairloss
gen I31_HivesItchySkin = 0 
replace I31_HivesItchySkin = 1 if O12W_hiveurticariasymp == 1| O12W_itchyskin
gen I32_NailChanges = O12W_nailchanges 
gen I33_PurpuraRash = 0 
replace I33_PurpuraRash = 1 if O12W_purpura == 1 | O12W_rash
gen I34_DryEye = O12W_dryeyes 
gen I35_RedWateryEye = 0 
replace I35_RedWateryEye = 1 if O12W_redeye == 1 | O12W_watery_eyes
gen I36_SexualDysfunction = 0 
replace I36_SexualDysfunction = 1 if O12W_ejaculationdiff == 1 | O12W_erectiledysfunction == 1 | O12W_anorgasm == 1 | O12W_reducedlibido == 1 
gen I37_Menorrhagia = O12W_menorrhagia 
gen I38_VaginalDischarge = O12W_vaginaldischarge
gen I39_AllergiesAngioedema = 0 
replace I39_AllergiesAngioedema = 1 if O12W_allergies == 1 | O12W_angioedemasymp
gen I40_Bodyache = O12W_bodyache
gen I41_FeverChills = 0 
replace I41_FeverChills = 1 if O12W_chills_shivering == 1 | O12W_fever
gen I42_DryMouth = O12W_drymouth 
gen I43_Haemoptysis = O12W_haemoptysis 
gen I44_HEadache = O12W_headache 
gen I45_HotFlushes = O12W_hotflushes 
gen I46_MouthUlcer = O12W_mouthulcer 
gen I47_PolyUria = O12W_polyuria 
gen I48_UrinaryIncontinence = O12W_urinaryincontinence 
gen I49_UrinaryRetension = O12W_urinaryretention 
gen I50_Vertigo = O12W_vertigo

keep practice_patient_id I* O12W_LongCOVID_UOB
drop IndexDate
gen SymptomCount = 0 
ds I*
foreach var in `r(varlist)' {
replace SymptomCount = SymptomCount + `var'
}
ds I* 
local Conditions `r(varlist)'
foreach var in `Conditions' {
replace `var' = `var' + 1
}
//
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/Release64-1.3.2/ClusteringData.dta" , replace
tab O12W_LongCOVID_UOB
keep if O12W_LongCOVID_UOB == 1
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/Release64-1.3.2/ClusteringData_LongCOVIDPatients.dta" , replace

use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/Release64-1.3.2/ClusteringData_LongCOVIDPatients.dta" , clear 
ds I*

foreach var in `r(varlist)' {
quietly count if `var' == 2
local num = `r(N)'
quietly count if 1==1 
local den = `r(N)'
local Per = ( `num' / `den' ) * 100
di _column(1) "`var'" _column(35) %6.2f `Per' 
}
//poLCA plugin was run on R
}

// Running a multinomial logistic regression model on the polytomous class outcome 
{
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/BaseCohort_Patients.dta" , clear
sort practice_patient_id
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/Release64-1.3.2/DataWithPosteriorProbabilityForClass.dta" , sorted
keep if exposed == 1
keep if (min(CollectionDate, DeathDate, TransferDate) - IndexDate) > 84

gen Class1_Con = 1 if Class1 == max(Class1,Class2,Class3) 
replace Class1_Con = . if Class1 == . & Class2 == . & Class3 == . 
gen Class2_Con = 1 if Class2 == max(Class1,Class2,Class3) 
replace Class2_Con = . if Class1 == . & Class2 == . & Class3 == . 
gen Class3_Con = 1 if Class3 == max(Class1,Class2,Class3) 
replace Class3_Con = . if Class1 == . & Class2 == . & Class3 == .

foreach var in Class1_Con Class2_Con Class3_Con  {
replace `var' = 0 if `var' == .
}

gen Class = 1 if Class1 == max(Class1,Class2,Class3) 
replace Class = 2 if Class2 == max(Class1,Class2,Class3) 
replace Class = 3 if Class3 == max(Class1,Class2,Class3) 

replace Class = 0 if Class1 == . & Class2 == . & Class3 == . 
tab Class if Class != 0

gen P_Townsend = 1 if COV_Townsend <= 4
replace P_Townsend = 2 if COV_Townsend <= 8 & COV_Townsend > 4
replace P_Townsend = 3 if COV_Townsend <= 12 & COV_Townsend > 8
replace P_Townsend = 4 if COV_Townsend <= 16 & COV_Townsend > 12
replace P_Townsend = 5 if COV_Townsend <= 20 & COV_Townsend > 16
replace P_Townsend = 6 if COV_Townsend == 21

recode P_Townsend (1=1 "1 (least deprived)") (2=2 "2") (3=3 "3") (4=4 "4") (5=5 "5 (most deprived)") (6=6 "Missing"), gen(P_IMD)
drop P_Townsend

save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/Classes.dta"  , replace 
mlogit Class i.P_IMD i.COV_sex i.COV_agecat i.COV_Ethnicity ib2.COV_BMIcat i.COV_SmokingStatus
mlogit,rrr
}

//Obtaining the baseline characteristics for patients in each of the classes
{
set more off
**** Loading data
use   "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/Classes.dta" ,  clear 
keep COV* P_IMD Class
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/CurrentData", replace //create new file
tab Class
**** Gathering the data
//columns		
local Class0 Class==0
local Class1 Class==1
local Class2 Class==2
local Class3 Class==3


local columns Class0 Class1 Class2 Class3
local run = 0
foreach column in `columns' {
dis in r "`column'"
	use  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/CurrentData", clear
		keep if ``column''
		preserve //keeps data even after the dofile stops

	use  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/table1_lookup.dta", clear	
	levelsof table, local(tables) //shows the number of rows
	
	foreach x in `tables' {
		dis in r "`x'"
		local run = `run' + 1
		use  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/table1_lookup.dta", clear	//load the lookup table
			keep if table == `x' //focuses on 1 row at a time and moves down the variable list
			local crit = crit[1] 
			local ref = ref[1]  
			local type = type[1]   
		
		restore, pres
		
		if `type'==. {
			local txt = ""
		}
		
		if `type'==0 { // All
			count if `crit'	
			local txt = "(n=" + string(`r(N)',"%9.0fc") + ")"
			
		}
		
		if `type'==1 { // Categorical [n(%)]
			count if `ref' 
			local total = `r(N)'
			di `total'
			count if `crit' 
			local num = `r(N)'
			local percentage = (`num' / `total' ) * 100
	
			local txt = string(`num',"%9.0f") + " (" + string(`percentage', "%04.2fc") + ")"
			if `num'==0 local txt = "0 (0%)"
		}
		
		if `type'==3 { // Median (IQR)
			sum `crit', detail
			local txt = string(floor(`r(p50)'),"%04.2fc") + " (" + string(floor(`r(p25)'),"%04.2fc") + " ; " + string(floor(`r(p75)' ),"%04.2fc") + ")"
		}
		
		if `type'==2 { // Mean (SD)
			sum `crit' , detail
			local txt = string(`r(mean)',"%04.2fc")	+ " (" +  string(`r(sd)',"%04.2fc") + ")"		
		}
			
		clear
		set obs 1
		gen txt = "`txt'"
		gen table = `x'
		gen column = "`column'"
		if `run'!=1 append using  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/work_TempTable.dta"
		save  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/work_TempTable.dta", replace 
	}
restore		
}			
****************
		
** Finalising and creating the table
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/table1_lookup.dta", clear
save  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/work_tempinstruction.dta", replace
local columns Class0 Class1 Class2 Class3 Class4

foreach x in `columns'  {
	use  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/work_TempTable.dta", clear
		keep if column=="`x'"
	joinby table using  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/work_tempinstruction.dta", unm(using)
		drop _merge
		ren txt `x'
	save  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/work_tempinstruction.dta", replace	
}
//
local columns Class0 Class1 Class2 Class3

sort table
keep table tabletxt `columns'
order tabletxt `columns'	

export delimited using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/BaselineTable_LatentClasses.csv", replace

erase "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/work_TempTable.dta"
erase "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/work_tempinstruction.dta" 
erase "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/CurrentData.dta"

restore, not
}
//

//Summary of the number of symptoms COVID-19 patients present with after 12 weeks of infection 
{
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PS_Matched_Patients.dta" , clear
keep practice_patient_id exposed transfer_date collection_date death_date  index_date

gen TransferDate = date(transfer_date, "YMD")
gen DeathDate = date(death_date, "YMD")
gen CollectionDate = date(collection_date, "YMD")
gen IndexDate = date(index_date, "YMD")
format TransferDate DeathDate CollectionDate IndexDate %tdDD/NN/CCYY
keep if (min(CollectionDate, DeathDate, TransferDate) - IndexDate) > 84
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Cluster Analysis/TwoByTwo/Symptoms2_Processed_V2.dta" , force
keep if _merge == 3
drop OD_pots O12W_pots 
gen SymptomCount = 0 
ds O12W*
foreach var in `r(varlist)' {
replace SymptomCount = SymptomCount + `var'
}
bysort exposed: sum SymptomCount, detail
replace SymptomCount = 6 if SymptomCount >= 6
tab SymptomCount exposed, col
}
//

//Subgroup analysis for the first and second wave of the pandemic
{
use  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/BaseCohort_Patients.dta"  , clear
gen ExitDate = min(TransferDate, DeathDate, CollectionDate)
gen NewIndexDate = IndexDate + 84
format ExitDate NewIndexDate %tdDD/NN/CCYY
drop if NewIndexDate >= ExitDate
drop ExitDate NewIndexDate
gen FirstWave = 0 
replace FirstWave = 1 if IndexDate < td(31/08/2020)
tab FirstWave exposed, col
drop if FirstWave == 1
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/BaseCohort_Patients_FirstWave.dta" , replace
use  "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/BaseCohort_Patients.dta"  , clear
gen ExitDate = min(TransferDate, DeathDate, CollectionDate)
gen NewIndexDate = IndexDate + 84
format ExitDate NewIndexDate %tdDD/NN/CCYY
drop if NewIndexDate >= ExitDate
drop ExitDate NewIndexDate
gen FirstWave = 0 
replace FirstWave = 1 if IndexDate < td(31/08/2020)
tab FirstWave exposed, col
drop if FirstWave == 0
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/BaseCohort_Patients_SecondWave.dta" , replace


foreach wave in FirstWave SecondWave {
//PScore generation
{
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/BaseCohort_Patients_`wave'.dta" , clear 
sort practice_patient_id
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed.dta" , sorted
keep if _merge == 3 
drop B12M_anxiety B12M_depression B12M_eyepressure B12M_hospital_admission B12M_orthop_pnd B12M_raisediop B12M_blurredvision B12M_pots B12M_orthostatichypotens

//Check for missingness
ds Cov_* COV_* B12M*
foreach var in `r(varlist)' {
quietly count if `var' == .
if `r(N)' > 0 {
di "`var' missing"
}
}
//

tab exposed

ds Cov_* B12M*
local Varlist Cov_* B12M*
local Varlist Cov_*
_rmcoll `Varlist' , forcedrop 
tab Cov_PsoriaticArthritis
drop Cov_PsoriaticArthritis
***********************************************************

//ds Cov_* 
//local Varlist Cov_* 
ds Cov_* B12M*
local Varlist Cov_* B12M*
_rmcoll `Varlist' , forcedrop 
di r(varlist)
local NewVarlist `r(varlist)'
logit exposed COV_sex COV_age i.COV_Ethnicity i.COV_BMIcat i.COV_SmokingStatus COV_IndexTime i.COV_Townsend `NewVarlist' , or

sort practice_patient_id 
set seed 3000
psmatch2 exposed COV_sex COV_age i.COV_Ethnicity i.COV_BMIcat i.COV_SmokingStatus COV_IndexTime i.COV_Townsend `NewVarlist' , logit caliper(0.2) noreplace warnings 
gen PScore = _pscore
egen ID = group(practice_patient_id)
sort ID
drop _merge
//save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/PScore_Patients.dta" , replace
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PScore_Patients_`wave'.dta" , replace
}

//Ps matching using generated P scores
{
//use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/PScore_Patients.dta", clear
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PScore_Patients_`wave'.dta"  , clear
keep if _support == 1 
keep ID _n1 _id PScore exposed _weight
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/SmallCohort.dta" , replace
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/Subset.dta" , replace

forval i = 1/4 {
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/Subset.dta" , clear 
keep if _weight == 1 
gen case_control_group = .
sort PScore 
forval j = 1/30 {
replace case_control_group = ID[_n-`j'] if exposed == 0 & _id[_n] == _n1[_n-`j']
replace case_control_group = ID[_n+`j'] if exposed == 0 & _id[_n] == _n1[_n+`j']
}
//
keep if _weight == 1 & exposed == 0
gen ControlSet = `i'
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/ControlSet`i'.dta" , replace

use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/Subset.dta" , clear 
drop if _weight == 1 & exposed == 0
sort ID 
set seed 3000
psmatch2 exposed, pscore(PScore) caliper(0.2) noreplace warnings 
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/Subset.dta" , replace
}
//
use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/SmallCohort.dta"  , clear 
keep if _weight == 1 & exposed == 1
gen ControlSet = .
forval i = 1/4 {
append using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Matching/ControlSet`i'.dta"  
}
replace case_control_group = ID if exposed == 1 
keep ID case_control_group PScore ControlSet exposed
sort ID
//merge 1:1 ID using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/PScore_Patients.dta" , sorted
merge 1:1 ID using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PScore_Patients_`wave'.dta" , sorted
keep if _merge == 3 
//save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/PS_Matched_Patients.dta" , replace
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PS_Matched_Patients_`wave'.dta" , replace
keep practice_patient_id exposed PScore
save "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/x_`wave'.dta" , replace

use "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PScore_Patients_`wave'.dta"  , clear
keep practice_patient_id PScore exposed
merge 1:1 practice_patient_id using "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/x_`wave'.dta"
// compare _pscores before matching & save graph to disk
twoway (kdensity PScore if exposed==1) (kdensity PScore if exposed==0, ///
lpattern(dash)), legend( label( 1 "Patients with COVID-19") label( 2 "Control patients" ) ) ///
xtitle("propensity scores BEFORE matching") saving(before, replace)

// compare _pscores *after* matching & save graph to disk

twoway (kdensity PScore if exposed==1) (kdensity PScore if exposed==0 ///
& _merge == 3, lpattern(dash)), legend( label( 1 "Patients with COVID-19") label( 2 "Control patients" )) ///
xtitle("propensity scores AFTER matching") saving(after, replace)

// put both graphs on y axes with common scales
graph combine before.gph after.gph, ycommon
graph export "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Results/V2/KDensityPlot_`wave'.pdf", as(pdf) name("Graph") replace
}
//

//Generating outcomes table
{
log using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/Temp/Outcome_12W_`wave'.smcl" , replace
clear
set more off
**** Loading data
use   "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/New_PS_Matched_Patients_`wave'.dta" ,  clear 
sort practice_patient_id
keep practice_patient_id exposed case_control_group COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus IndexDate TransferDate DeathDate CollectionDate
sort practice_patient_id
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms2_Processed_V2.dta", force sorted
keep if _merge == 3
drop _merge
sort practice_patient_id
merge 1:1 practice_patient_id using "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/Symptoms4_Processed_V2.dta", force sorted
keep if _merge == 3
drop _merge
rename Date_O12W_LongCOVID_WHO OD_LongCOVID_WHO
keep practice_patient_id case_control_group exposed B* O* COV_age COV_sex COV_BMIcat COV_Ethnicity COV_Townsend COV_SmokingStatus IndexDate TransferDate DeathDate CollectionDate OD_LongCOVID_WHO

save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData1", replace //create new file
tab exposed

use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Temp/CurrentData1", clear
tab exposed 

ds O12W_*
local SymptomsList `r(varlist)'
foreach Symptom in `SymptomsList' {
local vartype: type `Symptom'
local newname = substr("`Symptom'" , 6, . )
di "`newname'"

foreach ExposurePeriod in O12W {
gen ExitDate = min(TransferDate, DeathDate, CollectionDate, OD_`newname')
gen NewIndexDate = IndexDate + 84
format ExitDate NewIndexDate %tdDD/NN/CCYY
replace `ExposurePeriod'_`newname' = 0 if OD_`newname' > ExitDate

count if exposed == 1 & `ExposurePeriod'_`newname' == 1 & NewIndexDate < ExitDate
local E_N = `r(N)'
count if exposed == 1 & NewIndexDate < ExitDate
local E_Per = string(((`E_N' / `r(N)') * 100), "%04.2fc")
global E_N_`ExposurePeriod'_`newname' = "`E_N'" + " (" + "`E_Per'" + "%)"

count if exposed == 0 & `ExposurePeriod'_`newname' == 1 & NewIndexDate < ExitDate
local U_N = `r(N)'
count if exposed == 0 & NewIndexDate < ExitDate
local U_Per = string(((`U_N' / `r(N)') * 100), "%04.2fc")
global U_N_`ExposurePeriod'_`newname' = "`U_N'" + " (" + "`U_Per'" + "%)"

stset ExitDate, failure(`ExposurePeriod'_`newname'==1) enter(NewIndexDate)
capture noisily eststo: stcox exposed COV_age i.COV_sex i.COV_BMIcat i.COV_Ethnicity i.COV_Townsend i.COV_SmokingStatus B12M_`newname'
di _rc 
if _rc != 430 {
estout , cells(b ci) eform
matrix A = r(coefs)
matrix list A, format(%12.0e)
estout , cells(p)
matrix B = r(coefs)
matrix list B, format(%9.3f)
local BA_pval = (B[1,1])
if `BA_pval' >= 0.001 {
local BA_txt1 = "p=" + string(`BA_pval',"%9.3f") 
}
if `BA_pval' < 0.001 {
local BA_txt1 = "p<0.001" 
}
local BA_HR = string(A[1,1],"%04.2fc")
local BA_lowerCI = string(A[1,2],"%04.2fc")
local BA_upperCI = string(A[1,3],"%04.2fc")
}
if _rc == 430 {
local BA_HR = ""
local BA_lowerCI = ""
local BA_upperCI = ""
}
global BA`ExposurePeriod'_`newname' = "`BA_HR'" + " (" + "`BA_lowerCI'" + "-" + "`BA_upperCI'" + "); " + "`BA_txt1'"
global BAHR`ExposurePeriod'_`newname' = "`BA_HR'" 
global BAPV`ExposurePeriod'_`newname' = "`BA_pval'" 
eststo clear
}
drop ExitDate NewIndexDate
}
//}
ds  O12W_*
local count : word count `r(varlist)'
di `count'
ds O12W_*
local SymptomsList `r(varlist)'

clear 
set obs `count'
gen Symptom = ""
gen O12W_Exp_N = ""
gen O12W_Unexp_N = ""
gen O12W_Base_Adj_HR = ""
gen O12W_Base_Adj_HRWithCI = ""
gen O12W_Base_Adj_PVal = ""


local i = 1
foreach Symptom in `SymptomsList' {
local newname = substr("`Symptom'" , 6, . )
di in r "`newname'" 
replace Symptom = "`newname'" if _n == `i'
di in r "`newname'" 

replace O12W_Exp_N = "${E_N_O12W_`newname'}" if _n == `i'
replace O12W_Unexp_N = "${U_N_O12W_`newname'}" if _n == `i'
replace O12W_Base_Adj_HR = "${BAHRO12W_`newname'}" if _n == `i'
replace O12W_Base_Adj_HRWithCI = "${BAO12W_`newname'}" if _n == `i'
replace O12W_Base_Adj_PVal = "${BAPVO12W_`newname'}" if _n == `i'

local i = `i' + 1
}
save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/Temp/Outcome_12W_`wave'.dta", replace
			
use "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/Temp/Outcome_12W_`wave'.dta" , clear
foreach var in O12W_Base_Adj_PVal {
gen XX`var' = real(`var')
drop `var'
rename XX`var' `var'
}
//

foreach var in O12W_Base_Adj_PVal {
local newname = substr("`var'" , 1 , strpos("`var'" , "PVal")-2)
di "`newname'"

multproc, puncor(0.05) pvalue(`var') method(simes) critical(`newname'_Crit_PVal_Corr) reject(`newname'_StatSign) float
	       	
di "`r(puncor)'      uncorrected critical p-value"
di "`r(pcor)'        corrected critical p-value"
di "`r(npvalues)'    number of p-values"
di "`r(nreject)'     number of p-values rejected"

}
//

local VarOrder Symptom
foreach var in O12W {
local VarOrder `VarOrder' `var'_Base_Adj_HR `var'_Base_Adj_HRWithCI `var'_Base_Adj_PVal `var'_Base_Adj_Crit_PVal_Corr `var'_Base_Adj_StatSign

}
//

local ORDER `VarOrder'
order `VarOrder'

rename *Exp_N* *Case_N*
rename *Unexp_N* *Control_N*

save "//rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/Temp/Outcome_12W_`wave'.dta", replace

log close
}
//
}
}
//



