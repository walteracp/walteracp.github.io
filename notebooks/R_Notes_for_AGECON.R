# R Notes for AGECON: Basics and Fundamentals
# Walter Ac-Pangan, Ph.D., August 2024
# Run the examples in order. Keep demographics.csv in your working directory.


# ============================================================
# 1 Introduction to R studio
# ============================================================

# ----------------------------------------
# 1.1 Installation
# ----------------------------------------

# ----------------------------------------
# 1.2 RStudio Interface
# ----------------------------------------

# ============================================================
# 2 The Basics
# ============================================================

# ----------------------------------------
# 2.1 Executing Code & Variable Creation
# ----------------------------------------
w <-10 # assign the value 10 to the variable "w"
20 -> x # assign the value 20 to the variable "x"
y = 30

x; y # Print "x" and "y".


# ----------------------------------------
# 2.2 R is Case Sensitivity
# ----------------------------------------
x<-5 # Re-assign a new value to variable "x".
a<-10
A<-20
x; a; A # Print "x", "a", and "A".


# ----------------------------------------
# 2.3 Missing Values
# ----------------------------------------
x <- NA
x

x+1
sum(1,x,3)

sum(1,x,3,na.rm=TRUE)


# ----------------------------------------
# 2.4 Calculator and Math Functions
# ----------------------------------------
x<-3 # Re-assign a new value to variable "x".
y<-7
x; y

x+y # addition
x-y # subtraction

x*y # multiplication
x/y # division
x*y*1-y
x*y*(1-y) # use parentheses to control order of operations

x^2 # exponent
sqrt(x) # square root

round(x/y,3) # rounds x/y to 3 decimal places

floor(x/y) # returns the smallest integer less than or equal to x/y
ceiling(x/y) # returns the largest integer greater than or equal to x/y

abs(x-y) # absolute value
log(x) # log base e, natural log
log(x,10) # log base 10

x==y # is "x" equal to "y"?
x!=y # is "x" not equal to "y"?
x<10 # is "x" less than 10?
x<=2 # is "x" less than or equal to 2?
x<20 & y>=50 # is "x" less than 20 AND "y" greater than or equal to 50?
x<20 | y>=50 # is "x" less than 20 OR "y" greater than or equal to 50?
z<-c(1,2,3,4) # creates a string of numeric values (concatenates)
z
x%in%z # is "x" contained in "z"?
!(x%in%z) # is "x" not contained in "z"?
5%in%z # is 5 contained in "z"?

ifelse(x==100,x+y,NA) # returns x+y if x=100, otherwise returns missing
ifelse(x<100,x+y,NA) # returns x+y if x<100, otherwise returns missing

total_bushels <- 1250   # bushels harvested
truck_capacity <- 400   # bushels per truck

total_bushels %/% truck_capacity  # full truckloads: 3
total_bushels %% truck_capacity   # bushels left over: 50

bushels <- 10000
kg_per_bushel <- 56 * 0.45359237           # 25.4 kg per bushel of corn
metric_tons <- bushels * kg_per_bushel / 1000
round(metric_tons, 2)                      # metric tons

acres <- 500
yield_bu_acre <- 180     # bushels per acre
price <- 4.25            # dollars per bushel
cost_per_acre <- 690     # dollars per acre

revenue <- acres * yield_bu_acre * price
total_cost <- acres * cost_per_acre
profit <- revenue - total_cost
margin <- profit / revenue * 100

revenue; total_cost; profit
round(margin, 1)   # profit margin (%)

break_even_price <- cost_per_acre / yield_bu_acre
round(break_even_price, 2)   # dollars per bushel

price_2023 <- 13.20
price_2024 <- 10.90
pct_change <- (price_2024 - price_2023) / price_2023 * 100
round(pct_change, 1)   # percent

PV <- 10000   # present value
r <- 0.04     # annual interest rate
t <- 5        # years
FV <- PV * (1 + r)^t
round(FV, 2)


# ----------------------------------------
# 2.5 Understading Variables in R
# ----------------------------------------
a<-3
# since "a" is a numeric variable, the output
# in the Console will not have quotation marks
a
class(a) # returns the class (data type) of a variable or object

b<-as.integer(5) # converts 5 to an integer
b
class(b) # returns the class of "b"

b2<-as.integer(5.6) # converts 5.6 to an integer
b2 # notice 5.6 is rounded down to the nearest integer
class(b2)

b3<- "6.7" # converts 5.6 to an integer
b3 # notice 5.6 is rounded down to the nearest integer
class(b3)

c<-"WillieTheWildcat"
# since "c" is a character variable, the output in
# the Console will have quotation marks
c
class(c)
d<-as.character(3)
# we have defined "3" to be a character, you cannot
# perform mathematical operations on it now
d
class(d)
d+1

l_t <- TRUE
l_f <- FALSE

class(l_t)

US_state <-as.factor(c("Kansas","Iowa","Nebraska","Texas"))
US_state
class(US_state)

date_var <- as.Date("2024-08-12")
time_var <- as.POSIXct("2024-08-12 12:34:56")

class(date_var)
class(time_var)

price_text <- "$4.25"
price <- as.numeric(gsub("$", "", price_text, fixed = TRUE))  # remove "$", then convert
price * 2

quantity_text <- "1,250"
quantity <- as.numeric(gsub(",", "", quantity_text, fixed = TRUE))  # remove the comma
quantity + 1

