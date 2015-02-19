# cleandata README.md

///////
##Contents
This repo contains the following files:
— README.md
— codebook.txt - information about the variables and data collection.
— run_analysis.R - an R script for transforming the original dataset into this tidy form and running basic mean analysis.

##Overview
This dataset shows the results from physical activity tests using wearable mobile technology. The variables are descrbed in the codebook, but refer to numerous measures taken from sensor signals (accelerometer and gyroscope) in a smartphone when participants were performing 6 activities. The final output is a tidy dataset showing the average of all individual mean and standard deviation measurements for each of the 6 activities performed by each of the 30 participants.

##Using the data and script
Once the data is placed in the working directory, the following code will open the data in R:

  data <- read.table("./datafinal.txt", header = TRUE)

  View(data)

At which point, the accompanying R script run the analysis.

##Transformations undertaken
The script contains code to merge the training and test datasets to create a unified dataset for all participants. The measurements for mean and standard deviations for all appropriate sensor signal measurements were extracted. Activities are named. Variables are correctly labelled in accordance to the 'tidy data' principles. The final tidy dataset is created by taking the mean of all remaining measurement variables (the means and standard deviations) for each activity and each participant.


##Data collection methodology
The following provides more detailed information on the data collection methodology (Source - Human Activity Recognition Using Smartphones Dataset README)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
