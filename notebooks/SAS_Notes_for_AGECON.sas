/* SAS Notes for AGECON: Basics and Fundamentals */
/* Walter Ac-Pangan, Ph.D., October 2026 */
/* Run the examples in order. Each section creates the data it needs. */


/* ============================================================ */
/* 1 Introduction to SAS */
/* ============================================================ */

/* ---------------------------------------- */
/* 1.1 Getting Access */
/* ---------------------------------------- */

/* ---------------------------------------- */
/* 1.2 How SAS Programs Work */
/* ---------------------------------------- */

/* ============================================================ */
/* 2 The Basics */
/* ============================================================ */

/* ---------------------------------------- */
/* 2.1 Comments and Your First Output */
/* ---------------------------------------- */
* This is a comment that ends with a semicolon;
/* This is a block comment. It can span
   several lines. */

%put Hello, AGECON!;   /* %put writes a message to the log */


/* ---------------------------------------- */
/* 2.2 Variables and Calculations */
/* ---------------------------------------- */
data _null_;
  w = 10;
  x = 20;
  y = 30;
  total = w + x + y;
  put "The total is " total;
run;


/* ---------------------------------------- */
/* 2.3 Calculator and Math Functions */
/* ---------------------------------------- */
data _null_;
  x = 3;
  y = 7;
  add      = x + y;
  subtract = x - y;
  multiply = x * y;
  divide   = x / y;
  power    = x ** 2;          /* exponent */
  root     = sqrt(x);         /* square root */
  rounded  = round(x / y, 0.001);
  lower    = floor(x / y);    /* largest integer <= x/y */
  upper    = ceil(x / y);     /* smallest integer >= x/y */
  absval   = abs(x - y);
  ln_x     = log(x);          /* natural log */
  log10_x  = log10(x);
  quotient = int(1250 / 400); /* integer part: full truckloads */
  leftover = mod(1250, 400);  /* remainder: bushels left over */
  put add= subtract= multiply= divide= power= root= rounded=;
  put lower= upper= absval= ln_x= log10_x= quotient= leftover=;
run;

data _null_;
  /* Unit conversion: one bushel of corn = 56 lb, one lb = 0.45359237 kg */
  bushels = 10000;
  metric_tons = bushels * 56 * 0.45359237 / 1000;
  put "Metric tons: " metric_tons 8.2;

  /* Revenue, cost, and profit for a 500-acre corn farm */
  acres = 500; yield_bu = 180; price = 4.25; cost_per_acre = 690;
  revenue = acres * yield_bu * price;
  total_cost = acres * cost_per_acre;
  profit = revenue - total_cost;
  margin = profit / revenue * 100;
  put "Revenue: " revenue dollar12.2 "  Profit: " profit dollar12.2 "  Margin (%): " margin 5.1;

  /* Break-even price */
  break_even = cost_per_acre / yield_bu;
  put "Break-even price ($/bu): " break_even 6.2;

  /* Percent change in the soybean price */
  pct_change = (10.90 - 13.20) / 13.20 * 100;
  put "Percent change: " pct_change 6.1;

  /* Compound interest: FV = PV * (1 + r)**t */
  fv = 10000 * (1 + 0.04) ** 5;
  put "Future value: " fv dollar12.2;
run;


/* ---------------------------------------- */
/* 2.4 Missing Values */
/* ---------------------------------------- */
data _null_;
  x = .;
  a = 1 + x + 3;        /* missing */
  b = sum(1, x, 3);     /* 4: the function ignores the missing value */
  c = mean(1, x, 3);    /* 2 */
  is_missing = missing(x);
  put a= b= c= is_missing=;
run;


/* ---------------------------------------- */
/* 2.5 Logical Operators */
/* ---------------------------------------- */
data _null_;
  x = 3; y = 7;
  eq  = (x = y);              /* equal (also written eq) */
  ne  = (x ne y);             /* not equal (also ^=) */
  lt  = (x < 10);
  both   = (x < 20 and y >= 50);
  either = (x < 20 or y >= 50);
  in_list = (x in (1, 2, 3, 4));
  put eq= ne= lt= both= either= in_list=;
run;


/* ---------------------------------------- */
/* 2.6 Data Types and Formats */
/* ---------------------------------------- */
data types;
  length commodity $ 12;           /* character variable, up to 12 characters */
  commodity = "Corn";
  price = 4.25;                    /* numeric */
  price_text = "$4.25";
  price_num = input(compress(price_text, "$"), 8.);   /* text -> number */
  quantity = input("1,250", comma8.);                 /* reads the comma */
  revenue = 382500;
  format revenue dollar12.2;
run;

proc print data=types noobs;
run;

proc contents data=types;   /* lists variables, types, and formats */
run;


/* ---------------------------------------- */
/* 2.7 Working with Dates */
/* ---------------------------------------- */
data dates;
  planting   = '25APR2024'd;
  harvest    = '05OCT2024'd;
  season_days = harvest - planting;              /* days from planting to harvest */
  loan_start = '01MAR2024'd;
  maturity   = intnx('month', loan_start, 18, 'same');   /* 18-month operating loan */
  harvest_year  = year(harvest);
  harvest_month = month(harvest);
  format planting harvest loan_start maturity date9.;
