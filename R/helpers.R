#' Calculate and Display mean and standard deviation of a vector
#'
#' @param vec numeric vector
#'
#' @return string of the format 'mean (sd)'
#' @export
pretty_meansd <- function(vec){
  mean = format(
    round(
      mean(
        as.numeric(vec),
        na.rm = T),
      digits = 2),
    nsmall = 2)
  sd = format(
    round(
      sd(
        as.numeric(vec),
        na.rm = T),
      digits = 2),
    nsmall = 2)

  stringr::str_c(as.character(mean),
        " (",
        as.character(sd),
        ")")
}

#' Select the appropriate scoring for each item on each survey
#'
#' @param Survey survey id
#' @param ItemNum item number
#' @param ... additional parameters
#'
#' @return string of the name of the lookup table to use for scoring this item
#' @export
select_eval <- function(Survey, ItemNum, ...){
  switch(Survey,
         'GD' = {
           gd = c('posbool','negbool')
           gdforitems = gd[c(2,1,1,1,2,1,2,1,1,1,2,1,2,1,1)]
           f = gdforitems[ItemNum]
         },
         'BC' = {f = 'copingamount'
         },
         'BRS' = {
           br = c('posagree','negagree')
           brforitems = br[c(1,2,1,2,1,2)]
           f = brforitems[ItemNum]
         },
         'RDA' = {
           rda = c('agreelevels','howoftensixpoint','howofteninaweek','howofteninamonth')
           rdaforitems = rda[c(1,1,1,1,1,1,2,2,2,2,3,4,4,4)]
           f = rdaforitems[ItemNum]
         },
         'GAD7' = {
           gad7 = c('gadseven','gadeight')
           gad7foritems = gad7[c(1,1,1,1,1,1,1,2)]
           f = gad7foritems[ItemNum]
         },
         'PROMIS' = {
           promis = c('difficultylevels',
                      'howoftenfivepoint',
                      'howmuchfivepoint',
                      'sleepquality',
                      'howmuchfivepointreverse',
                      'howoftenfivepointusual',
                      'painlevels')
           promisforitems = promis[c(1,1,1,1,2,2,2,2,2,2,2,2,3,3,3,3,4,5,3,3,6,6,6,6,3,3,3,3,7)]
           f = promisforitems[ItemNum]
         },
         'PDQ39'= {f = 'pdqlevels'
         }
  )
  return(f)
}


#' Score the answer based on the lookup table
#'
#' @param Survey survey id
#' @param ItemNum item number
#' @param Answer answer given
#' @param ... additional parameters
#'
#' @return scored value
#' @export
pluckvalue <- function(Survey, ItemNum, Answer, ...){
  if(is.na(Answer)){
    val <- NA
  } else {
    evalfunc <- select_eval(Survey,ItemNum)
    val <- purrr::pluck(lookupordinals, evalfunc, Answer)
  }
  return(val)
}

#' Score the values using the appropriate method
#'
#' @param method scoring method
#' @param values values to score
#'
#' @return score
#' @export
score_dim <- function(method, values){
  func <- purrr::pluck(methods, method)
  score = func(values)
  return(score)
}


#' Score all dimensions
#'
#' @param splitted data frame split by survey
#' @param dimname name of the dimension
#' @param ... additional parameters
#'
#' @return named vector with the following values:
#'    RecordID = character,
#'    Role = character,
#'    Test = character,
#'    survey = character,
#'    dimension = character,
#'    score = numeric
#' @export
do_score <- function(splitted, dimname, ...){
  dimitems = c(dimensions[[dimname]])

  surveylist =
    purrr::map(
      dimsbysurvey,
      function(dimsbysurvey) dimname %in% dimsbysurvey) |>
    unlist()
  surveyname =  names(dimsbysurvey)[surveylist]

  method = purrr::pluck(lookupmethods, surveyname)

  filtered <- splitted |>
    dplyr::filter(Survey == surveyname & ItemNum %in% dimitems)
  score = score_dim(method, filtered$Value)

  c(RecordID = purrr::pluck(splitted$RecordID, 1),
    Role = purrr::pluck(splitted$Role, 1),
    Test = purrr::pluck(splitted$Test, 1),
    survey = surveyname, dimension = dimname, score = score)
}

