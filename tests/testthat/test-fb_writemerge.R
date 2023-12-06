test_that("fb_writemerge() data mask works with one id and test", {

  dfs <- test_firstbeats("001A")

  manual = dfs |>
    dplyr::filter(RecordID== "001A" & Test== "PreTest") |>
    dplyr::select(filepath) |>
    unlist() |>
    merge_firstbeat()

  expect_equal(
    print(fb_writemerge(dfs, "001A", "PreTest", withr::local_tempdir())),
    manual)
})

test_that("fb_writemerge() works with df of multiple ids and tests", {

  dfs <- test_firstbeats("PreTest")

  manual = dfs |>
    dplyr::filter(RecordID== "001A" & Test== "PreTest") |>
    dplyr::select(filepath) |>
    unlist() |>
    merge_firstbeat()

  expect_equal(
    print(fb_writemerge(dfs, "001A", "PreTest", withr::local_tempdir())),
    manual)
})


test_that("fb_writemerge() works with ids not 001", {

  dfs <- test_firstbeats("PreTest")

  manual1 <- dfs |>
    dplyr::filter(RecordID== "003A" & Test== "PreTest") |>
    dplyr::select(filepath) |>
    unlist() |>
    merge_firstbeat()

  expect_equal(
    print(fb_writemerge(dfs, "003A", "PreTest", withr::local_tempdir())),
    manual1)


  manual2 <- dfs |>
    dplyr::filter(RecordID== "008A" & Test== "PreTest") |>
    dplyr::select(filepath) |>
    unlist() |>
    merge_firstbeat()

  expect_equal(print(fb_writemerge(dfs, "008A", "PreTest", withr::local_tempdir())),
               manual2)
})
