
dims <- names(dimensions)
# score each dimension according to respective scoring instructions
# see DATASET.R for lists of scoring instructions
# see helpers.R for functions used to score dimensions
dimension_scores <- survey_data |>
  dplyr::rename("Survey" = Instrument) |>
  split(by = c('RecordID','Test')) |>
  purrr::map(map_dims) |>
  dplyr::bind_rows() |>
  dplyr::rename("Instrument" = survey)|>
  dplyr::filter(!(RecordID == "007A" & Instrument == "RDA"))

# MOCA data collected separately from other surveys and stored in different file
# read in,
# rename columns to match `dimension_scores`,
# remove `Complete?` column,
# remove RecordIDs who did not complete study,
# create new columns for dyad role (PD Patient or Care Partner)
# refactor Test,
# add other columns to match `dimension_scores`
moca_csv <- readr::read_csv(
  read_studydata("MOCA_overall.csv")
)|>
  dplyr::rename("RecordID" = "Record ID",
                "Test" = "Event Name",
                "score" = "MOCA Total Score") |>
  dplyr::select(!`Complete?`) |>
  dplyr::filter(RecordID != "002A" &
                  RecordID != "002B"&
                  RecordID != "007B") |>
  dplyr::mutate(
    Role = dplyr::case_when(
      stringr::str_detect(RecordID, 'A') ~ 'PwPD',
      stringr::str_detect(RecordID, 'B') ~ 'CP'
    ),
    Test = factor(`Test`,
                  levels = c("Pre Testing","Post Testing"),
                  labels = c(1,2)),
    Instrument = "MOCA",
    dimension = "Total Score MOCA")

# bind `dimension_scores` and `moca_csv`
# and cast `score` column to numeric
dimension_scores <- rbind(dimension_scores, moca_csv) |>
  dplyr::mutate(
    score = as.numeric(score)
  )

rm(moca_csv)

# MOCA subscores
moca_csv <- readr::read_csv(
  read_studydata("MOCA_dimensions.csv")
) |>
  dplyr::rename("RecordID" = "Patient ID") |>
  tidyr::pivot_longer(
    cols = !c('RecordID', 'Role','Test'),
    names_to = "dimension",
    values_to = "score"
  ) |>
  dplyr::filter(
    dimension != "Total" & dimension != "Redcap Score"
  )  |>
  dplyr::mutate(
    dimension = factor(
      dimension,
      levels = c('Orientation',
                 'DelayRecall',
                 'Abstraction',
                 'Language',
                 'Attention',
                 'Naming',
                 'VisuospatialExecutive'),
      labels = c('Orientation',
                 'Delay Recall',
                 'Abstraction',
                 'Language',
                 'Attention',
                 'Naming',
                 'Visuospatial/Executive')),
    Instrument = "MOCA",
    Test = factor(Test,
                  levels = c("Pretest", "Posttest"),
                  labels = c(1, 2)),
    Role = dplyr::case_when(stringr::str_detect(RecordID, "B") ~ "CP",
                            stringr::str_detect(RecordID, "A") ~ "PwPD")
  )

# bind `dimension_scores` and `moca_csv`
# and cast `score` column to numeric
dimension_scores <- rbind(dimension_scores, moca_csv) |>
  dplyr::mutate(
    score = as.numeric(score)
    )


rm(moca_csv)

# filter out dimension scores for PDQ39 survey
# which was only taken by PD patients since it was not relevant to
# Care Partners since the Care Partners did not have Parkinson's Disease
# and score the PDQ39 Summary Index
# Couldn't figure out a way to do this with the other dimensions since
# it is a mean of the other dimension scores so the other dimensions
# had to be calculated first
# add back in columns to match `dimension_scores`
pdq39summaryindex <- dimension_scores |>
  dplyr::filter(Instrument == "PDQ39" & Role == "PwPD") |>
  dplyr::group_by(RecordID, Test) |>
  dplyr::summarise(
    mean(score)
  ) |>
  dplyr::mutate(
    Instrument = "PDQ39",
    dimension = "Summary Index",
    score = `mean(score)`,
    Role = "PwPD"
  ) |>
  dplyr::select(!`mean(score)`)

# bind `dimension_score` and `pdq39summaryindex`
dimension_scores <- rbind(dimension_scores, pdq39summaryindex)

dimension_scores <- dimension_scores |>
  tidyr::pivot_wider(id_cols = c(RecordID, Role, Instrument, dimension),
                     names_from = Test,
                     values_from = score) |>
  dplyr::mutate(Difference = `2` - `1`) |>
  tidyr::pivot_longer(cols = c(`2`, `1`, Difference),
                      names_to = "Test",
                      values_to = "score") |>
  dplyr::filter(!(Instrument == "PDQ39" & Role == "CP"))


usethis::use_data(
  dimension_scores,
  overwrite = TRUE
)

rm(list = ls())
