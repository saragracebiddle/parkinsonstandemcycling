
# get the file names for all first beat files using
# helper function `get_firstbeat()` defined in utils.R
fbs <- get_firstbeat()

# select file names that are .txt files
# .sdf files were directly uploaded into Kubios
# but data samples that got split up into multiple .sdf files
# were exported as .txt files in order to be merged together into
# a single file and uploaded into Kubios as one file
fbs <- fbs[get_firstbeat() |> stringr::str_detect('.txt')]

# get RecordIDs from file names
RecordIDs = stringr::str_extract(fbs, pattern =  "\\d{3}(A|B)")

# get which test from tile names
Tests = stringr::str_extract(fbs, pattern = "P(?:(re)|(ost))Test")

# get the full file path for each
paths <- purrr::map(
  fbs,
  \(f) fs::path_package(
    "data-raw/First Beat",
    f,
    package = "parkinsonstandemcycling")
) |> unlist()

names = stringr::str_sub(fbs, start = 1L, end = -5L)

# create a data frame with the file path, record id, and test
dfs <- data.frame(
  filepath = paths,
  RecordID = RecordIDs,
  Test = Tests,
  filename = names
)

un <- dfs |>
  dplyr::select(RecordID, Test) |>
  dplyr::distinct()


fb_writemerge(
  dfs, "001A", "PreTest",
  fs::path_package("data-raw/First Beat", package="parkinsonstandemcycling")
)
fb_writemerge(
  dfs, "001B", "PostTest",
  fs::path_package("data-raw/First Beat", package="parkinsonstandemcycling")
)
fb_writemerge(
  dfs, "001B", "PreTest",
  fs::path_package("data-raw/First Beat", package="parkinsonstandemcycling")
)
fb_writemerge(
  dfs, "003A", "PreTest",
  fs::path_package("data-raw/First Beat", package="parkinsonstandemcycling")
)
fb_writemerge(
  dfs, "004A", "PostTest",
  fs::path_package("data-raw/First Beat", package="parkinsonstandemcycling")
)
fb_writemerge(
  dfs, "007A", "PostTest",
  fs::path_package("data-raw/First Beat", package="parkinsonstandemcycling")
)
fb_writemerge(
  dfs, "008A", "PreTest",
  fs::path_package("data-raw/First Beat", package="parkinsonstandemcycling")
)
fb_writemerge(
  dfs, "008B", "PreTest",
  fs::path_package("data-raw/First Beat", package="parkinsonstandemcycling")
)
fb_writemerge(
  dfs, "009B", "PostTest",
  fs::path_package("data-raw/First Beat", package="parkinsonstandemcycling")
)
fb_writemerge(
  dfs, "010A", "PostTest",
  fs::path_package("data-raw/First Beat", package="parkinsonstandemcycling")
)
fb_writemerge(
    dfs, "010A", "PreTest",
    fs::path_package("data-raw/First Beat", package="parkinsonstandemcycling")
)