revenue <- 382500
rate <- 0.0475

paste0("Revenue: $", formatC(revenue, format = "f", digits = 2, big.mark = ","))
sprintf("Interest rate: %.2f%%", rate * 100)
sprintf("Revenue in millions: %.2f M", revenue / 1e6)

planting <- as.Date("2024-04-25")
harvest <- as.Date("2024-10-05")
as.numeric(harvest - planting)   # days from planting to harvest

loan_start <- as.Date("2024-03-01")
maturity <- seq(loan_start, by = "18 months", length.out = 2)[2]  # an 18-month operating loan
maturity

months <- seq(as.Date("2024-01-01"), by = "month", length.out = 6)  # first day of each month
format(months, "%b %Y")


# ----------------------------------------
# 2.6 Delete, Remove Objects from R Environment
# ----------------------------------------
rm(list = ls()) # Remove all objects from the R environment

# Example: Let's assign the object x = 5.
x <-5
print(x) # Print the object x.
x

#Explain what is going on in the following lines
"My name is Willie" -> X # Assign the string "My name is Willie" to the object X.
X <- "My name is Willie"
"My name is Willie" = X
X = "My name is Willie"
# As you can see the arrow and the equal sign are interchangeable.

print(X) # Print the object X.

# Removing object 'x' from the environment.
rm('x')
remove(x)

# Print the object x again.
#print(x) # Error: object 'x' not found


# ----------------------------------------
# 2.7 Install Packages
# ----------------------------------------
rm(list = ls()) # Remove all objects from the R environment

#install.packages("dplyr") # Essential shortcuts for subsetting, summarizing, rearranging, and joining together data sets.
#install.packages("tidyverse") # A collection of R packages designed for data science.
#install.packages("ggplot2") # Create elegant data visualizations using the Grammar of Graphics approach.
#install.packages("readr") # Read flat files (e.g., CSV, TSV, FWF) into R.
#install.packages("readxl") # Read Excel files into R.
#install.packages("stringr") # Work with strings in R.
#install.packages("lubridate") # Work with dates and times in R.
#install.packages("tidyverse") # A collection of R packages designed for data science.

#Load packages
library(dplyr)
library(tidyverse)
library(ggplot2)
library(readr)
library(readxl)
library(stringr)
library(lubridate)
library(tidyverse)

dplyr::n_distinct(c("corn", "corn", "wheat"))  # number of distinct values


# ============================================================
# 3 Fundamentals
# ============================================================

# ----------------------------------------
# 3.1 Data Structures: Vectors, Named Vectors, Lists, and Sets
# ----------------------------------------
corn_prices <- c(4.25, 4.10, 4.40, 4.55)  # weekly prices, $/bu
corn_prices <- c(corn_prices, 4.60)       # add a new week
corn_prices
length(corn_prices)
round(mean(corn_prices), 3)

prices <- c(corn = 4.25, soybeans = 10.90, wheat = 5.60)  # $/bu
prices["soybeans"]     # look up a value by its name

prices["sorghum"] <- 4.05   # add a new commodity
prices["corn"] <- 4.30      # update an existing one
prices
names(prices)

farm <- list(name = "Prairie View",
             acres = 500,
             crops = c("corn", "soybeans"),
             location = c(lat = 39.19, lon = -96.58))
farm$name
farm$crops
farm$location["lat"]
str(farm)   # compact overview of the list

exporter_a <- c("Mexico", "Japan", "China", "Colombia")
exporter_b <- c("Japan", "China", "Egypt", "Mexico", "Japan")  # "Japan" twice

unique(exporter_b)                # remove duplicates
intersect(exporter_a, exporter_b) # markets both export to
union(exporter_a, exporter_b)     # all markets
setdiff(exporter_a, exporter_b)   # markets only exporter A serves


# ----------------------------------------
# 3.2 If Statements
# ----------------------------------------
profit <- -12500

if (profit > 0) {
  print("The farm made a profit.")
} else if (profit == 0) {
  print("The farm broke even.")
} else {
  print(paste("The farm had a loss of", abs(profit), "dollars."))
}

support_price <- 3.70   # hypothetical support price, $/bu
market_price <- 3.45
bushels <- 50000

if (market_price < support_price) {
  payment <- (support_price - market_price) * bushels
  paste0("Payment: $", formatC(payment, format = "f", digits = 2, big.mark = ","))
} else {
  "No payment: the market price is above the support price."
}

debt_to_asset <- 0.35
current_ratio <- 1.8   # current assets / current liabilities

if (debt_to_asset < 0.40 && current_ratio > 1.5) {
  "Loan approved"
} else {
  "Loan needs further review"
}


# ----------------------------------------
# 3.3 For Loops
# ----------------------------------------
crops <- data.frame(crop  = c("corn", "soybeans", "wheat"),
                    acres = c(300, 200, 100),
                    yield = c(180, 55, 50),       # bu/acre
                    price = c(4.25, 10.90, 5.60)) # $/bu

total <- 0
for (i in 1:nrow(crops)) {
  revenue <- crops$acres[i] * crops$yield[i] * crops$price[i]
  total <- total + revenue
  cat(sprintf("%-9s revenue: $%s\n", crops$crop[i], formatC(revenue, format = "f", digits = 2, big.mark = ",")))
}
cat(sprintf("%-9s revenue: $%s\n", "Total", formatC(total, format = "f", digits = 2, big.mark = ",")))

