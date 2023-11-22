
fbs <- get_firstbeat()
fbs <- fbs[get_firstbeat() |> stringr::str_detect('.txt')]
RecordIDs = stringr::str_extract(fbs, pattern =  "\\d{3}(A|B)")
Tests = stringr::str_extract(fbs, pattern = "P(?:(re)|(ost))Test")
paths <- purrr::map(
  fbs,
  \(f) fs::path_package(
    "data-raw/First Beat",
    f,
    package = "parkinsonstandemcycling")
) |> unlist()

dfs <- data.frame(
  filename = paths,
  RecordID = RecordIDs,
  Test = Tests
)

PreTest001A = dfs |>
  dplyr::filter(RecordID== "001A" & Test== "PreTest") |>
  dplyr::select(filename) |>
  unlist() |>
  merge_firstbeat()

PostTest001B = dfs |>
  dplyr::filter(RecordID== "001B" & Test== "PostTest") |>
  dplyr::select(filename) |>
  unlist() |>
  merge_firstbeat()

PreTest003A = dfs |>
  dplyr::filter(RecordID== "003A" & Test== "PreTest") |>
  dplyr::select(filename) |>
  unlist() |>
  merge_firstbeat()

PostTest004A = dfs |>
  dplyr::filter(RecordID== "004A" & Test== "PostTest") |>
  dplyr::select(filename) |>
  unlist() |>
  merge_firstbeat()

PostTest007A = dfs |>
  dplyr::filter(RecordID== "007A" & Test== "PostTest") |>
  dplyr::select(filename) |>
  unlist() |>
  merge_firstbeat()

PreTest008A = dfs |>
  dplyr::filter(RecordID== "0008A" & Test== "PreTest") |>
  dplyr::select(filename) |>
  unlist() |>
  merge_firstbeat()

PreTest008B = dfs |>
  dplyr::filter(RecordID== "008B" & Test== "PreTest") |>
  dplyr::select(filename) |>
  unlist() |>
  merge_firstbeat()

PostTest009B = dfs |>
  dplyr::filter(RecordID== "009B" & Test== "PostTest") |>
  dplyr::select(filename) |>
  unlist() |>
  merge_firstbeat()

PreTest010A = dfs |>
  dplyr::filter(RecordID== "010B" & Test== "PreTest") |>
  dplyr::select(filename) |>
  unlist() |>
  merge_firstbeat()

PostTest010A = dfs |>
  dplyr::filter(RecordID== "010A" & Test== "PostTest") |>
  dplyr::select(filename) |>
  unlist() |>
  merge_firstbeat()


