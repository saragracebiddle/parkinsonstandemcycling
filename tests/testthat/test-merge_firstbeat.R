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

test_that("read_firstbeat works", {

  testfile <- testthat::test_path("fixtures", "First_Beat_001A_25_09_2021_11_04_54_PreTest.txt")

  expect_type(read_firstbeat(testfile), "list")

  expect_equal(attr(read_firstbeat(testfile), "starttime"),
               lubridate::ymd_hms("2021-09-25 11:04:54"))
})


test_that("get_duration works", {

  df1 <- read_firstbeat(testthat::test_path("fixtures", "First_Beat_001A_25_09_2021_11_04_54_PreTest.txt"))

  df2 <- read_firstbeat(testthat::test_path("fixtures", "First_Beat_001A_25_09_2021_18_50_45_PreTest.txt"))

  expect_equal(get_duration(df1, df2), 399962)
})

test_that("insert_rr_interval works", {
  df1 <- read_firstbeat(testthat::test_path("fixtures", "First_Beat_001A_25_09_2021_11_04_54_PreTest.txt"))

  df2 <- read_firstbeat(testthat::test_path("fixtures", "First_Beat_001A_25_09_2021_18_50_45_PreTest.txt"))

  duration <- get_duration(df1, df2)

  out <- insert_rr_interval(df1, df2, duration)

  expect_type(out, "list")

  expect_length(out$X1, length(df1$X1) + length(df2$X1) + 1)

  expect_equal(out$X1[length(df1$X1) + 1], duration)

})
