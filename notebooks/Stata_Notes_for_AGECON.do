* Stata Notes for AGECON: Basics and Fundamentals
* Walter Ac-Pangan, Ph.D., October 2026
* Run the examples in order. Each section creates the data it needs.


* ============================================================
* 1 Introduction to Stata
* ============================================================

* ----------------------------------------
* 1.1 Getting Access
* ----------------------------------------

* ----------------------------------------
* 1.2 The Stata Interface
* ----------------------------------------

* ============================================================
* 2 The Basics
* ============================================================

* ----------------------------------------
* 2.1 Comments and Calculations
* ----------------------------------------
* A full-line comment starts with an asterisk
// This is also a comment
display 2 + 3        // a comment at the end of a line
/* A block comment
   can span several lines */

display 3 + 7        // addition
display 3 - 7        // subtraction
display 3 * 7        // multiplication
display 3 / 7        // division
display 3^2          // exponent
display sqrt(3)      // square root
display round(3/7, 0.001)
display floor(3/7)   // largest integer <= 3/7
display ceil(3/7)    // smallest integer >= 3/7
display abs(3 - 7)   // absolute value
display ln(3)        // natural log
display log10(3)     // log base 10
display floor(1250/400)   // full truckloads
display mod(1250, 400)    // bushels left over


* ----------------------------------------
* 2.2 Locals and Scalars
* ----------------------------------------
local price = 4.25
local yield = 180
display "Revenue per acre: " `price' * `yield'

scalar cost = 690
display "Profit per acre: " `price' * `yield' - cost

* Unit conversion: one bushel of corn = 56 lb, one lb = 0.45359237 kg
display "Metric tons: " %9.2f 10000 * 56 * 0.45359237 / 1000

* Revenue, cost, and profit for a 500-acre corn farm
local acres = 500
local yld = 180
local price = 4.25
local cost_acre = 690
local revenue = `acres' * `yld' * `price'
local total_cost = `acres' * `cost_acre'
display "Revenue: " %12.2fc `revenue'
display "Profit:  " %12.2fc `revenue' - `total_cost'
display "Margin (%): " %5.1f (`revenue' - `total_cost') / `revenue' * 100

* Break-even price
display "Break-even price (dollars per bu): " %6.2f `cost_acre' / `yld'

* Percent change in the soybean price
display "Percent change: " %6.1f (10.90 - 13.20) / 13.20 * 100

* Compound interest: FV = PV * (1 + r)^t
display "Future value: " %12.2fc 10000 * (1 + 0.04)^5


* ----------------------------------------
* 2.3 Missing Values
* ----------------------------------------
display 1 + . + 3     // missing
display missing(.)    // 1 = true


* ----------------------------------------
* 2.4 Logical Operators
* ----------------------------------------
display 3 == 7          // equal
display 3 != 7          // not equal (also ~=)
display 3 < 10
display (3 < 20) & (7 >= 50)   // and
display (3 < 20) | (7 >= 50)   // or
display inlist(3, 1, 2, 3, 4)  // is 3 in the list?
display cond(3 < 100, 3 + 7, .)   // if-else: returns 10


* ----------------------------------------
* 2.5 Data Types and Converting Text
* ----------------------------------------
clear
input str8 quantity_text
"1,250"
"800"
end

generate price_text = char(36) + "4.25"                         // a price stored as text: dollar sign + 4.25
generate price = real(subinstr(price_text, char(36), "", .))    // remove the dollar sign, convert
destring quantity_text, generate(quantity) ignore(",")          // remove commas, convert
generate revenue = price * quantity
format revenue %12.2fc
list
describe


* ----------------------------------------
* 2.6 Working with Dates
* ----------------------------------------
display td(05oct2024) - td(25apr2024)       // days from planting to harvest

* An 18-month operating loan that starts on March 1, 2024
display %td dofm(mofd(td(01mar2024)) + 18)  // maturity date

clear
input str10 date_text
"2024-04-25"
"2024-10-05"
end
generate date = date(date_text, "YMD")
format date %td
generate year = year(date)
generate month = month(date)
list


* ============================================================
* 3 Fundamentals
* ============================================================

* ----------------------------------------
* 3.1 Creating a Dataset
* ----------------------------------------
clear
input str10 crop acres yield price
"corn"     300 180  4.25
"soybeans" 200  55 10.90
"wheat"    100  50  5.60
end

list


* ----------------------------------------
* 3.2 Creating and Changing Variables
* ----------------------------------------
generate revenue = acres * yield * price
generate revenue_acre = yield * price
label variable revenue "Total revenue (dollars)"
format revenue %12.2fc
list crop revenue revenue_acre
total revenue


* ----------------------------------------
* 3.3 Conditions with if
* ----------------------------------------
clear
input str1 farm acres market_price bushels
"A"  120 3.45  20000
"B"  850 3.90  95000
"C" 2400 3.55 410000
"D"  430 3.75  60000
end

generate str6 size = "small"
replace size = "medium" if acres >= 500 & acres < 2000
replace size = "large"  if acres >= 2000

local support = 3.70     // hypothetical support price, dollars per bu
generate payment = cond(market_price < `support', (`support' - market_price) * bushels, 0)
format payment %12.2fc
list


* ----------------------------------------
* 3.4 Loops
* ----------------------------------------
* Investment growth year by year
local balance = 10000
forvalues year = 1/5 {
    local balance = `balance' * 1.05
    display "Year `year': " %12.2fc `balance'
}

* Years to double an investment at 6%
local balance = 1000
local years = 0
while `balance' < 2000 {
    local balance = `balance' * 1.06
    local years = `years' + 1
}
display "Years to double: `years'"

* Paying off a 20,000-dollar loan with 5,000-dollar payments at 7% interest
local debt = 20000
local year = 0
while `debt' > 0 {
    local year = `year' + 1
    local debt = `debt' * 1.07 - 5000
    display "Year `year': remaining debt " %12.2fc max(`debt', 0)
}