crops$revenue <- crops$acres * crops$yield * crops$price
crops
sum(crops$revenue)

balance <- 10000
rate <- 0.05
for (year in 1:5) {
  balance <- balance * (1 + rate)
  cat(sprintf("Year %d: $%s\n", year, formatC(balance, format = "f", digits = 2, big.mark = ",")))
}


# ----------------------------------------
# 3.4 While Loops
# ----------------------------------------
balance <- 1000
years <- 0
while (balance < 2000) {
  balance <- balance * 1.06
  years <- years + 1
}
years                 # years to double
round(balance, 2)     # final balance

debt <- 20000
payment <- 5000
rate <- 0.07
year <- 0
while (debt > 0) {
  year <- year + 1
  debt <- debt * (1 + rate) - payment   # interest is added, then the payment is made
  cat(sprintf("Year %d: remaining debt $%s\n", year, formatC(max(debt, 0), format = "f", digits = 2, big.mark = ",")))
}


# ----------------------------------------
# 3.5 Apply Functions
# ----------------------------------------
nominal <- c(3.50, 3.70, 4.10, 5.90, 6.50)   # $/bu
cpi <- c(100, 102, 105, 110, 118)            # price index (base year = 100)

real <- round(nominal / cpi * 100, 2)        # vectorized: no loop needed
real

rates <- c(0.04, 0.06, 0.08)
sapply(rates, function(r) round(10000 * (1 + r)^10, 2))

profit_per_acre <- c(corn = 75, soybeans = 120, wheat = -20, sorghum = 10)
names(profit_per_acre)[profit_per_acre > 0]


# ----------------------------------------
# 3.6 Functions
# ----------------------------------------
npv <- function(rate, cash_flows) {
  # cash_flows[1] happens today (year 0)
  years <- seq_along(cash_flows) - 1
  sum(cash_flows / (1 + rate)^years)
}

# Buy a $50,000 grain bin that saves $9,000 per year for 8 years
flows <- c(-50000, rep(9000, 8))
round(npv(0.06, flows), 2)   # NPV at 6%
round(npv(0.10, flows), 2)   # NPV at 10%

elasticity <- function(q1, q2, p1, p2, method = "midpoint") {
  if (method == "midpoint") {
    pct_q <- (q2 - q1) / ((q1 + q2) / 2)
    pct_p <- (p2 - p1) / ((p1 + p2) / 2)
  } else {
    pct_q <- (q2 - q1) / q1
    pct_p <- (p2 - p1) / p1
  }
  pct_q / pct_p
}

e <- elasticity(q1 = 100, q2 = 70, p1 = 2.00, p2 = 2.50)
round(e, 2)

if (abs(e) > 1) {
  "Demand is elastic: quantity responds more than price."
} else if (abs(e) < 1) {
  "Demand is inelastic: quantity responds less than price."
} else {
  "Demand is unit elastic."
}

loan_payment <- function(principal, rate, years) {
  principal * rate / (1 - (1 + rate)^(-years))
}
round(loan_payment(150000, 0.065, 7), 2)   # tractor loan, dollars per year


# ----------------------------------------
# 3.7 Anonymous Functions
# ----------------------------------------
farms_df <- data.frame(farm = c("A", "B", "C", "D"), acres = c(120, 850, 2400, 430))
farms_df$size <- sapply(farms_df$acres, function(a) {
  if (a < 500) "small" else if (a < 2000) "medium" else "large"
})
farms_df

revenue_per_acre <- c(corn = 180 * 4.25, soybeans = 55 * 10.90, wheat = 50 * 5.60)
sort(revenue_per_acre, decreasing = TRUE)


# ----------------------------------------
# 3.8 Error Handling
# ----------------------------------------
5000 / 0   # R returns Inf, not an error

average_cost <- function(total_cost, quantity) {
  if (quantity == 0) stop("Quantity is zero: average cost is undefined.")
  total_cost / quantity
}

average_cost(5000, 250)

result <- tryCatch(
  average_cost(5000, 0),
  error = function(e) {
    message("Caught an error: ", conditionMessage(e))
    NA   # return a missing value instead of stopping
  }
)
result

raw_prices <- c("4.25", "4.10", "n/a", "4.40", "")
clean <- suppressWarnings(as.numeric(raw_prices))
clean
round(mean(clean, na.rm = TRUE), 3)   # average of valid prices


# ----------------------------------------
# 3.9 User Inputs
# ----------------------------------------
# Example: edit the folder/file below, then remove the comment markers to run it.
# price <- as.numeric(readline("Expected price ($/bu): "))
# yld <- as.numeric(readline("Expected yield (bu/acre): "))
# cost <- as.numeric(readline("Cost per acre ($): "))

# profit <- price * yld - cost
# cat(sprintf("Expected profit: $%.2f per acre\n", profit))


# ----------------------------------------
# 3.10 Objects and Classes
# ----------------------------------------
# Constructor: creates a "farm" object
new_farm <- function(name, acres, yield_bu, price, cost_per_acre) {
  structure(list(name = name, acres = acres, yield_bu = yield_bu,
                 price = price, cost_per_acre = cost_per_acre),
            class = "farm")
}

# A generic function and its method for the "farm" class
farm_profit <- function(x) UseMethod("farm_profit")
farm_profit.farm <- function(x) x$acres * (x$yield_bu * x$price - x$cost_per_acre)

