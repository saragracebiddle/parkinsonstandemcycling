

cpTtestTable <- dimension_ttests |>
  dplyr::filter(Role == "CP") |>
  dplyr::ungroup()|>
  dplyr::select(!Role) |>
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

usethis::use_data(cpTtestTable, overwrite = T)
