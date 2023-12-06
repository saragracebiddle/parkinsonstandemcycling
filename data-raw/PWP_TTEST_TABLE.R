fga_ttests <- fga |>
  dplyr::filter(Test == 'Difference') |>
  dplyr::group_by(Instrument)|>
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
    dimension = ""
  )



table <- rbind(fga_ttests, dimension_ttests |>
                 dplyr::filter(Role == "PwP") |>
                 dplyr::ungroup()|>
                 dplyr::select(!Role))

pwpTtestTable <- table |>
  dplyr::mutate(
    `95% CI` = stringr::str_c("(", conflow, ", ", confhigh, ")")
  ) |>
  dplyr::select(
    Instrument, dimension, mean, se, `95% CI`, p, t, df
  ) |>
  dplyr::rename(
    "Mean Difference" = mean,
    "Std.Err." = se,
    "p-value" = p
  )

usethis::use_data(pwpTtestTable, overwrite = T)
