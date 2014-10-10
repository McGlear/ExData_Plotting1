################################################
####                Make Plot 4             ####
####                                        ####
####        Call make.plot() to run!        ####
################################################


## Plotting implementation
own_plot <- function(df_plotting = df_february){
    
    par(mfrow=c(2,2))
    
############ Plot1
    plot1(df_february)

############ Plot2
    plot2(df_february)
    
############ Plot 3
    plot3(df_february)

######### Plot4
    plot4(df_february)
    
    
}

####################################
#### plot1() is same as plot2.R ####
####################################

plot1 <- function(df_plotting){
    with(df_plotting,        
         
         plot(DateTime, Global_active_power,
              main="",
              col= "#333333",
              type="l",
              ylab = "Global Active Power"
         )
    )
}


####################################
####   plot2() Implementation   ####
####################################

plot2 <- function(df_plotting){
    with(df_plotting,        
         
         plot(DateTime, Voltage,
              main="",
              col= "black",
              type="l"
         )
    )
}

####################################
#### plot3() is same as plot3.R ####
#### except for legend tweaks   ####
####################################

plot3 <- function(df_plotting){
    
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
           legend = vc_names,
           cex = 0.95,       # Smaller font
           bty ="n")        # No border

    
}


####################################
####   plot4() Implementation   ####
####################################

plot4 <- function(df_plotting){
    with(df_plotting,        
         
         plot(DateTime, Global_reactive_power,
              main="",
              col= "#333333",
              type="l",
         )
    )
}


####################################
####            SetUp           ####
####################################

plotnumber=4


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