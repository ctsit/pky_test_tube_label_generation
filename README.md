# PK Yonge Roster and Test Kit Label Generation

This project provides data products in support of the PK Yonge COVID-19 Testing project at the University of Florida. The data products are created via R Scripts.

## Prerequisites

This script uses R and these R packages:

    tidyverse
    dotenv
    REDCapR
    sendmailR
    lubridate
    baRcodeR
    dotenv
    devtools

## Setup and Configuration

This script is configured entirely via the environment. An example `.env` file is provided as [`env.example`](env.example). To use this file, copy it to the name `.env` and customize according to your project needs. Follow these steps to build the required components and configure the script's `.env` file.

1. Create the REDCap project from [`PKYongeCOVID19Timepo_2021-04-20_1230.REDCap.xml`](https://github.com/ctsit/pky_test_tube_label_generation/blob/main/PKYongeCOVID19Timepo_2021-04-20_1230.REDCap.xml). 
1. Give a user User Rights of _Full Data Set_ for _Data Exports_
1. The user will need an API key for the project.
1. Add the API key to the .env file.
1. Set `TIME_ZONE` to assure that time stamps used in the file names and the email are accurate.
1. Revise the `EMAIL_*` and `SMTP_SERVER` settings to reflect your local needs.

### baRcodeR

ROpensci maintains the library package baRcodeR. Collaboration in April of 2020 helped a COVID testing project use extended features to add additional human readable text under the barcode label used for tube labels. The extended feature has not been released into production so installing baRcodeR requires a command to install the patched version of baRcodeR to work with the label_generation.r script. The command to install baRcodeR 0.1.6 in RStudio is:

`devtools::install_github("https://github.com/ropensci/baRcodeR/tree/maelle-patch-1")`

*note if you get a package failed to install with non-zero exit status in RStudio, set the following `Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS="true")` 

## Running the R script

The primary script is [`label_generation.R`](label_generation.R). It can be run at the command line or in RStudio. In each case the script will read its configuration from the `.env` file.

The output of the script will create a directory for the given date set in appt_date and output a PDF file of barcode labels for the project. 



