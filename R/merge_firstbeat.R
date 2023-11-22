#' Merge two seperate files from a FirstBeat Heart Rate sensor
#'
#' @details When the FirstBeat is disconnected or turns off and then turns
#' back on, it creates a seperate file. The Kubios HRV Premium
#' software cannot take multiple files as input. In order to
#' analayse all the data together if the sensor created multiple
#' files during the time of measurement, the files have to be
#' merged by hand.
#'
#' The FirstBeat measures RR intervals. In order to merge the files
#' together, the function creates an RR interval that is the
#' length of time between one measurement ending and the next
#' measurement beginning.
#'
#' @param filenames list of filenames that hold the data to merge
#'
#' @return dataframe
#' @export
merge_firstbeat <- function(filenames){

  dfs <- filenames |>
    lapply(read_firstbeat)

  durations <- purrr::reduce(dfs, get_duration)

  purrr::reduce2(dfs, durations, insert_rr_interval)
}

#' Read in First Beat data and assign an attribute for starttime
#'
#' @param filename name of file of First Beat data
#'
#' @return dataframe with attribute starttime
#' @export
read_firstbeat <- function(filename){
<<<<<<< HEAD
  df <- suppressMessages(
    readr::read_csv(filename, col_names = FALSE, skip = 5)
    )
=======
  df <- utils::read_csv(filename, col_names = FALSE, skip = 5)
>>>>>>> 0043c2ca8216167e9f756e6943a516694f592d69

  attr(df, "starttime") <- str_date(filename)

  df
}

#' Get time from filenames
#'
#' @param char character string of filename
#'
#' @return lubridate datetime object
#' @export
str_date <- function(char){
  char |>
    stringr::str_extract(
      pattern = "\\d{2}_\\d{2}_\\d{4}_\\d{2}_\\d{2}_\\d{2}"
      ) |>
    lubridate::dmy_hms()
}

#' Insert an RR interval duration to join two data frames of rr data from a
#' First Beat Heart Rate sensor
#'
#' @param df1 data frame of first section of RR interval data
#' @param df2 data frame of second section of RR interval data
#' @param duration duration of gap inbetween the two sections of data
#'
#' @return data frame
#' @export
insert_rr_interval <- function(df1, df2, duration){
  rbind(df1, duration, df2)
}

#' get the duration of the break in between two data frames of First Beat RR intervals
#'
#' @param df1 data frame of first section with attribute "starttime"
#' @param df2 data frame of second section with attribute "starttime"
#'
#' @return duration in milliseconds as a double
#' @export
get_duration <- function(df1, df2){
  # create an interval with start = date-time of end of data collection for df1
  # and end = date-time of beginning of data collection for df2
  # and find the duration of the interval in milliseconds
  lubridate::interval(
    (attr(df1, "starttime") + lubridate::dmilliseconds(sum(df1$X1))),
    attr(df2, "starttime")) / lubridate::dmilliseconds()
}
