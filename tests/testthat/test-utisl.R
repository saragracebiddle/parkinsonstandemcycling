test_that("surveydata access helper works", {

  expect_match(
    read_surveydata(),
    "/raw-data/"
  )

})
