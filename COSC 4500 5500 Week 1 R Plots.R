##Marquette University
##COSC 4500/5500
##Walter Bialkowski, PhD, MS
##walter.bialkowski@marquette.edu
##Week One: Dotplot, Bar Graph, Stem-and-Leaf Plot, Histogram

##clear your working directory
rm(list=ls())
##install packages
##this only needs to be done once
install.packages("readxl")
install.packages("ggplot2")
##load libraries
##this needs to be done at the beginning of each new session
library('readxl')
library('ggplot2')
##go to https://ggplot2.tidyverse.org/ for an introduction to ggplot2

##bring the file I sent you into your working directory
##you will call the import "data" for the purposes of this exercise
##e.g. data<-read.table("C://COSC 4500 5500 Week 1 Excel File.csv", header=TRUE, sep=",")
data<-read_excel("COSC 4500 5500 Week 1 Excel File.xlsx")
###command R to show you the names of all of your variables (column names)
names(data)
###command R to show you the structure of the 'data' object
str(data)
###create a summary table of all variables in 'data'
summary(data)
##What is the mean age?
mean_age <- mean(data$AGE, na.rm = TRUE)
mean_age
##What is the median age? 
median_age <- median(data$AGE, na.rm = TRUE)
median_age
##If mean and median are very close, what does that tell you about the distribution?
if (isTRUE(all.equal(mean_age, median_age, tolerance = 0.1))) {
  message("Mean and median are close; the distribution appears roughly symmetric.")
} else {
  message("Mean and median differ; the distribution may be skewed.")
}

##DOT PLOT
##best with small data sets
##data must fall into discrete "bins" or categories
##a dot is placed for each observation 
##note: your goal is to visualize one series of data (e.g. AGE)
##in R, you need to define where in your working directory you're pulling from
##'data' defines the data frame from which you're pulling 'AGE' data'
##think of the '$' as a 'then' statement
dot_plot_age_weight <- ggplot(data, aes(x = AGE, y = WEIGHT)) +
  geom_point() +
  labs(x = "Age", y = "Weight", title = "Dot Plot of Age vs Weight")
##create a scatter-style dot plot of age versus weight using ggplot
##this defines the visualization so it can be reused and saved to a file
png("dotplot_age_weight.png")
print(dot_plot_age_weight)
dev.off()
##open a PNG device, render the plot to the image, then close the device to write the file

##STEM AND LEAF PLOT
##ideal for small-to-moderate data sets
##this is technically a table
##but if rotated 90 degrees counterclockwise, it is a histogram
##'stems' represent the first digit (or digits) in a number
##'leaves' represent each of the last digits
##multiple observations of the same value will be graphed multiple times
stem_leaf_weight_output <- capture.output(stem(data$WEIGHT))
##capture the stem-and-leaf table output for weight as text so it can be drawn to an image
png("stem_leaf_weight.png", width = 800, height = 600)
plot.new()
text(0, 1, paste(stem_leaf_weight_output, collapse = "\n"), adj = c(0, 1))
dev.off()
##open a blank plotting canvas, draw the captured text, and save it as a PNG

##HISTOGRAM
##ideal for studying distributions of data derived from moderate-to-large data sets
##bar height corresponds to the number of observations within a 'bin'
##or category
##here, we are letting R create a default histogram
histogram_age_weight_plot <- ggplot(data, aes(x = AGE, weight = WEIGHT)) +
  geom_histogram(bins = 10) +
  labs(x = "Age", y = "Weighted Count", title = "Histogram of Age (Weighted by Weight)")
##build a histogram of age with weights so bar heights reflect summed weights per age bin
png("histogram_age_weight.png")
print(histogram_age_weight_plot)
dev.off()
##write the histogram to a PNG file for sharing outside the R session
