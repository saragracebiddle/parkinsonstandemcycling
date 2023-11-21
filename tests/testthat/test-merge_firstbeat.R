test_that("str_date works", {
  res <- str_date("First_Beat_001A_25_09_2021_11_04_54")

  expect_true(lubridate::is.POSIXct(res))
  expect_true(lubridate::is.POSIXt(res))


  expect_equal(res, lubridate::ymd_hms("2021-09-25 11:04:54"))
  test_names <- c(
    "First_Beat_001A_25_09_2021_11_04_54",
    "First_Beat_001B_26_09_2021_18_09_13_text"
  )

  expect_equal(
    str_date(test_names), c(lubridate::ymd_hms("2021-09-25 11:04:54"),
                            lubridate::ymd_hms("2021-09-26 18:09:13")
  ))
})

test_that("get_durations works", {

  # \\TODO
})


