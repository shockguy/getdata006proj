getdata006proj
==============
This README provides a description of the script created to satisify the 5 steps of data cleaning and wrangling needed for the class project. 
This is for the class project for the Getting and Cleaning Data course on Coursera.

It is a single script call run_analysis.R.  This is the name specified in the instructions.  The script reads in data from a motion capture study.  This data is broken up into various components that make it difficult to work with, i.e. it is not "tidy".

The script reads in all the origional data components, merges them into a single data frame, and assigns descriptive column names to each of the data columns.  For the most part the data columns use the names from the original codebook.  These could be more clearly "descriptive", but there was a desire to conform to the original names so for the sake of consistency so downstream others could work backwards to the origin of the data if necessary. Note that the data is in a directory called "dataset", which should reside in the script working directory.  I chose to "dataset" because the directory the zip created for the data was too messy for my tastes.

The script writes out 2 files using write.table. The format is CSV, which is not in the instructions, but it what I like working with, and there really is not down side, other than a few extra bytes.

The file part2_data.txt has the extracted "mean" and "std" variables, along with the activity and subject columns. Writing this out was not in the instructions for the project, but I saw no reason to create it if not to save it and use if for something.  This file has descriptive column names, and is "tidy."

The file project_upload.txt is the file requested in Step 5 of the instructions.  It is the average of all the variables of the complete data set, per activity and subject.  This columns are descriptive, having "avg-" prepended to the original variable descriptors from the original code book.

Please see the codebook.txt file for specific info on the descriptive column names for the variables and info on the origins of the data.