* foreach: future value of 10,000 dollars after 10 years at several interest rates
foreach r in 0.04 0.06 0.08 {
    display "Rate `r': " %12.2fc 10000 * (1 + `r')^10
}


* ----------------------------------------
* 3.5 Writing Your Own Commands
* ----------------------------------------
capture program drop loan_payment
program define loan_payment
    args principal rate years
    display "Annual payment: " %12.2fc `principal' * `rate' / (1 - (1 + `rate')^(-`years'))
end

loan_payment 150000 0.065 7
loan_payment 80000 0.07 5

capture program drop npv_bin
program define npv_bin
    args rate
    local npv = -50000
    forvalues t = 1/8 {
        local npv = `npv' + 9000 / (1 + `rate')^`t'
    }
    display "NPV at `rate': " %12.2fc `npv'
end

npv_bin 0.06
npv_bin 0.10


* ----------------------------------------
* 3.6 Error Handling
* ----------------------------------------
capture confirm variable price
if _rc != 0 {
    display "Variable 'price' does not exist in this dataset."
}
else {
    display "Variable 'price' found."
}


* ============================================================
* 4 Working with Datasets
* ============================================================

* ----------------------------------------
* 4.1 Importing Data
* ----------------------------------------
* Example: edit the folder/file below, then remove the comment markers to run it.
* cd "C:/Users/Walter/Documents/AGECON"     // change to your own folder
* import delimited "demographics.csv", clear

clear
set obs 10
set seed 2024
generate hhnum          = 1000 + _n
generate region         = runiformint(1, 4)
generate rural          = runiform() < 0.5
generate household_size = runiformint(1, 6)
generate income         = round(rnormal(65000, 20000))
generate rent_mortgage  = round(rnormal(1200, 300))
label variable income "Average household income (dollars)"
label variable rent_mortgage "Monthly rent or mortgage (dollars)"


* ----------------------------------------
* 4.2 Exploring Data
* ----------------------------------------
describe              // variables and types
list in 1/5           // first 5 rows
summarize income household_size rent_mortgage
tabulate region
codebook rural


* ----------------------------------------
* 4.3 Filter, Sort, and Group
* ----------------------------------------
* Filter: count households with income above 60,000 dollars
count if income > 60000

* Sort: largest rent or mortgage first
gsort -rent_mortgage
list hhnum rent_mortgage in 1/3

* Group: summary statistics by region
tabstat income household_size, by(region) statistics(n mean) format(%9.1f)

* Add the group average as a new variable
bysort region: egen avg_income_region = mean(income)

* Collapse the data to one row per region (use preserve/restore to keep the original)
preserve
collapse (count) households=hhnum (mean) avg_income=income avg_size=household_size, by(region)
list
restore


* ----------------------------------------
* 4.4 Merging Datasets
* ----------------------------------------
preserve
clear
input region str10 region_name
1 "Northeast"
2 "Midwest"
3 "South"
4 "West"
end
tempfile regions
save `regions'
restore

merge m:1 region using `regions'
tabulate _merge


* ----------------------------------------
* 4.5 Saving and Exporting
* ----------------------------------------
save "household.dta", replace                      // Stata format
export delimited using "household.csv", replace    // CSV file
export excel using "household.xlsx", firstrow(variables) replace


* ============================================================
* 5 Data Visualization
* ============================================================

* ----------------------------------------
* 5.1 Histogram and Boxplot
* ----------------------------------------
clear
set obs 1000
set seed 2025
generate harvest_price = rnormal(4.30, 0.45)    // simulated price, dollars per bu

histogram harvest_price, normal title("Distribution of simulated harvest prices")
graph box harvest_price, title("Boxplot of harvest prices")

* Price risk: percentiles and the chance of a low price
centile harvest_price, centile(5 95)
count if harvest_price < 3.80
display "Probability price < 3.80: " r(N) / _N


* ----------------------------------------
* 5.2 Bar Chart
* ----------------------------------------
clear
input str10 crop revenue_acre
"Corn"     765
"Soybeans" 599.5
"Wheat"    280
"Sorghum"  384.75
end

graph bar revenue_acre, over(crop) ytitle("Revenue (dollars per acre)") title("Revenue per acre by crop")


* ----------------------------------------
* 5.3 Supply and Demand
* ----------------------------------------
twoway (function y = (100 - x)/8, range(20 100) lwidth(thick)) ///
       (function y = (x - 20)/12, range(20 110) lwidth(thick)) ///
       (scatteri 4 68, msymbol(circle) mcolor(black)), ///
       xtitle("Quantity") ytitle("Price") ///
       legend(order(1 "Demand" 2 "Supply")) ///
       title("Market equilibrium")

graph export "market_equilibrium.png", replace width(1600)


* ============================================================
* 6 Regression
* ============================================================
clear
set obs 200
set seed 42
generate fertilizer = runiform(50, 200)    // lbs of nitrogen per acre
generate rainfall   = runiform(15, 40)     // inches during the season
generate irrigated  = runiform() < 0.5
generate yield_bu   = 60 + 0.35*fertilizer + 1.5*rainfall + 20*irrigated + rnormal(0, 15)
generate high_yield = yield_bu > 160
summarize


* ----------------------------------------
* 6.1 Linear and Multiple Regression
* ----------------------------------------
regress yield_bu fertilizer                             // simple regression
regress yield_bu fertilizer rainfall irrigated          // multiple regression
regress yield_bu fertilizer rainfall irrigated, robust  // robust standard errors


* ----------------------------------------
* 6.2 Probit Model
* ----------------------------------------
probit high_yield fertilizer rainfall irrigated
margins, dydx(*)       // average marginal effects


* ----------------------------------------
* 6.3 Side-by-Side Regression Tables
* ----------------------------------------
capture which esttab
if _rc != 0 ssc install estout, replace   // installs estout once (needs internet)

eststo clear
eststo m1: regress yield_bu fertilizer
eststo m2: regress yield_bu fertilizer rainfall irrigated
eststo m3: probit high_yield fertilizer rainfall irrigated
esttab m1 m2 m3, se star(* 0.10 ** 0.05 *** 0.01) mtitles("OLS (1)" "OLS (2)" "Probit")
esttab m1 m2 m3 using "regression_table.rtf", se replace   // opens in Word


* ----------------------------------------
* 6.4 Regression with Matrix Algebra
* ----------------------------------------
mata:
    X = st_data(., ("fertilizer", "rainfall", "irrigated"))
    X = J(rows(X), 1, 1), X            // add an intercept column
    y = st_data(., "yield_bu")
    beta = invsym(X'X) * X'y
    beta'
end
