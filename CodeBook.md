---
title: "Code Book of Clean data project"
author: "Carlos Ruiz"
date: "Monday, July 07, 2014"
output: html_document
---
The R code generates two data sets using data from wearable computing. In the experiment took part 30 people that performed 6 activities. The original data is split in test and train data and have 561 variables. The data is merged in one table and the variables are filtered and only the means and standard deviation are considered. 
The first data set has one measurement per row while the second one has the average of each measurement for each subject and each activity, so both data sets share the same variables.

The variables are the following:
subject: code of the subject
activity: type of activity done in the experiment
measurements: all this variables begins with the kind of the original variable (mean or std). Then the kind of domain variable (time or frequency) and the sensor (accelerometer or gyroscope). Data from accelerometers are split in body and gravity. The Jerk signal is also given and the magnitude of all this variables is also present in the filtered variables. All the variables but the magnitudes have different variables for each axis. All in all, we have the main variables:
- timebodyaccelerometer
- timegravityaccelerometer
- timebodyjeraccelerometer
- timebodygyroscope
- timebodyjerkgyroscope
- frequencybodyaccelerometer
- frequencybodyjerkaccelerometer
- frequencybodygyroscope
- frequencybodyjerkgyroscope