# A print method: controls how a farm is displayed
print.farm <- function(x, ...) {
  cat(sprintf("%s: profit %s dollars, break-even price $%.2f per bu\n",
              x$name, formatC(farm_profit(x), format = "f", digits = 0, big.mark = ","),
              x$cost_per_acre / x$yield_bu))
  invisible(x)
}

farm1 <- new_farm("Prairie View", acres = 500, yield_bu = 180, price = 4.25, cost_per_acre = 690)
farm2 <- new_farm("Blue River", acres = 320, yield_bu = 150, price = 4.25, cost_per_acre = 700)
farm1
farm2
class(farm1)

farm2$price <- 4.80   # a better marketing price
farm2


# ----------------------------------------
# 3.11 Saving Data and Objects
# ----------------------------------------
results <- list(npv_grain_bin = npv(0.06, flows),
                loan_payment = loan_payment(150000, 0.065, 7))

saveRDS(results, "results.rds")
loaded <- readRDS("results.rds")
loaded

save(farm1, farm2, file = "farms.RData")   # several objects in one file
rm(farm1, farm2)
load("farms.RData")                        # farm1 and farm2 are back
farm1


# ----------------------------------------
# 3.12 SQLite Databases
# ----------------------------------------
library(DBI)

set.seed(7)
months <- format(seq(as.Date("2024-01-01"), by = "month", length.out = 12), "%Y-%m")
price_table <- data.frame(
  month = rep(months, 2),
  commodity = rep(c("corn", "soybeans"), each = 12),
  price = round(c(rnorm(12, mean = 4.4, sd = 0.2), rnorm(12, mean = 11.5, sd = 0.5)), 2)
)

con <- dbConnect(RSQLite::SQLite(), "prices.db")   # creates the file if needed
dbWriteTable(con, "prices", price_table, overwrite = TRUE)

