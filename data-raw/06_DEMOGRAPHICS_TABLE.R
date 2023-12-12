# Prepare Gender data in a readable way
pretty_gender <- demdata1 |>
  dplyr::select(Role, Gender) |>
  dplyr::summarise(count = dplyr::n(),
                   .by = c(Role, Gender)) |>
  dplyr::mutate(sum = sum(count),
                .by = Role) |>
  dplyr::mutate(meansd= paste0(
    count, ' (', round((count/sum)*100, 2), '% )'
  ))|>
  dplyr::arrange(Role, Gender)|>
  dplyr::mutate(var = factor(Gender, levels = c("F", "M"),
                             labels = c("Female", "Male"))) |>
  dplyr::mutate(mediqr = " ") |>
  dplyr::select("Role", "var", "meansd", "mediqr")

pretty_education <- demdata1 |>
  dplyr::select(Role, RecordID, Age, 'Years of Education') |>
  tidyr::pivot_longer(cols = c('Age','Years of Education'),
                      names_to = 'var',
                      values_to = 'value') |>
  dplyr::group_by(var, Role) |>
  dplyr::summarise(
    meansd = paste0(
      round(mean(value, na.rm = T), digits = 2), ' (',
      round(sd(value, na.rm = T), digits = 2), ')' ),
    mediqr = paste0(
      round(median(value, na.rm = T),digits = 2), ' (',
      round(IQR(value, na.rm = T),digits = 2), ')' )
  ) |>
  dplyr::ungroup()|>
  dplyr::select(Role,var, meansd, mediqr)

pretty_demdata2 <- demdata2 |>
  dplyr::mutate(CD = as.numeric(CD),
                LD = as.numeric(LD))|>
  tidyr::pivot_longer(cols = c('Age at Dx', 'Years of PD','HoenandYahr', 'CD',"LD"),
                      names_to = 'var',
                      values_to = 'value') |>
  dplyr::group_by(var) |>
  dplyr::summarise(
    meansd = paste0(
      round(mean(value), digits = 2), ' (',
      round(sd(value), digits = 2), ')' ),
    mediqr = paste0(
      round(median(value),digits = 2), ' (',
      round(IQR(value),digits = 2), ')' )
  ) |>
  data.table::transpose(make.names = 'var') |>
  dplyr::mutate('CDLD' = paste0(CD, ' - ', LD)) |>
  dplyr::select('Age at Dx', 'HoenandYahr', 'Years of PD', 'CDLD')|>
  data.table::transpose(keep.names = 'var') |>
  dplyr::rename('meansd' = 'V1', 'mediqr' = 'V2')|>
  dplyr::select(var, meansd, mediqr) |>
  dplyr::mutate(Role = "PD Patient")

demographicsTable <- rbind(rbind(pretty_gender, pretty_education), pretty_demdata2) |>
  dplyr::arrange(Role, var)|>
  dplyr::mutate(
    var = factor(var,
                 levels = c("Male",
                            "Female",
                            "Age",
                            "Years of Education",
                            "Age at Dx",
                            "HoenandYahr",
                            "Years of PD",
                            "CDLD" ),
                 labels = c("Male (n, %)", "Female (n, %)", "Age (years)",
                            "Education (years)", "Age of PD Onset (years)",
                            "Hoen & Yahr Score",
                            "Symptom Duration (years)",
                            "Carbidopa-Levidopa Dose (mg/day)"))
  )

usethis::use_data(demographicsTable,
                  overwrite = T)

# remove everything from the environment
rm(list = ls())