run;

proc print data=dates noobs;
run;


/* ============================================================ */
/* 3 Fundamentals */
/* ============================================================ */

/* ---------------------------------------- */
/* 3.1 Creating a Dataset */
/* ---------------------------------------- */
data crops;
  input crop $ acres yield price;
  datalines;
corn     300 180 4.25
soybeans 200  55 10.90
wheat    100  50 5.60
;
run;

proc print data=crops;
run;


/* ---------------------------------------- */
/* 3.2 Creating New Variables */
/* ---------------------------------------- */
data crops2;
  set crops;
  revenue = acres * yield * price;
  revenue_per_acre = yield * price;
  format revenue dollar12.2 revenue_per_acre dollar8.2;
run;

proc print data=crops2;
  sum revenue;   /* adds a total row for revenue */
run;


/* ---------------------------------------- */
/* 3.3 If-Then-Else */
/* ---------------------------------------- */
data farms_size;
  input farm $ acres market_price bushels;
  length size $ 6;
  if acres < 500 then size = "small";
  else if acres < 2000 then size = "medium";
  else size = "large";

  support_price = 3.70;   /* hypothetical support price, $/bu */
  if market_price < support_price then payment = (support_price - market_price) * bushels;
  else payment = 0;
  format payment dollar12.2;
  datalines;
A  120 3.45 20000
B  850 3.90 95000
C 2400 3.55 410000
D  430 3.75 60000
;
run;

proc print data=farms_size noobs;
run;


/* ---------------------------------------- */
/* 3.4 DO Loops */
/* ---------------------------------------- */
data growth;
  balance = 10000;
  do year = 1 to 5;
    balance = balance * 1.05;
    output;               /* write one row per year */
  end;
  format balance dollar12.2;
run;

proc print data=growth noobs;
run;

data _null_;
  balance = 1000;
  years = 0;
  do while (balance < 2000);
    balance = balance * 1.06;
    years + 1;            /* sum statement: adds 1 */
  end;
  put "Years to double: " years "  Final balance: " balance dollar10.2;
run;

data loan;
  debt = 20000;
  do year = 1 to 10 while (debt > 0);
    debt = debt * 1.07 - 5000;    /* interest is added, then the payment is made */
    remaining = max(debt, 0);
    output;
  end;
  keep year remaining;
  format remaining dollar12.2;
run;

proc print data=loan noobs;
run;


/* ---------------------------------------- */
/* 3.5 Arrays */
/* ---------------------------------------- */
data real_prices;
  array nominal{5} p1-p5 (3.50 3.70 4.10 5.90 6.50);   /* $/bu */
  array cpi{5}     c1-c5 (100 102 105 110 118);         /* price index */
  array real{5}    r1-r5;
  do i = 1 to 5;
    real{i} = round(nominal{i} / cpi{i} * 100, 0.01);
  end;
  drop i;
run;

proc print data=real_prices noobs;
  var r1-r5;
run;


/* ---------------------------------------- */
/* 3.6 Net Present Value */
/* ---------------------------------------- */
data npv;
  do rate = 0.06, 0.10;
    npv = -50000;
    do t = 1 to 8;
      npv + 9000 / (1 + rate) ** t;
    end;
    output;
  end;
  keep rate npv;
  format rate percent6.0 npv dollar12.2;
run;

proc print data=npv noobs;
run;


/* ---------------------------------------- */
/* 3.7 Macros: Reusable Code */
/* ---------------------------------------- */
%let price = 4.25;
%let cost_per_acre = 690;
%put Price is &price and cost per acre is &cost_per_acre;

/* A macro that reports the annual payment on a loan */
%macro loan_payment(principal=, rate=, years=);
  data _null_;
    payment = &principal * &rate / (1 - (1 + &rate) ** (-&years));
    put "Annual payment on &principal at &rate for &years years: " payment dollar12.2;
  run;
%mend loan_payment;

%loan_payment(principal=150000, rate=0.065, years=7);
%loan_payment(principal=80000, rate=0.07, years=5);


/* ============================================================ */
/* 4 Working with Datasets */
/* ============================================================ */

/* ---------------------------------------- */
/* 4.1 Libraries and Importing Data */
/* ---------------------------------------- */
/* Example: edit the folder/file below, then remove the comment markers to run it. */
/* libname mydata "/home/your-username/AGECON"; */


/* proc import datafile="/home/your-username/AGECON/demographics.csv" */
/*             out=work.demographics */
/*             dbms=csv */
/*             replace; */
/*   getnames=yes; */
/* run; */

data household;
  call streaminit(2024);
  do hhnum = 1001 to 1010;
    region         = rand("integer", 1, 4);
    rural          = rand("bernoulli", 0.5);
    household_size = rand("integer", 1, 6);
    income         = round(rand("normal", 65000, 20000));
    rent_mortgage  = round(rand("normal", 1200, 300));
    output;
  end;
  label income = "Average household income ($)"
        rent_mortgage = "Monthly rent or mortgage ($)";
run;


