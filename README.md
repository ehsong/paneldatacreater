Panel Data Creater
================

R code for creating panel data sets.

## Motivation

As researchers we always deal with creating data sets, and panel data
sets are one of them. Panel data sets are tricky because most data sets
we find are either excel sheet format arranged by year or documents that
needs to be manually arranged so that it can be prepared for analysis.

This is a simple R code that helps turning a single .xlsx file with
multiple year-sheets to a panel data set.

## Code

### Single File With Year .xlsx Sheets

``` r
# Panel Data Creater

# Libraries

library(readxl)
library(foreign)

# Set Directory
setwd(#directory)

filename<-#file.xlsx
column_name<-#vector of column names, without 'year' 

# Function that Reads a Sheet
read_f<-function(i) {
  df<-read_xlsx(filename, sheet = i, col_names = TRUE)
  colnames(df)<-column_names
  return(df)
}

# Loop the Function Over Multiple Sheets, Store Sheet Results in List

n = #maximum number of sheets to loop 
year_vector = #a vector of years
  
get_datalist<-function() {
  datalist = list()
  for (i in 1:n) {
    df<-read_f(i)
    # while looping, add 'year' to the column
    years = year_vector
    df$year<-years[i]
    datalist[[i]]<-df
  }
  return(datalist)
}

# Row Bind Elements in the List

panel_data<-do.call(rbind,get_datalist())

# Save Results as .RData
output_filename = #output_filename.rda
save(panel_data,file=output_filename)

# Save Results as .dta for STATA
output_filename2 = #output_filename.dta
write.dta(panel_data,file=output_filename2)
```

### Example

This is an example of usage of the code above on a .xlsx sheet
containing sheets across 1993-2007 period on number of public employees
and other indicators across provinces in China.

``` r
# Libraries

library(readxl)
library(foreign)

# Set Directory
setwd("~/Dropbox/Data_Insert/Final_Version")

filename<-"Final_Edited_1116.xlsx"
column_names<-c("id","province_name","population","rural_population","public_employees",
                  "profit_making_pe","local_gr","local_ex","total_ex",
                  "gdp_nat","farming_output")

# Function that Reads a Sheet
read_f<-function(i) {
  df<-read_xlsx(filename, sheet = i, col_names = TRUE)
  colnames(df)<-column_names
  return(df)
}

# Loop the Function Over Multiple Sheets, Store Sheet Results in List

n = 15 
year_vector = c(1993:2007)
  
get_datalist<-function() {
  datalist = list()
  for (i in 1:n) {
    df<-read_f(i)
    # while looping, add 'year' to the column
    years = year_vector
    df$year<-years[i]
    datalist[[i]]<-df
  }
  return(datalist)
}

# Row Bind Elements in the List

panel_data<-do.call(rbind,get_datalist())
panel_data<-as.data.frame(panel_data)

head(panel_data)
```

    ##   id  province_name population rural_population public_employees
    ## 1  1        Beijing        337              267           160000
    ## 2  2        Tianjin        300              268            98653
    ## 3  3          Hebei       5493             5074          1120653
    ## 4  4         Shanxi       2951             2265           779224
    ## 5  5 Inner Mongolia       2232             1475           697418
    ## 6  6       Liaoning       4049             2283           863986
    ##            profit_making_pe local_gr local_ex total_ex gdp_nat
    ## 1                      <NA>   124633   140658       NA      NA
    ## 2 미국가재정 부담 공무원 수    59861    55306       NA      NA
    ## 3                      <NA>   557725   598192       NA      NA
    ## 4                      <NA>   412250   418225       NA      NA
    ## 5                      <NA>   286501   430882       NA      NA
    ## 6                      <NA>   665014   798810       NA      NA
    ##   farming_output year
    ## 1             NA 1993
    ## 2             NA 1993
    ## 3             NA 1993
    ## 4             NA 1993
    ## 5             NA 1993
    ## 6             NA 1993
