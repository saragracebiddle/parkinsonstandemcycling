
# get mean and standard deviations of scores grouped by
# RecordID, Role (PD Patient or Care Partner), survey, and
# survey dimension
dimension_meansd = dimension_scores |>
  dplyr::filter(!(RecordID == "004B" & Instrument == "RDA")) |>
  dplyr::filter(Instrument != "PROMIS") |>
  dplyr::group_by(Role, Test, Instrument, dimension)|>
  dplyr::summarise(
    mean = round(mean(score, na.rm = T), digits = 2),
    sd = round(sd(score, na.rm = T), digits = 2)
  )

promis_meansd = interpret_promis |>
  dplyr::group_by(Role, Test, dimension) |>
  dplyr::summarise(
    mean = round(mean(Tscore, na.rm = T), digits = 2),
    sd = round(sd(Tscore, na.rm = T), digits = 2)
  ) |>
  dplyr::mutate(
    Instrument = "PROMIS"
  )

dimension_meansd <- rbind(dimension_meansd, promis_meansd)

dimension_ttests = dimension_scores |>
  dplyr::filter(!(RecordID == "004B" & Instrument == "RDA")) |>
  dplyr::filter(Test == "Difference") |>
  dplyr::filter(Instrument != "PROMIS")|>
  dplyr::group_by(Role, Instrument, dimension) |>
  dplyr::summarise(
    mean = round(t.test(score)$estimate, digits = 2),
    se = round(t.test(score)$stderr, digits = 2),
    conflow =
      round(t.test(score)$conf.int[[1]], digits = 2),
    confhigh =
      round(t.test(score)$conf.int[[2]], digits = 2),
    p = round(t.test(score)$p.value, digits = 2),
    t = round(t.test(score)$statistic, digits = 2),
    df = t.test(score)$parameter[[1]]
  )

promis_ttests = interpret_promis |>
  dplyr::filter(Test == "Difference") |>
  dplyr::group_by(Role, dimension) |>
  dplyr::summarise(
    mean = round(t.test(Tscore)$estimate, digits = 2),
    se = round(t.test(Tscore)$stderr, digits = 2),
    conflow =
      round(t.test(Tscore)$conf.int[[1]], digits = 2),
    confhigh =
      round(t.test(Tscore)$conf.int[[2]], digits = 2),
    p = round(t.test(Tscore)$p.value, digits = 2),
    t = round(t.test(Tscore)$statistic, digits = 2),
    df = t.test(Tscore)$parameter[[1]]
  ) |>
  dplyr::mutate(
    Instrument = "PROMIS"
  )

hrv_ttests = hrv24hr |>
  dplyr::filter(Test == "Difference") |>
  dplyr::group_by(Role, dimension) |>
  dplyr::summarise(
    mean = round(t.test(Value)$estimate, digits = 2),
    se = round(t.test(Value)$stderr, digits = 2),
    conflow =
      round(t.test(Value)$conf.int[[1]], digits = 2),
    confhigh =
      round(t.test(Value)$conf.int[[2]], digits = 2),
    p = round(t.test(Value)$p.value, digits = 2),
    t = round(t.test(Value)$statistic, digits = 2),
    df = t.test(Value)$parameter[[1]]
  ) |>
  dplyr::mutate(
    Instrument = "HRV"
  )

dimension_ttests <- rbind(dimension_ttests, promis_ttests, hrv_ttests)

usethis::use_data(
  dimension_meansd,
  dimension_ttests,
  overwrite = T
)
