scoreInterpretationTable <- interpret_scores |>
  dplyr::filter(Instrument %in% c("GD", "GAD7", "RDA", "MOCA", "BRS")) |>
  dplyr::filter(!(Instrument == "RDA" & RecordID == "004B")) |>
  dplyr::filter(!(Instrument == 'RDA' & RecordID == '007A'))|># removed
  dplyr::filter(Test != "Difference")|>
  dplyr::mutate(
    Instrument = factor(
      Instrument,
    levels = c("GD" , "GAD7" , "MOCA", "BRS", "RDA" ),
    labels = c("GDS", "GAD-7", "MoCA", "BRS", "RDAS")
  ),
    Interpretation = factor(
    Interpretation,
    levels = c("Minimal Anxiety", "Mild Anxiety", "Moderate Anxiety",
               "Normal", "Mild Depression", "Severe Depression",
               "Non-Distress", "Distress",
               "Impaired", "High Resilience", "Normal Resilience",
               "Low Resilience")
  )) |>
  dplyr::group_by(Role, Test, Instrument, Interpretation) |>
  dplyr::summarise(n = dplyr::n()) |>
  tidyr::pivot_wider(id_cols = c(Instrument, Interpretation),
                     names_from = c(Role, Test),
                     values_from = n) |>
  dplyr::arrange(Instrument, Interpretation) |>
  dplyr::rename("Instrument" = Instrument,
                "CP_PreTest" = CP_1,
                "CP_PostTest" = CP_2,
                "PwPD_PreTest" = PwPD_1,
                "PwPD_PostTest" = PwPD_2)

usethis::use_data(scoreInterpretationTable,
                  overwrite = T)

rm(list = ls())
