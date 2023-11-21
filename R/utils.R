#' Access raw survey data
#'
#' @return filepath to read from
#' @export
read_surveydata <- function(){
  fs::path_package(
    "data-raw",
    "ParkinsonStudy_DATA_LABELS_2023-05-02_1015.csv",
    package = "parkinsonstandemcycling"
  )
}

#' Access raw demographics data
#'
#' @return filepath to read from
#' @export
read_demdata <- function(part = NULL){
  if(is.null(part)){
    fs::path_package(
      "data-raw",
      package = "parkinsonstandemcycling"
    )
  } else {
    if(part == "1"){
      fs::path_package(
        "data-raw",
        "demographics_data.csv",
        package = "parkinsonstandemcycling"
      )
    }
  }
}

#' Access Raw Data Files
#'
#' @param path name of file to access
#'
#' @return file path
#' @export
read_studydata <- function(path = NULL){
  if(is.null(path)){
    fs::path_package(
      "data-raw",
      package = "parkinsonstandemcycling"
    )
  } else {
    fs::path_package(
      "data-raw",
      path,
      package = "parkinsonstandemcycling"
    )
  }
}

#' get path to first beat raw data files
#'
#' @param path optional specific file name
#'
#' @return character string of path to file
#' @export
get_firstbeat <- function(path = NULL){
  if(is.null(path)){
    fs::path_package(
      "data-raw/First Beat",
      package = "parkinsonstandemcycling"
    ) |>
      list.files()
  } else{

    fs::path_package(
      "data-raw/First Beat",
      package = "parkinsonstandemcycling"
    )
  }
}

