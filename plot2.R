################################################
####                Make Plot 2             ####
####                                        ####
####        Call make.plot() to run!        ####
################################################


## Plotting implementation
own_plot <- function(df_plotting = df_february){
    
    with(df_plotting,        
         
         plot(DateTime, Global_active_power,
              main="",
              col= "black",
              type="l",
              ylab = "Global Active Power (kilowatts)",
              xlab = ""
         )
    )
    
}

plotnumber=2


## The process of loading and subsetting data,
##  opening png devices, plotting, closing and
##  previewing is the same for all plotting
##  scripts of the first course assignment.
## I therefore decided to outsource those parts
##  of the script into a utility-file.
## It is sourced whenever a "plot_n.R" file is
##  run, unless it has already been sourced
##  before (concept is similar to C++ Header
##  Guards, for those of you familiar with
##  the C++ preprocessor...)


if(!exists("utils_loaded")){
    source("plot_utility.R")
}