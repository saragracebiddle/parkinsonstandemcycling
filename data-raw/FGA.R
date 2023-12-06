fga <- readxl::read_xlsx(
  fs::path_package(
    "data-raw","FGA_results.xlsx",
    package = "parkinsonstandemcycling"
    ),
  col_names = c(
    "RecordID", "Test", "TenMGS","GUG", "FGATotal","UPDRS"
    ),
  skip = 1) |>
  dplyr::filter(
    !is.na(`GUG`) & RecordID != '002A' & RecordID != '007B'
  )|>
  tidyr::pivot_longer(
    cols = c("TenMGS", "GUG", "FGATotal", "UPDRS"),
    names_to = "Instrument",
    values_to = "Value"
  ) |>
  dplyr::mutate(
    Value = ifelse(Instrument == "TenMGS",
                    10 / Value,
                    Value),
    Test = factor(Test, levels = c("Post Testing", "Pre Testing"),
                  labels = c("PostTest", "PreTest"))
  )|>
  tidyr::pivot_wider(
    id_cols = c("RecordID", "Instrument"),
    names_from = Test,
    values_from = Value
  ) |>
  dplyr::mutate(Difference = PostTest - PreTest) |>
  tidyr::pivot_longer(
    cols = c("PostTest", 'PreTest', 'Difference'),
    names_to = "Test",
    values_to = "Value"
  )


usethis::use_data(fga, overwrite = T)

rm(list = ls())