#' purrr::map across the dimensions
#'
#' @param splitted data frame split on survey
#'
#' @return data.table
#' @export
map_dims <-function(splitted){
  purrr::map(
    dims,
    function(dimname) do_score(splitted,
      dimname = dimname)
    ) |>
    dplyr::bind_rows()
}

dim_interp <- function(dimname, ...){
  if(is.na(Answer)){
    val <- NA
  } else {
    evalfunc <- select_interp(dimname)
    val <- purrr::pluck(lookupinterp, evalfunc, Answer)
  }
  return(val)
}


#' create comparison expression for different values
#'
#' @param compare
#'
#' @return expression
#' @export
interpexp <- function(df, var){
  var <- rlang::enexpr(var)

  compare <- rlang::expr(operator(!!var, value))

  squiggle <- rlang::expr("~"(!!compare, interp))

  rlang::eval_tidy(
    rlang::enquo(squiggle), df)
}

#' Score a dimension of the PROMIS
#'
#' @param score actual score
#' @param dimname name of the dimension
#' @param df dataframe of promis scoring info
#'
#' @return tscore
#' @export
#'
#' @importFrom rlang !!
promistscore <- function(score, dimname, df){
  score = rlang::enquo(score)
  dimname = rlang::enquo(dimname)

  row = df |>
    dplyr::filter(
      dimension == !!dimname & actualScore == !!score
    )

  row$tscore |>as.numeric()
}

#' Select a parameter from a dataframe based on supplied conditions
#'
#' @param df dataframe of values to look in
#' @param cond condition to subset on
#' @param param parameter to return
#'
#' @return value
#' @export
#'
#' @importFrom rlang !!
pretty_print_val <- function(df, cond, param){
  cond = rlang:enquo(cond)
  param = rlang::enquo(param)

  row <- df |> dplyr::filter(
    !!cond
  )

  row[, !!param][[1]]
}

#' Get confidence intervals and pretty print them from data frame
#'
#' @param df data frame with t test data
#' @param survey name of survey
#' @param role role
#'
#' @return string
#' @export
pretty_confint <- function(df, survey, role, dimname = NULL){
  survey = rlang::enquo(survey)
  role = rlang::enquo(role)


  row = if(is.null(dimname)){
    df |>
      dplyr::filter(survey == !!survey & Role ==
                      !!role)
  } else {
    dimname <- rlang::enquo(dimname)
    df |>
      dplyr::filter(survey ==
                      !!survey & Role == !!role & dimension == !!dimname)
  }

  out <- stringr::str_c(
    row$conflow[[1]], " and ", row$confhigh[[1]], " points (t(", row$df[[1]], ") = ",
    row$t[[1]], ", p = ", row$p[[1]], ")."
  )

  out
}

#' merge firstbeat files of the same id and test
#'
#' @param df data frame of filepaths, ids, and tests
#' @param id id to filter by
#' @param t test to filter by
#' @param dest file destination
#'
#' @return data frame
fb_writemerge <- function(df, id, t, dest){
  ID <- rlang::enquo(id)
  TEST <- rlang::enquo(t)

  files <- df |>
    dplyr::filter(RecordID == !!ID & Test == !!t) |>
    dplyr::select(filepath) |>
    unlist()

  name = df |>
    dplyr::filter(RecordID == !!ID & Test == !!t) |>
    dplyr::select(filename) |>
    unlist()

  out = merge_firstbeat(files)

  dest = file.path(dest, paste0(name[1], '.csv'))

  write.csv(out, dest)

  invisible(out)
}
