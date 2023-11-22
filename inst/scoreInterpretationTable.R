scoreInterpretationTable <- interpret_scores |>
  dplyr::filter(survey %in% c("GD", "GAD7", "RDA", "MOCA", "BRS")) |>
  dplyr::filter(Test != "Difference") |>
  dplyr::mutate(survey = factor(
    survey,
    levels = c("GAD7", "GD", "RDA", "MOCA", "BRS"),
    labels = c("GAD-7", "GDS", "RDAS", "MoCA", "BRS")
  ),
  Interpretation = factor(
    Interpretation,
    levels = c("Minimal Anxiety", "Mild Anxiety", "Moderate Anxiety",
               "Normal", "Mild Depression", "Severe Depression",
               "Non-Distress", "Distress",
               "Impaired", "High Resilience", "Normal Resilience",
               "Low Resilience")
  )) |>
  dplyr::group_by(Role, Test, survey, Interpretation) |>
  dplyr::summarise(n = dplyr::n()) |>
  tidyr::pivot_wider(id_cols = c(survey, Interpretation),
                     names_from = c(Role, Test),
                     values_from = n) |>
  dplyr::arrange(survey, Interpretation) |>
  dplyr::rename("Instrument" = survey,
                "CP_PreTest" = CP_1,
                "CP_PostTest" = CP_2,
                "PwP_PreTest" = PwP_1,
                "PwP_PostTest" = PwP_2)

usethis::use_data(scoreInterpretationTable,
                  overwrite = T)

rm(list = ls())
