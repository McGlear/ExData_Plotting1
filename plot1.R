################################################
####...............Make Plot 1..............####
####                                        ####
####        Call make.plot() to run!        ####
################################################


## This script overrides the function own_plot()
##  and the integer plotnumber, which will be
##  accessed by make.plot() in the utility script


#################################################
## own_plot implements the actual plot creation.
## While it can be called directly, it is rather
##  intended to be called automatically from the
##  make.plot() function, which is the usual 
##  starting point for plot creation of these
##  scripts. Please refer to plot_utility.R for
##  information on make.plot()
#################################################
own_plot <- function(df_plotting = df_february){
    
    with(df_plotting,
         hist(Global_active_power,
              main="Global Active Power",
              col= "orangered",
              xlab ="Global active Power (kilowatts)"
         )
    )
    
}

plotnumber=1


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