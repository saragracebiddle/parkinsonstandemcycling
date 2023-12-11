hrv <- readxl::read_xlsx(read_studydata("Kubios_Results_24_hr.xlsx")) |>
  data.table::setDT()|>
  data.table::melt(id.vars = c("variable"),
       variable.name = "id",
       value.name = "value")

hrv2 <- hrv[variable %in% c(
  "Mean RR  (ms):",
  "Mean HR (beats/min):",
  "SDNN (ms):",
  "RMSSD (ms):",
  "NNxx (beats):",
  "pNNxx (%):",
  "LF (ms^2):",
  "HF (ms^2):",
  "Total power (ms^2)",
  "SD1 (ms):",
  "SD2 (ms):"
)][, `:=` (
  ID = stringr::str_split_i(id,
                            pattern = "[:space:]",
                            i = 1),
  test = stringr::str_split_i(id,
                              pattern = "[:space:]",
                              i = 2),
  day = stringr::str_sub(id, start = stringr::str_length(id),
                         end = stringr::str_length(id)),
  value = as.numeric(value)
)][ID != "1a", mean(value), by = .(ID, test, variable)]

hrv3 <- hrv2 |>
  data.table::dcast(ID + variable ~ test, value.var = "V1")

hrv3[, diff := post-pre][, role := data.table::fcase(stringr::str_detect(ID, "a"), "PD Patient",
                                                     stringr::str_detect(ID, "b"), "Care Partner")]

hrv24hr = hrv3[variable %in% c("Mean RR  (ms):",
                     "SDNN (ms):",
                     "Mean HR (beats/min):",
                     "RMSSD (ms):",
                     "pNNxx (%):")] |>
  dplyr::mutate(variable = factor(variable,
                                  levels = c(
                                    "Mean HR (beats/min):",
                                    "Mean RR  (ms):",
                                    "RMSSD (ms):",
                                    "SDNN (ms):",
                                    "pNNxx (%):")),
                role = factor(role,
                              levels = c(
                                "Care Partner",
                                "PD Patient"
                              ),
                              labels = c(
                                "CP",
                                "PwPD"
                              ))) |>
  dplyr::rename(
    "RecordID" = ID,
    "Role" = role,
    "PostTest" = post,
    "PreTest" = pre,
    "Difference" = diff,
    "dimension" = variable
  ) |>
  tidyr::pivot_longer(
    cols = c("PreTest", "PostTest", "Difference"),
    names_to = "Test",
    values_to = "Value"
  )

usethis::use_data(hrv24hr,
                  overwrite = T)

rm(list = ls())
