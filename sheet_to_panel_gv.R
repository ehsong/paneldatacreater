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