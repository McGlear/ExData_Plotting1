################################################
####............Utility Script..............####
####                                        ####
#### SHOULD NOT BE SOURCED DIRECTLY BUT     #### 
####     FROM THE PLOTTING SCRIPTS!         ####
################################################



## This script contains functions and packages
## that are required by all the plot_n.R files
## To avoid multiple loading it has a
## C++ like "Header Guard" variable

utils_loaded = TRUE

## Ensure English labels
Sys.setlocale("LC_TIME", "English")


## Requirements
require (lubridate)     ## Dates and times
require (dplyr)         ## Extends data.table functionality
require (png)           ## Opening png file devices
require (grid)          ## Viewport Management for viewing rendered png


#####################################################################
## make.plot1 is the main Function. Call it to run the script!
## Takes a "file" argument (path and name of the data file) and the
##  boolean "reload" - the dataset is very big, so the script will
##  load the data only if necessary (first run) 
##  or if asked to (reload=TRUE)
## Function can only be called, when one of the "plot_n.R" scripts
##  is sourced! The plotting function "own_plot" is only supplied
##  in those scripts!
#####################################################################

make.plot <- function(file="Data/household_power_consumption.txt", 
                       reload=FALSE){

    ## Clear screen
    grid.clear()
    
    ################################################
    ####                                        ####
    #### Is the function call valid?            ####
    ####                                        ####
    ################################################
    
    if (!exists("plotnumber")){     # Is a plotting script sourced?
        stop("Please source a plotting script and run make.plot() from there!")
    }
    
    
    
    
    ################################################
    ####                                        ####
    #### Load the data or use stored?           ####
    ####                                        ####
    ################################################
     
    if (reload==TRUE || !exists("df_february")){
        print("Loading Data")
        df_february <<-load_and_subset(file=file)
        print("Data loaded successfully")
    }    
    
    ################################################
    ####                                        ####
    #### Create the plot within a png device    ####
    ####                                        ####
    ################################################
    
    png(filename = paste("plot", plotnumber,".png", sep=""),
        width = 480, height = 480, units = "px", pointsize = 12,
        bg = "transparent", type="cairo")  # type="cairo" makes thinner lines
    
      own_plot()

    
    dev.off()
    
    
    ################################################
    ####                                        ####
    ####            Preview png file -          ####
    ####        for debugging convenience       ####
    ####                                        ####
    ################################################
    

    ######## 
    img <- readPNG(paste("plot", plotnumber, ".png", sep=""))
    grid::grid.raster(img)

    
}




#####################################################################
## load_and_subset is called from make.plot when necessary.
## The "file" argument is passed from make.plot's file argument
#####################################################################
load_and_subset <- function (file) {
    
    df_raw <- read.table(file, header=TRUE, sep=";", na.strings="?") ## read
    df_raw <- mutate(df_raw, DateTime = paste(Date, Time))
    df_raw <- mutate(df_raw, 
                     DateTime = parse_date_time(DateTime, "%d%m%y %H%M%S"))
    df_raw <- mutate(df_raw, Date=dmy(Date), Time=hms(Time)) ## make POSIX
    
    df_subset <- df_raw[df_raw$Date==ymd("2007-02-01") | ## Subset by date
                        df_raw$Date==ymd("2007-02-02"), ]
    
    return(df_subset) ## return the data.frame 
    ##Can't use data.table, as it does not support date formats :(
}


#####################################################################
## Clear Screen function
#####################################################################

grid.clear <- function() {
    grid.rect(c(0,1),c(0,1),just=c("left","bottom"), gp=gpar(fill="white"))
}