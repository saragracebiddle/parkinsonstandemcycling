test_firstbeats <- function(pattern){

  fbs <- get_firstbeat()
  fbs <- fbs[get_firstbeat() |> stringr::str_detect('.txt')]
  fbs <- fbs[stringr::str_detect(fbs, pattern)]

  RecordIDs = stringr::str_extract(fbs, pattern =  "\\d{3}(A|B)")

  Tests = stringr::str_extract(fbs, pattern = "P(?:(re)|(ost))Test")

  paths <- purrr::map(
    fbs,
    \(f) fs::path_package(
      "data-raw/First Beat",
      f,
      package = "parkinsonstandemcycling")
  ) |> unlist()

  names = stringr::str_sub(fbs, start = 1L, end = -5L)

  data.frame(
    filepath = paths,
    RecordID = RecordIDs,
    Test = Tests,
    filename = names
  )
}
