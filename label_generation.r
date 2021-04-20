library(tidyverse)
library(sendmailR)
library(dotenv)
library(devtools)
# install dev version of baRcodeR if not previously installed
# devtools::install_github('ropensci/baRcodeR')
library(baRcodeR)
library(REDCapR)
library(lubridate)

source("functions.R")

dotenv::load_dot_env(file ='env.example')

Sys.getenv("INSTANCE")

# set the timezone
Sys.setenv(TZ = Sys.getenv("TIME_ZONE"))

# When script is run Mon-Fri appt_date is the next day
# When script is run on Sat appt_day is Monday
appt_date <- as.Date("2021-04-21")

# email credentials
email_server <- list(smtpServer = Sys.getenv("SMTP_SERVER"))
email_from <- Sys.getenv("EMAIL_FROM")
email_to <- unlist(strsplit(Sys.getenv("EMAIL_TO")," "))
email_cc <- unlist(strsplit(Sys.getenv("EMAIL_CC")," "))
email_subject <- paste(Sys.getenv("EMAIL_SUBJECT"), appt_date)

test_tube_label <- get_test_tube_label()

# create folder to store output
output_dir <- paste0("pky_covid19_", appt_date)
dir.create(output_dir, recursive = T)


  site_df <- test_tube_label %>%
    select(research_encounter_id, site_short_name, record_id, ce_firstname, ce_lastname, ce_dob)


  site_df <- test_tube_label %>%
    select(research_encounter_id, subject_id) %>%
  tibble::add_row(.,
                  subject_id = paste("Appt Date:", appt_date),
                  research_encounter_id = "Site Barcodes",
                  .before = 1) %>%
    slice(rep(1:n(), each = 4))

  library(baRcodeR)
  baRcodeR::custom_create_PDF(Labels = site_df$research_encounter_id,
                              alt_text = site_df$subject_id,
                              type = "matrix",
                              label_height = 0.3,
                              denote = c("\n","\n"),
                              Fsz = 5,
                              trunc = T,
                              y_space = 0.5,
                              ErrCorr = "Q",
                              name = paste0(output_dir, '_pky_covid_test_tube_labels_', appt_date))



# Zip the reports generated
#zipfile_name = paste0(output_dir, ".zip")
#zip(zipfile_name, output_dir)

# attach the zip file and email it
#attachment_object <- mime_part(zipfile_name, zipfile_name)
#body <- paste0("The attached files include labels to be printed for the First Responder COVID-19 project.",
#               " These labels are designed for the serum tubes and swab collection kits to be used at the collection sites.",
#               " These labels should be printed and packaged with the serum and swab kits for their respective sites.",
#               " The attached files were generated on ", now(), ".",
#               "\n\nNumber of appts for ", appt_date,": ", str_remove_all(appt_counts,"[[:punct::]]")
#)

#body_with_attachment <- list(body, attachment_object)

# send the email with the attached output file
#sendmail(from = email_from, to = email_to, cc = email_cc,
#         subject = email_subject, msg = body_with_attachment,
#         control = email_server)

# uncomment to delete output once on tools4
# unlink(zipfile_name, recursive = T)
# unlink(output_dir, recursive = T)