/* ---------------------------------------- */
/* 4.2 Exploring Data */
/* ---------------------------------------- */
proc contents data=household;       /* variables and types */
run;

proc print data=household (obs=5);  /* first 5 rows */
run;

proc means data=household n mean std min max;
  var income household_size rent_mortgage;
run;

proc freq data=household;
  tables region rural;
run;


/* ---------------------------------------- */
/* 4.3 Filter, Sort, and Group */
/* ---------------------------------------- */
/* Filter: households with income above $60,000 */
data high_income;
  set household;
  where income > 60000;
run;

/* Sort: largest rent or mortgage first */
proc sort data=household out=sorted;
  by descending rent_mortgage;
run;

proc print data=sorted (obs=3);
run;

/* Group: averages by region */
proc means data=household mean maxdec=1;
  class region;
  var income household_size;
run;


/* ---------------------------------------- */
/* 4.4 Merging Datasets */
/* ---------------------------------------- */
data region_names;
  input region region_name $ 3-20;
  datalines;
1 Northeast
2 Midwest
3 South
4 West
;
run;

proc sort data=household; by region; run;
proc sort data=region_names; by region; run;

data household_named;
  merge household region_names;
  by region;
run;


/* ---------------------------------------- */
/* 4.5 Exporting */
/* ---------------------------------------- */
/* Example: edit the folder/file below, then remove the comment markers to run it. */
/* proc export data=household */
/*             outfile="/home/your-username/AGECON/household.csv" */
/*             dbms=csv */
/*             replace; */
/* run; */


/* ============================================================ */
/* 5 Data Visualization */
/* ============================================================ */

/* ---------------------------------------- */
/* 5.1 Histogram and Boxplot */
/* ---------------------------------------- */
data prices;
  call streaminit(2025);
  do i = 1 to 1000;
    harvest_price = rand("normal", 4.30, 0.45);   /* simulated $/bu */
    output;
  end;
run;

proc sgplot data=prices;
  histogram harvest_price;
  density harvest_price;
  title "Distribution of simulated harvest prices";
run;

proc sgplot data=prices;
  vbox harvest_price;
  title "Boxplot of harvest prices";
run;

/* Price risk: 5th and 95th percentiles of the simulated prices */
proc univariate data=prices noprint;
  var harvest_price;
  output out=pctl pctlpts=5 95 pctlpre=p;
run;

proc print data=pctl noobs;
run;


/* ---------------------------------------- */
/* 5.2 Bar Chart */
/* ---------------------------------------- */
proc sgplot data=crops2;
  vbar crop / response=revenue_per_acre;
  yaxis label="Revenue ($ per acre)";
  title "Revenue per acre by crop";
run;


/* ---------------------------------------- */
/* 5.3 Supply and Demand */
/* ---------------------------------------- */
data market;
  do P = 0 to 10 by 0.1;
    Qd = 100 - 8 * P;
    Qs = 20 + 12 * P;
    output;
  end;
run;

proc sgplot data=market;
  series x=Qd y=P / legendlabel="Demand" lineattrs=(thickness=2);
  series x=Qs y=P / legendlabel="Supply" lineattrs=(thickness=2);
  dropline x=68 y=4 / dropto=both;
  xaxis label="Quantity" min=0 max=110;
  yaxis label="Price" min=0 max=10;
  title "Market equilibrium";
run;


/* ============================================================ */
/* 6 Regression */
/* ============================================================ */
data farms;
  call streaminit(42);
  do id = 1 to 200;
    fertilizer = 50 + 150 * rand("uniform");     /* lbs of nitrogen per acre */
    rainfall   = 15 + 25 * rand("uniform");      /* inches during the season */
    irrigated  = rand("bernoulli", 0.5);
    yield_bu   = 60 + 0.35*fertilizer + 1.5*rainfall + 20*irrigated + rand("normal", 0, 15);
    high_yield = (yield_bu > 160);
    output;
  end;
run;

proc means data=farms n mean std min max maxdec=2;
run;


/* ---------------------------------------- */
/* 6.1 Linear and Multiple Regression */
/* ---------------------------------------- */
proc reg data=farms;
  model yield_bu = fertilizer;                          /* simple regression */
  model yield_bu = fertilizer rainfall irrigated;       /* multiple regression */
run;
quit;

/* Robust (heteroskedasticity-consistent) standard errors */
proc reg data=farms;
  model yield_bu = fertilizer rainfall irrigated / hcc;
run;
quit;


/* ---------------------------------------- */
/* 6.2 Probit Model */
/* ---------------------------------------- */
proc logistic data=farms descending;
  model high_yield = fertilizer rainfall irrigated / link=probit;
run;


/* ---------------------------------------- */
/* 6.3 Regression with Matrix Algebra */
/* ---------------------------------------- */
proc iml;
  use farms;
  read all var {fertilizer rainfall irrigated} into Xvars;
  read all var {yield_bu} into y;
  close farms;

  X = j(nrow(Xvars), 1, 1) || Xvars;   /* add an intercept column */
  beta = solve(X` * X, X` * y);         /* solves (X'X) b = X'y */
  print beta[rowname={"Intercept" "fertilizer" "rainfall" "irrigated"}];
quit;
