participationTable <- interpret_scores |>
  dplyr::select(RecordID, Test, Role) |>
  dplyr::filter(Test != "Difference") |>
  dplyr::distinct()|>
  dplyr::group_by(Role, Test) |>
  dplyr::summarise(n = dplyr::n()) |>
  tidyr::pivot_wider(names_from = Test,
                     values_from = n) |>
  dplyr::rename("Pre-Test" = `1`,
                "Post-Test" = `2`)

usethis::use_data(participationTable,
                  overwrite = T)

rm(list = ls())
