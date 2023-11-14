# read in data from RedCap
# this data is the labels - not the actual values
# all answers are in word form
# names of columns are the question from the survey
# remove Record ID 007B - did not complete any of the testing/study
# remove 002A and 002B- dropped out before post testing
surveys_csv <- surveys_csv <- readr::read_csv(
  read_surveydata()
  )|>
  dplyr::filter(`Record ID` != '002A') |>
  dplyr::filter(`Record ID` != '002B') |>
  dplyr::filter(`Record ID` != '007B') |>
  data.table::setDT()


# survey labels
surveynames <- c('GD','GAD7','BRS','PROMIS','BC','RDA','PDQ39')
# number of items for each survey
numitems <- c(15,8,6,29,28,14,39)

# create vector for new column names by iterating through the
# survey labels for the length of the number of items and
# adding an extra 'Else x' name for the column from RedCap
# that indicates whether the survey was complete
listcolnames <- map(numitems |>
                      purrr::map(~c(.x,1)) |>
                      unlist(), ~ seq(from = 1, to = .x, by = 1)) |>
  purrr::map2(surveynames |>
                purrr::map(~ c(.x, 'Else')) |>
                unlist(), ~  paste(.y, .x)) |>
  unlist() |>
  append(c('RecordID','Test'), 0)

# save survey questions as a vector
Questions <- colnames(surveys_csv)

# rename columns using vector created above
colnames(surveys_csv) <- listcolnames


# create column 'Role' for which role of the dyad the participant has
# melt table longer- create a 'Item' column that holds the item # and
# 'Answer' column that holds the answer to the question
# create 'Survey' column that holds which survey the Item corresponds to
# create new column Value that holds the Value for each Answer according to
# the scoring rules for the survey
survey_data <- surveys_csv[
  ,
  Role := dplyr::case_when(
    grepl('A', RecordID) ~ 'PD Patient',
    grepl('B', RecordID) ~ 'Care Partner')
]|>
  data.table::melt(id.vars = c('RecordID', 'Test', 'Role'),
                   variable.name = 'item',
                   value.name = 'Answer') |>
  dplyr::mutate(Survey = stringr::str_split_i(item, ' ',1),
                ItemNum = as.numeric(stringr::str_split_i(item, ' ', -1)),
                Test = factor(Test, levels = c("Pre Testing", "Post Testing"))) |>
  dplyr::filter(Survey != 'Else')

# score each item on the surveys according to their respective rules
survey_data <- survey_data|>
  dplyr::mutate(Value = purrr::pmap_dbl(survey_data, pluckvalue)) |>
  dplyr::select(RecordID, Role, Test, Survey, ItemNum, Answer, Value)

# save data
usethis::use_data(
  survey_data,
  overwrite  = TRUE
)

# clean up the environment
rm(list =ls())
