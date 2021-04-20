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

1. Create the REDCap project from [`First_Responder_COVID19.xml`](https://github.com/ctsit/fr_covidata/blob/master/example/First_Responder_COVID19.xml). 
1. Give a user User Rights of _Full Data Set_ for _Data Exports_
1. The user will need an API key for the project.
1. Add the API key to the .env file.
1. Set `TIME_ZONE` to assure that time stamps used in the file names and the email are accurate.
1. Revise the `EMAIL_*` and `SMTP_SERVER` settings to reflect your local needs.

## Running the R script

The primary script is [`label_generation.R`](label_generation.R). It can be run at the command line or in RStudio. In each case the script will read its configuration from the `.env` file.

The output of the script will create a directory for the given date set in appt_date and output a PDF file of barcode labels for the project. 