dbGetQuery(con, "
  SELECT commodity,
         ROUND(AVG(price), 2) AS avg_price,
         MIN(price) AS min_price,
         MAX(price) AS max_price
  FROM prices
  GROUP BY commodity")

dbDisconnect(con)


# ============================================================
# 4 Vectors, Matrices, and Dataframes
# ============================================================

# ----------------------------------------
# 4.1 Creating Vectors
# ----------------------------------------
v1 <-c(1,2,3,4,5,6,7,8,9,10) # creates a numeric vector
v1
class(v1)

v2 <- seq(from=1,to=10,by=1) # another way
v2
v2[3] # returns the third element of "v2"

v1a<-1:10 # yet another way
v1a

v1b<-rep(1,5) # repeats 1 five times
v1b

set.seed(10110) # set seed for reproducibility
v3 = c(sample(c(1:20), 5)) # creates a numeric vector of 5 random numbers
v3

random<-rnorm(5,mean=0,sd=1) # creates a numeric vector of 5 random numbers
                             # from a standard normal distribution
random

char<-c("Kansas","Missouri","Oklahoma") # creates a character vector
char
class(char)
length(char) # returns the length of a vector


# ----------------------------------------
# 4.2 Extracting Vector Elements
# ----------------------------------------
vec<-round(rnorm(10,mean=50,sd=8),0) # create vector of 10 random numbers
                                     # rounded to nearest whole number
vec # returns all elements of the vector
vec[3] # returns the third element
vec[c(3,4)] # returns the third and fourth elements
vec[c(3:5)] # returns the third through the fifth elements
vec[-1] # returns all but the first element
vec[-c(1,2)] # returns all but the first and second elements
vec[-c(1:3)] # returns all but the first through third elements

monthly_prices <- c(4.10, 4.25, 4.18, 4.40, 4.52, 4.47)
monthly_prices[length(monthly_prices)]   # the last (most recent) price
tail(monthly_prices, 3)                  # the last three months
monthly_prices[c(TRUE, FALSE)]           # every other month

date_text <- "2024-08-12"
substr(date_text, 1, 4)   # year
substr(date_text, 6, 7)   # month


# ----------------------------------------
# 4.3 Numeric Operations on Vectors
# ----------------------------------------
a <- seq(1,5,1); b <- seq(6,10,1) # create some numeric vectors
a;b

a+1 # add 1 to each element of a
b*2 # multiply each element of b by 2
a+b # elementwise addition
a-b # elementwise subtraction
a*b # elementwise multiplication
a/b # elementwise division


# ----------------------------------------
# 4.4 Summary Statistics and Other Functions for Vectors
# ----------------------------------------
x <- rnorm(10) # create a vector
x
sum(x) # sum of all elements
mean(x) # mean
median(x) # median
var(x) # variance
sd(x) # standard deviation
min(x) # minimum value
max(x) # maximum value
range(x) # returns min and max
sort(x,decreasing=F) # sort from lowest to highest value
sort(x,decreasing=T) # sort from highest to lowest value

y<-c(1,1,seq(from=4,to=20,by=2))
y
unique(y) # returns vector of unique elements of "y"
length(unique(y)) # count number of unique elements of "y"
table(y) # frequency table of "y"

z<-c(1,2,3,4,NA,6)
z
sum(z) # this operation will not work
sum(z,na.rm=T) # this one will work, omitting the missing values before adding
is.na(z) # returns TRUE for values that are missing
sum(is.na(z)) # count number of missing values

set.seed(2025)
harvest_prices <- rnorm(1000, mean = 4.30, sd = 0.45)   # simulated $/bu

round(mean(harvest_prices), 2)                    # mean price
round(quantile(harvest_prices, c(0.05, 0.95)), 2) # 5th and 95th percentiles
mean(harvest_prices < 3.80)                       # probability price < $3.80

weekly_sales <- c(1200, 800, 1500, 1000, 900)     # bushels sold each week
cumsum(weekly_sales)                              # cumulative sales


# ----------------------------------------
# 4.5 Creating Matrices
# ----------------------------------------
a<-matrix(1:10,nrow=2,ncol=5,byrow=T) # creates 2x5 matrix with integers
                                      # 1 to 10, filled row-wise
a
b<-matrix(1:10,nrow=2,ncol=5,byrow=F) # now fill column-wise
b
t(b) # transposes matrix "b"
i<-diag(5) # creates a 5x5 identity matrix
i

c<-seq(1,5); d<-seq(6,10)
c; d # we have two vectors
e<-cbind(c,d) # creates matrix of two vectors, binding column-wise
e
f<-rbind(c,d) # creates matric of two vectors, binding row-wise
f


# ----------------------------------------
# 4.6 Extracting Matrix Elements
# ----------------------------------------
dim(e) # dimension of matrix "e" from above (rows x columns)
dim(f) # dimension of matrix "f"
nrow(e) # the number of rows
nrow(f)
e # returns all elements
e[1,] # returns first row
e[,1] # returns first column
e[2,2] # returns a single element, 2nd row and 2nd column
g<-matrix(1:25,5,5) # a 5 x 5
g
g2<-g[-c(1,2),-c(1,2)] # create new matrix omitting 1st
                       # and 2nd row and column of "g"
g2 # now a 3 x 3
diag(g2) # if passed a matrix object, diag() returns the diagonal elements


# ----------------------------------------
# 4.7 Numeric Operations on Matrices
# ----------------------------------------
h<-matrix(1:25,5,5,byrow=T)
i<-matrix(26:50,5,5,byrow=T)
h; i
# elementwise addition, matrices must have same dimensions
# for elementwise operations
h+i
h-i # elementwsie substraction
h*i # elementwise multiplication
2*h # scalar multiplication
h%*%i # matrix multiplication, ncol of "h" must equal nrow of "i"


# ----------------------------------------
# 4.8 Merge Vectors and Modify Elements
# ----------------------------------------
v1 <-c(1,2,3,4,5,6,7,8,9,10) # creates a numeric vector
v2 <- seq(from=1,to=10,by=1) # another way
seed<-10110
v3 = c(sample(c(1:20), 5)) # creates a numeric vector of 5 random numbers

#Creating dataframe and matrix
df1 <- data.frame(v1, v2, v3)

df2 <-matrix(1:9, nrow = 3, ncol = 3) #Default option: by column
df2

df3 <-matrix(1:9, nrow = 3, ncol = 3, byrow=TRUE) #by row
df3

df4 <- cbind(v1, v2, v3)
df4

df5 <- rbind(v1, v2, v3)
df5

#Modify elements of matrix
df5[2,3] <-50 # We want to replace a value in the 2nd row, 3rd column of the matrix.
df5


# ----------------------------------------
# 4.9 Create a Random Dataset
# ----------------------------------------
set.seed(111) # set seed for reproducibility
x <- rnorm(100,0,1)
x
dim(x)
dim(x) <- c(10,10) #Row, column

#Lists: Lists contain many objects of different classes and dimensions.
lst <- list(v1, df1, 45)
print(lst)


# ----------------------------------------
# 4.10 Create a Vector of Strings
# ----------------------------------------
str.vec <- c("R", "Python", "Stata", "SAS") # creates a character vector
str.vec
class(str.vec)
sapply(str.vec, class)

str.vec1 <-c("R",
             "Python",
             "Stata",
             "SAS",
             11, "12", as.character(13)) # another way

str.vec1 # returns all elements

class(str.vec1) # returns the class of "str.vec1")

sapply(str.vec1, class) # applies the function "class" to each element of "str.vec1"


# ----------------------------------------
# 4.11 System of Equations
# ----------------------------------------
# 1*x_1 + 2*x_2 = 10
# 3*x_1 + 4*x_2 = 25
# In matrix form, this is A*X=B.
A<-matrix(c(1,2,3,4),nrow=2,ncol=2,byrow=T)
A
B<-c(10,25)
B
X<-solve(A,B)
X


# ----------------------------------------
# 4.12 Creating Dataframes
# ----------------------------------------
x1<-as.character(c("Bob","John","Susan","Mary"))
x1
x2<-as.numeric(c(22,35,40,28))
x2
x3<-as.factor(c("M","M","F","F"))
x3

all<-data.frame(Name=x1,Age=x2,Gender=x3) # create dataframe from vectors,
                                          # assign variable names
all
class(all) # "all" is a dataframe object
dim(all) # 4 observations, 3 variables
                  # applies function "class" to each variable in dataframe "all"
sapply(all,class) # notice each variable is a different class/data type


# ----------------------------------------
# 4.13 Extracting Dataframe Elements
# ----------------------------------------
all[1,] # return first observation
all[,1] # return first column (variable)
all[,'Name'] # another way
all$Name # yet another way
rownames(all) # extract row names, by default these are "1,2,3..."
colnames(all) # extract column (variable) names


# ----------------------------------------
# 4.14 Useful Dataframe Functions
# ----------------------------------------
# returns summary information for each variable
             # if numeric variable, summary statistics are returned
summary(all) # if factor variable, a frequency table is returned
all2<-all[-1,] # create new dataframe, omitting first observation from "all"
all2
all2$GenderDummy<-ifelse(all2$Gender=="M",1,0) # create dummy variable,
                                               # assign variable name
all2


# ============================================================
# 5 Working Directory, Importing, and Exporting
# ============================================================

# ----------------------------------------
# 5.1 Working Directory
# ----------------------------------------
# returns file path of working directory
getwd() # this is where R imports data from and exports to

# Example: edit the folder/file below, then remove the comment markers to run it.
# setwd("C:/Users/Walter/OneDrive - Kansas State University/2024/Fall 2024/R_session_2024") # set desired working directory for PC (Windows)

# #setwd("/Users/your-username/OneDrive - Kansas State University/2024/Fall 2024/R_session_2024") # set desired working directory for MAC (iOS)

dir.create(file.path("data", "raw"), recursive = TRUE, showWarnings = FALSE)  # create folders
path <- file.path("data", "raw", "prices.csv")   # builds "data/raw/prices.csv"
path

write.csv(data.frame(price = c(4.25, 4.10)), path, row.names = FALSE)
list.files(file.path("data", "raw"))                      # files in a folder
list.files("data", pattern = "\\.csv$", recursive = TRUE)  # all CSV files under "data"


# ----------------------------------------
# 5.2 Importing
# ----------------------------------------
demographics <- read.csv(file="demographics.csv", header = TRUE)

# Print the first 10 rows and first 10 columns of the dataframe
print(demographics[1:10, 1:10])


# ============================================================
# 6 Data Wrangling
# ============================================================

# ----------------------------------------
# 6.1 Data Exploration
# ----------------------------------------
# Data
dim(demographics) # Check the dimensions of the dataframe
colnames(demographics) # Check the names of the variables in the dataframe
class(demographics) # Check the class of the dataframe
sapply(demographics, class) # Check the class of each variable in the dataframe
head(demographics) # returns first 6 observations


# ----------------------------------------
# 6.2 Data Manipulation
# ----------------------------------------
# Create a new subdataset from demographics dataset
household <- demographics[1:10, 1:10]
colnames(household) # Check the names of the variables in the dataframe
class(household) # Check the class of the dataframe
sapply(household, class) # Check the class of each variable in the dataframe
dim(household)

colnames(household)<-c("hhnum",           "nonmetro",        "Region",          "Rural",           "Household_size",          "Income_hhavg_r",      "pctpovguidehh_r", "povthresholh_hh", "Selfemployment",    "exprentmrtg_r" ) # rename variables
head(household, 10) # returns first 10 observations, notice new variable names


# ----------------------------------------
# 6.3 Pipilining and Data Estimations
# ----------------------------------------
# Calculate the mean for each numeric column, excluding non-numeric columns
average_values <- household %>%
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>%
  as.list()


# ----------------------------------------
# 6.4 Create a New Row
# ----------------------------------------
# Create a new row with NA for non-numeric columns
new_row <- as.list(rep(NA, ncol(household)))
names(new_row) <- colnames(household)

# Replace the values in the new row with calculated averages for numeric columns
new_row[names(average_values)] <- average_values

# Convert the list to a dataframe
new_row_df <- as.data.frame(new_row, stringsAsFactors = FALSE)

# Add the new row to the original dataframe
household_with_avg <- bind_rows(household, new_row_df)

# Display the updated dataframe with the new row
head(household_with_avg)


# ----------------------------------------
# 6.5 Create a New Column
# ----------------------------------------
# Create a vector for the 'Variable' column with identifiers
row_identifiers <- c(rep(paste0("No", 1:(nrow(household))), each = 1), "Average")

# Add the 'Variable' column to the dataframe
household_with_avg <- household_with_avg %>%
  mutate(Variable = row_identifiers)

# Display the updated dataframe with the new column
head(household_with_avg)


# ----------------------------------------
# 6.6 Rearrange the Columns
# ----------------------------------------
# Reorder columns to place 'Variable' as the first column
household_with_avg <- household_with_avg %>%
  select(Variable, everything())

# Display the updated dataframe with the new column
head(household_with_avg)


# ----------------------------------------
# 6.7 Filter, Sort, and Group
# ----------------------------------------
# Filter: households with income above $60,000
high_income <- household %>% filter(Income_hhavg_r > 60000)
nrow(high_income)

# Sort: largest rent or mortgage expense first
household %>% arrange(desc(exprentmrtg_r)) %>% head(3)

# Group: number of households, average income, and average size by region
household %>%
  group_by(Region) %>%
  summarise(households = n(),
            avg_income = mean(Income_hhavg_r, na.rm = TRUE),
            avg_size = mean(Household_size, na.rm = TRUE))


# ----------------------------------------
# 6.8 Exporting
# ----------------------------------------
write.csv(household,"household.csv") # export as csv file

write.csv(household,"household.csv",row.names=F)

write.table(household,"household.txt",row.names=F,sep=" ")


# ============================================================
# 7 Data Visualization
# ============================================================

# ----------------------------------------
# 7.1  Simple Graphing
# ----------------------------------------
data<-rnorm(500,mean=0,sd=1) # generate 500 random numbers from a standard normal distribution
hist(data) # create histogram of "data"
hist(data,prob=T) # sets total area equal to 1

                                     # draw vertical line at the mean,
abline(v=mean(data),col='red',lwd=5) # change color and line width

boxplot(data,main='Creative Title',ylab='A y-axis label (with units)')
abline(h=mean(data),col='blue',lwd=2) # draw horizontal line at the mean

x<-seq(1,100); y=x*2 # generate data
plot(x,y) # create scatter plot with "x" on x-axis, "y" on y-axis
# again, but fancier
plot(x,y,
     main="Scatter plot",
     xlab="Predictor (x)",
     ylab="Response (y)",
     pch=5, # "pch" changes plotting character
     cex=1.5, # "cex" changes character size
     col='purple') # color of plotting character
# This would look better as a line plot.
plot(x,y,
     main="Line plot",
     xlab="Predictor (x)",
     ylab="Response (y)",
     pch=5,
     cex=1.5,
     col='purple',
     type='l') # type='l' specifies a line plot


# ----------------------------------------
# 7.2 Plotting functions
# ----------------------------------------
x <- seq(0, 10, by = 0.01)
y1 <- sapply(x, function(i) 2*i + 1) #y=2x+1
plot(x, y1, type = 'l', col = 'blue')

y2 <- sapply(x, function(i) 2*i^2+3*i+1) #y2=2x^2+3x+1
plot(x, y2, type = 'l', col = 'purple')

y3 <- sapply(x, function(i) i^3+2*i^2-3) # y3 = x^3+2x^2-3
plot(x, y3, type = 'l', col = 'red')

#Print plots
print(y1)
print(y2)
print(y3)


# ----------------------------------------
# 7.3 Multiple Graphs
# ----------------------------------------
plot(x, y1, type = 'l', main = 'Figure. Graph of functions',
     col = 'purple', lwd=3, xlim = c(0, 10), ylim = c(-10, 50),
     xlab = 'x', ylab = 'y')
lines(x, y2, col = 'blue', lwd = 3)
lines(x, y3, col = 'red', lwd = 3)

legend('topright', legend=c("Linear", "Quadratic", "Polynomial"),
       col = c("purple", "blue", "red"),
       lwd = 3, cex = 0.8, ncol = 2, text.width = 1)

# Main: title of the graph
# sub: subtitle of the graph
# xlab: Label of the x-axis
# ylab: Label of the y-axis
# col: color of the graph
# lwd: line width
# xlim: Limits of the x-axis
# ylim: Limits of the y-axis

#print the plot
print(plot(x, y1, type = 'l', main = 'Figure. Graph of functions',
     col = 'purple', lwd=3, xlim = c(0, 10), ylim = c(-10, 50),
     xlab = 'x', ylab = 'y'))


# ----------------------------------------
# 7.4 Bar Charts
# ----------------------------------------
crop_names <- c("Corn", "Soybeans", "Wheat", "Sorghum")
revenue_acre <- c(180 * 4.25, 55 * 10.90, 50 * 5.60, 95 * 4.05)

barplot(revenue_acre, names.arg = crop_names,
        col = c("#2a5298", "#3c8d5a", "#c9a227", "#a0522d"),
        ylab = "Revenue ($ per acre)", main = "Revenue per acre by crop")


# ----------------------------------------
# 7.5 Supply and Demand
# ----------------------------------------
P <- seq(0, 10, length.out = 100)
Qd <- 100 - 8 * P
Qs <- 20 + 12 * P

p_eq <- (100 - 20) / (8 + 12)   # solve 100 - 8P = 20 + 12P
q_eq <- 100 - 8 * p_eq
c(price = p_eq, quantity = q_eq)

plot(Qd, P, type = "l", col = "#2a5298", lwd = 2, xlim = c(0, 110), ylim = c(0, 10),
     xlab = "Quantity", ylab = "Price", main = "Market equilibrium")
lines(Qs, P, col = "#c0392b", lwd = 2)
points(q_eq, p_eq, pch = 19)
text(q_eq, p_eq, sprintf("Equilibrium (%.0f, %.2f)", q_eq, p_eq), pos = 4)
legend("topright", legend = c("Demand", "Supply"), col = c("#2a5298", "#c0392b"), lwd = 2)


# ----------------------------------------
# 7.6 Mappying with R
# ----------------------------------------
# Load the necessary libraries
library(tigris)
library(spdep)
library(dplyr)
library(tidyverse)
library(ggplot2)

KS_counties <- counties(state = "Kansas", cb = TRUE, resolution = "20m")
KS_counties$stcofips <- paste(KS_counties$STATEFP, KS_counties$COUNTYFP, sep="")

nb <- poly2nb(KS_counties)

county_names <- KS_counties$NAME

# Plotting Kansas AWATER
Figure_Map <- ggplot(data= KS_counties) +
            geom_sf(aes(fill = `AWATER`), size = 0.5, color = "black") +
            coord_sf() + theme_bw() +
            geom_sf_text(aes(label = `NAME`), colour = "black", size = 2) +
              theme(axis.text.x = element_blank(),
                    axis.text.y = element_blank(),
                    panel.grid = element_blank(),
                    panel.border = element_blank(),
                    axis.ticks = element_blank()
                    ) +
              labs(title = "Water Avilability at County Level in Kansas",
                 caption = "Fuente: USDA, 2024") +

              theme(plot.title = element_text(size = 12, hjust=0.5),
                    plot.subtitle = element_text(size = 12, hjust=0.5)
                    ) +

                  theme(legend.text = element_text( color = "black", size = 12),
                                      legend.position = "right",
                                      legend.key.width = unit(0.5, "cm"),
                        )

Figure_Map


# ----------------------------------------
# 7.7 Export High Quality Figures
# ----------------------------------------
#TIFF
#ggsave(filename="../Figures/Figure_Map01.tiff", plot = Figure_Map, width = 6, height = 6, dpi = 1200, units = "in", device='tiff')

# PNG
#ggsave("../Figures/Figure_Map01.png", Figure_Map, height = 6, width = 6)

#PDF
#ggsave("../Figures/Figure_Map01.pdf", Figure_Map, height = 6, width = 6)


# ----------------------------------------
# 7.8 Mapping US at State Level
# ----------------------------------------
library(usmap)
library(ggplot2)

#print(statepop)

plot_usmap(data = statepop, values = "pop_2022", color = "black") +
  scale_fill_continuous(name = "Population (2022)", label = scales::comma,
                        low = "blue", high = "red",) +
  theme(legend.position = "right")


# ----------------------------------------
# 7.9 Mapping Western US States
# ----------------------------------------
library(usmap)
library(ggplot2)

map_western <- plot_usmap(
              data = statepop, values = "pop_2022", include = c("NE", "KS", "OK","TX","LA",
                                                                "MO", "AR", "IA", "MN",
                                                                "WI", "IL", "MI",
                                                                "IN"), color = "black"
            ) +
            scale_fill_continuous(
              low = "white", high = "green", name = "Population (2022)", label = scales::comma
            ) +
            labs(title = "Western US States", subtitle = "These are the states in the Pacific Timezone.") +
            theme(legend.position = "right")

map_western


# ----------------------------------------
# 7.10 County Level Maps
# ----------------------------------------
library(usmap)
library(ggplot2)
library(dplyr)

# Get county information for the specified states
states <- c("NE", "KS", "OK", "TX", "LA", "MO", "AR", "IA", "MN", "WI", "IL", "MI", "IN")
county_info <- us_map(regions = "counties", include = states)

# Create a data frame with FIPS codes and random population data
set.seed(123)  # For reproducibility
county_data <- data.frame(
  fips = county_info$fips,
  pop_2022 = sample(1000:100000, size = length(county_info$fips), replace = TRUE)
)

# Plot county boundaries with the selected variable
map_western_counties <- plot_usmap(
  regions = "counties",  # Plot at the county level
  include = states,
  data = county_data, values = "pop_2022",  # Use the population variable
  color = "black"  # Set the color of the county borders
) +
  scale_fill_continuous(
    low = "white", high = "royalblue", name = "Population (2022)", label = scales::comma
  ) +
  labs(title = "County-Level Population in Selected Western US States",
       subtitle = "Population data displayed at the county level.") +
  theme(legend.position = "right")

# Display the map
map_western_counties


# ============================================================
# 8 Regression and Summary Tables
# ============================================================
#install.packages("stargazer")
library(stargazer)

stargazer(attitude[1:4,], summary=FALSE, rownames=FALSE, type='text') # Print the results


# ----------------------------------------
# 8.1 Regression with Matrix Algebra
# ----------------------------------------
set.seed(42)
n <- 200
farms <- data.frame(fertilizer = runif(n, 50, 200),          # lbs of nitrogen per acre
                    rainfall = runif(n, 15, 40),              # inches during the season
                    irrigated = sample(0:1, n, replace = TRUE))
farms$yield_bu <- 60 + 0.35 * farms$fertilizer + 1.5 * farms$rainfall +
                  20 * farms$irrigated + rnorm(n, 0, 15)       # corn yield, bu/acre

X <- cbind(Intercept = 1, as.matrix(farms[, c("fertilizer", "rainfall", "irrigated")]))
y <- farms$yield_bu

beta <- solve(t(X) %*% X, t(X) %*% y)   # solves (X'X) b = X'y
round(beta, 3)

# The same estimates with lm()
round(coef(lm(yield_bu ~ fertilizer + rainfall + irrigated, data = farms)), 3)


# ----------------------------------------
# 8.2 Linear Regression
# ----------------------------------------
lm1 <- lm(mpg ~ wt,      data = mtcars ) # Model 1

# Saving stargazer objects as html to be open on Word
stargazer(lm1, title="Results Linear Regresion", align=TRUE, type = "text")


# ----------------------------------------
# 8.3 Multiple Linear Regression
# ----------------------------------------
linear.1 <- lm(rating ~ complaints + privileges + learning + raises + critical,
data=attitude)
linear.2 <- lm(rating ~ complaints + privileges + learning, data=attitude)

attitude$high.rating <- (attitude$rating > 70) # Create an indicator dependent variable, and run a probit model
probit.model <- glm(high.rating ~ learning + critical + advance, data=attitude,
family = binomial(link = "probit"))

# Saving stargazer objects as html to be open on Word
stargazer(linear.1, linear.2, probit.model, title="Results Multiple Models", align=TRUE, type = "text", out = "linear-model.html")
