################################################
####                Make Plot 3             ####
####                                        ####
####        Call make.plot() to run!        ####
################################################

## Ensure English labels
Sys.setlocale("LC_TIME", "English")


## Plotting implementation
own_plot <- function(df_plotting = df_february){
    
    ## Basic Setup, does not visibly plot anything so that the script looks
    ##  more consistent
    
    plot(df_plotting$DateTime,df_plotting$Sub_metering_1,
         main="",
         ylim=c(0, max(c(df_plotting$Sub_metering_1, 
                         df_plotting$Sub_metering_2, 
                         df_plotting$Sub_metering_3))),
         xlab="DateTime",
         ylab="Energy Sub Metering",
         type="n"  # Could instaed use type "l" and omit first "lines" call
    )
    
    
    vc_colors <- c("black", "red", "blue") # Define Colors
    vc_names <- NULL # For later use with legend()
    
    ## Create a line graph for each set
    for ( i in 1:3){
        name <- paste("Sub_metering_",i,sep="")
        lines(df_plotting$DateTime, df_plotting[,name],  # Subset the desired set
              col= vc_colors[i],   # Choose the color from the color vector
              type="l"
        )
        vc_names <- c(vc_names, name)   # Append the set name to the name vector
    }
    
    ## Create the legend from "color" and "names" vectors
    legend("topright",
           lty=1, 
           col=vc_colors, 
           legend = vc_names)
    
    
}

plotnumber=3


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