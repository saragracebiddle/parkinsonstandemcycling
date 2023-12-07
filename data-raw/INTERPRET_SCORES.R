interpret_scores <- dimension_scores |>
  dplyr::filter(
    Instrument %in% c("GD", "GAD7", "BRS", "RDA", "MOCA")
  ) |>
  dplyr::filter(
    dimension %in% c("Total Score RDAS", "Total Score BRS",
                     "Total Score GDS", "Total Score GAD-7",
                     "Total Score MOCA")
  ) |>
  dplyr::select(!dimension)|>
  dplyr::mutate(
    Interpretation = dplyr::case_when(
      Instrument == "GD" ~ dplyr::case_when(
        score <= 4 ~ "Normal",
        score < 9 ~ "Mild Depression",
        score < 12 ~ "Moderate Depression",
        score >= 12 ~ "Severe Depression"
      ),
      Instrument == "GAD7" ~ dplyr::case_when(
        score < 5 ~ "Minimal Anxiety",
        score <= 9 ~ "Mild Anxiety",
        score <= 14 ~ "Moderate Anxiety",
        score > 14 ~ "Severe Anxiety"
      ),
      Instrument == "RDA" ~ dplyr::case_when(
        score  < 48 ~ "Distress",
        score >= 48 ~ "Non-Distress"
      ),
      Instrument == "MOCA"  ~ dplyr::case_when(
        score >= 26 ~ "Normal",
        score < 26 ~ "Impaired"
      ),
      Instrument == "BRS" ~ dplyr::case_when(
        score < 3.0 ~ "Low Resilience",
        score <= 4.3 ~ "Normal Resilience",
        score > 4.3 ~ "High Resilience"
      )
    )
  )


interpret_promis <- dimension_scores |>
  dplyr::filter(Instrument == "PROMIS") |>
  dplyr::filter(Test != "Difference") |>
  dplyr::mutate(
    Tscore = as.numeric(purrr::pmap(list(score, dimension),
      \(s, d) promistscore(s, d, PROMIStscores)
      ))
  ) |>
  tidyr::pivot_wider(
    id_cols = c(RecordID, Role, dimension),
    names_from = Test,
    values_from = Tscore
  ) |>
  dplyr::mutate(Difference = `2` - `1`) |>
  tidyr::pivot_longer(
    cols = c(`2`, `1`, Difference),
    names_to = 'Test',
    values_to = "Tscore"
  )


usethis::use_data(interpret_scores,
                  interpret_promis,
                  overwrite = TRUE)

rm(list = ls())
