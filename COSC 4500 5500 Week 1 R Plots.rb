#!/usr/bin/env ruby
##Marquette University
##COSC 4500/5500
##Walter Bialkowski, PhD, MS
##walter.bialkowski@marquette.edu
##Week One: Dotplot, Bar Graph, Stem-and-Leaf Plot, Histogram

r_script_lines = []

##clear your working directory
r_script_lines << "rm(list=ls())"
##install packages
##this only needs to be done once
r_script_lines << "if (!requireNamespace('readxl', quietly = TRUE)) install.packages('readxl')"
r_script_lines << "if (!requireNamespace('ggplot2', quietly = TRUE)) install.packages('ggplot2')"
##load libraries
##this needs to be done at the beginning of each new session
r_script_lines << "library('readxl')"
r_script_lines << "library('ggplot2')"
##go to https://ggplot2.tidyverse.org/ for an introduction to ggplot2

##bring the file I sent you into your working directory
##you will call the import "data" for the purposes of this exercise
##e.g. data<-read.table("C://COSC 4500 5500 Week 1 Excel File.csv", header=TRUE, sep=",")
excel_path = File.expand_path("COSC 4500 5500 Week 1 Excel File.xlsx", __dir__)
excel_path_r = excel_path.gsub("\\", "/")
r_script_lines << "data<-read_excel(\"#{excel_path_r}\")"
###command R to show you the names of all of your variables (column names)
r_script_lines << "names(data)"
###command R to show you the structure of the 'data' object
r_script_lines << "str(data)"
###create a summary table of all variables in 'data'
r_script_lines << "summary(data)"
##What is the mean age?
r_script_lines << "mean_age <- mean(data$AGE, na.rm = TRUE)"
r_script_lines << "mean_age"
##What is the median age? 
r_script_lines << "median_age <- median(data$AGE, na.rm = TRUE)"
r_script_lines << "median_age"
##If mean and median are very close, what does that tell you about the distribution?
r_script_lines << "if (isTRUE(all.equal(mean_age, median_age, tolerance = 0.1))) message('Mean and median are close; the distribution appears roughly symmetric.') else message('Mean and median differ; the distribution may be skewed.')"

##DOT PLOT
##best with small data sets
##data must fall into discrete "bins" or categories
##a dot is placed for each observation 
##note: your goal is to visualize one series of data (e.g. AGE)
##in R, you need to define where in your working directory you're pulling from
##'data' defines the data frame from which you're pulling 'AGE' data'
##think of the '$' as a 'then' statement
r_script_lines << "dot_plot_age_weight <- ggplot(data, aes(x = AGE, y = WEIGHT)) +"
r_script_lines << "  geom_point() +"
r_script_lines << "  labs(x = 'Age', y = 'Weight', title = 'Dot Plot of Age vs Weight')"
r_script_lines << "png('dotplot_age_weight.png')"
r_script_lines << "print(dot_plot_age_weight)"
r_script_lines << "dev.off()"
##create a scatter-style dot plot of age versus weight using ggplot
##this defines the visualization so it can be reused and saved to a file
##open a PNG device, render the plot to the image, then close the device to write the file

##STEM AND LEAF PLOT
##ideal for small-to-moderate data sets
##this is technically a table
##but if rotated 90 degrees counterclockwise, it is a histogram
##'stems' represent the first digit (or digits) in a number
##'leaves' represent each of the last digits
##multiple observations of the same value will be graphed multiple times
r_script_lines << "stem_leaf_weight_output <- capture.output(stem(data$WEIGHT))"
r_script_lines << "png('stem_leaf_weight.png', width = 800, height = 600)"
r_script_lines << "plot.new()"
r_script_lines << "text(0, 1, paste(stem_leaf_weight_output, collapse = '\\n'), adj = c(0, 1))"
r_script_lines << "dev.off()"
##capture the stem-and-leaf table output for weight as text so it can be drawn to an image
##open a blank plotting canvas, draw the captured text, and save it as a PNG

##HISTOGRAM
##ideal for studying distributions of data derived from moderate-to-large data sets
##bar height corresponds to the number of observations within a 'bin'
##or category
##here, we are letting R create a default histogram
r_script_lines << "histogram_age_weight_plot <- ggplot(data, aes(x = AGE, weight = WEIGHT)) +"
r_script_lines << "  geom_histogram(bins = 10) +"
r_script_lines << "  labs(x = 'Age', y = 'Weighted Count', title = 'Histogram of Age (Weighted by Weight)')"
r_script_lines << "png('histogram_age_weight.png')"
r_script_lines << "print(histogram_age_weight_plot)"
r_script_lines << "dev.off()"
##build a histogram of age with weights so bar heights reflect summed weights per age bin
##write the histogram to a PNG file for sharing outside the R session

r_script_path = File.join(Dir.pwd, "generated_plots.R")
File.write(r_script_path, r_script_lines.join("\n"))
rscript_command = ENV.fetch("RSCRIPT", "Rscript")
unless system("which", rscript_command, out: File::NULL, err: File::NULL)
  abort("Rscript was not found. Install R or set RSCRIPT to the Rscript executable.")
end
unless system(rscript_command, r_script_path)
  abort("Rscript failed to run the generated plotting script.")
end
##write the generated R instructions to a file and call Rscript to execute them
##ensure Rscript is available (or provided via RSCRIPT) before running the plots
