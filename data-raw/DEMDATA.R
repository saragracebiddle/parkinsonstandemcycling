# Read in first table of demographics data
# which has RecordIDs, gender, age, and years of education
demdata1 <- readr::read_csv(
  read_studydata("demographics_data.csv")
) |>
  dplyr::rename("RecordID" = "ID")

# Read in second table of demographics data
# which applies only to participants with Parkinson's Disease
# and rename columns to match other tables
demdata2 <- readr::read_csv(
  read_studydata("demographics_data_part2.csv")
) |>
  dplyr::rename(
    "RecordID" = "ID"
  )

# Split the Carbidopa/Levodopa column into two separate columns
demdata2[c('CD',"LD")] <- stringr::str_split_fixed(
  demdata2$`TOTAL Carbidopa-Levodopa Dose (mg/day)`, '-', 2)

# and dop the combined Carbidopa/Levodopa column
demdata2 <- demdata2 |>
  dplyr::select(
    "RecordID", 'Age at Dx', 'Years of PD', 'HoenandYahr', 'CD', "LD"
  )

# save
usethis::use_data(demdata1,
                  demdata2,
                  overwrite = TRUE)

# remove everything from the environment
rm(list = ls())
