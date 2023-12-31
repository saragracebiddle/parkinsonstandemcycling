% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/merge_firstbeat.R
\name{get_duration}
\alias{get_duration}
\title{get the duration of the break in between two data frames of First Beat RR intervals}
\usage{
get_duration(df1, df2)
}
\arguments{
\item{df1}{data frame of first section with attribute "starttime"}

\item{df2}{data frame of second section with attribute "starttime"}
}
\value{
duration in milliseconds as a double
}
\description{
get the duration of the break in between two data frames of First Beat RR intervals
}
