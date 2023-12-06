#' Survey Data from Tandem Cycling Parkinson's Disease Study
#'
#' Patients with Parkinson's Disease and their care partners completed this
#' 8 week tandem cycling intervention. Patients and their care partners
#' completed these surveys before and after the intervention.
#'
#' Data was recorded in RedCap and exported upon study completion.
#' The de-identified raw data from RedCap is in the 'data-raw' folder.
#' Cleaning and processing the data is documented in 'data-raw/SURVEYDATA.r'
#'
#' @format ## `survey_data`
#' A data frame with 4726 rows and 7 columns:
#' \describe{
#'    \item{RecordID}{Participant ID}
#'    \item{Role}{Care Partner or PD Patient}
#'    \item{Test}{Pre Testing or Post Testing}
#'    \item{Instrument}{Survey ID:
#'    BC -Brief Cope,
#'    BRS - Brief Resilience Scale,
#'    GAD7 -General Anxiety Disorder 7 Item,
#'    GD -Geriatric Depression Scale,
#'    PDQ39 - Parkinson's Disease Questionnaire 29 Items,
#'    PROMIS - PROMIS Global Health,
#'    RDA- Revised Dyadic Adjustment Scale
#'    }
#'    \item{ItemNum}{Item Number of the survey}
#'    \item{Answer}{Item Answer}
#'    \item{Value}{Scored Value of the Answer}
#' }
"survey_data"

#' Scored Survey Dimensions from Tandem Cycling Parkinson's Disease Study
#'
#' @format ##`dimension_scores`
#' A data frame with 1632 rows and 6 columns:
#' \describe{
#'     \item{RecordID}{Participant ID}
#'     \item{Role}{Care Partner or PD Patient}
#'     \item{Test}{Pre Test or Post Test}
#'     \item{Instrument}{Instrument ID: one of
#'     BC -Brief Cope,
#'     BRS - Brief Resilience Scale,
#'     GAD7 -General Anxiety Disorder 7 Item,
#'     GD -Geriatric Depression Scale,
#'     PDQ39 - Parkinson's Disease Questionnaire 29 Items,
#'     PROMIS - PROMIS Global Health,
#'     RDA- Revised Dyadic Adjustment Scale,
#'     MOCA -Montreal Cognitive Assessment}
#'     \item{dimension}{name of the dimension of the survey}
#'     \item{score}{Scored Value of the Dimension}
#' }
"dimension_scores"

#' Interpreted Scores for Surveys that use Interpretations
#'
#' @format ##`interpret_scores`
#' A data frame with 170 rows and 6 columns
#' \describe{
#'    \item{RecordID}{Participant ID}
#'    \item{Role}{Care Partner or PD Patient}
#'    \item{Test}{Pre Test or Post Test}
#'    \item{survey}{survey id}
#'    \item{score}{scored dimension}
#'    \item{Interpretation}{Interpretation of score}
#' }
"interpret_scores"

#' Scored PROMIS dimensions
#'
#' @format ##`interpret_promis`
#' A data frame with 357 rows and 5 columns
#' \describe{
#'    \item{RecordID}{Participant ID}
#'    \item{Role}{Care Partner or PD Patient}
#'    \item{dimension}{PROMIS dimension}
#'    \item{Test}{Pretest, Posttest, or Difference}
#'    \item{Tscore}{Tscore of actual score on the dimension}
#'}
"interpret_promis"

#' Mean and Standard Deviations of Pre and Post Test Survey Dimension Score
#'
#' @format ##`dimension_meansd`
#' A data frame with
#' 315 rows and 5 columns
#' \describe{
#'    \item{Role}{Care Partner or PD Patient}
#'    \item{dimension}{Survey Dimension}
#'    \item{Instrument}{Instrument ID}
#'    \item{Test}{Pre Test or Post Test}
#'    \item{mean}{Mean}
#'    \item{sd}{Standard Deviation}
#' }
"dimension_meansd"

#' t-test results
#'
#' @format ##`dimension_ttests`
#' A data frame with 105 rows and 10 columns
#' \describe{
#'     \item{Role}{Care Partner or PD Patient}
#'     \item{Instrument}{Instrument ID}
#'     \item{dimension}{survey dimension}
#'     \item{mean}{mean}
#'     \item{se}{Standard Error}
#'     \item{conflow}{Lower Limit of 95% Confidence Interval}
#'     \item{confhigh}{Upper Limit of 95% Confidence Interval}
#'     \item{p}{P value from Test}
#'     \item{t}{t statistic}
#'     \item{df}{Degrees of Freedom}
#' }
"dimension_ttests"

#' Demographics Data Part 1
#'
#' @format ##`demdata1`
#' A data frame with 17 rows and 5 columns
#' \describe{
#'     \item{RecordID}{Participant ID}
#'     \item{Role}{Care Partnet or PD Patient}
#'     \item{Gender}{Male or Female}
#'     \item{Years of Education}{Number of Years of Schooling the participant completed, starting in elementary and going through any college. 12 years of education is equivalent to completing a high school education.
#'     }
#'     \item{Age}{Age in Years at time of beginning of tandem cycling intervention.}
#' }
"demdata1"

#' Demographics Data Part 2
#'
#' Parkinson's Disease information, including staging and prescribed medications.
#' Not applicable for Care Partners.
#'
#' @format ##`demdata2`
#' A data frame with 9 rows and 6 columns
#' \describe{
#'     \item{RecordID}{Participant ID}
#'     \item{Age at Dx}{Age at time of Parkinson's Disease Diagnosis}
#'     \item{HoenandYahr}{Hoen and Yahr Score}
#'     \item{CD}{Prescribed dosage of Carbidopa in mg/day}
#'     \item{LD}{Prescribed dosage of Levodopa in mg/day}
#' }
"demdata2"

#' Demographics Data in a Table ready to put in a document
#'
#' Demographics of study participants
#'
#' @format ##`demographicsTable`
#' a data frame with 12 rows and 5 columns
#' \describe{
#'    \item{Role}{Care Partner or Person with Parksinson's Disease}
#'    \item{var}{Variable}
#'    \item{meansd}{mean and standard deviation formatted in character format as 'mean (sd)'}
#'    \item{mediqr}{median and IQR formatted as characters like 'median (IQR)'}
#'    \item{level}{level}
#' }
"demographicsTable"

#' Score Interpretation of Instruments
#'
#' Interpretation of participant's scores on instruments at
#' pre and post testing
#'
#' @format ##`scoreInterpretationTable`
#' a data frame with 13 rows and 6 columns
#' \describe{
#'     \item{Instrument}{Instrument ID}
#'     \item{Interpretation}{Interpretation of Score}
#'     \item{CP_PreTest}{Count of Care Partners who scored that Interpretation for PreTest}
#'     \item{CP_PostTest}{Count of Care Partners who scored that Interpretation for PostTest}
#'     \item{PwP_PreTest}{Count of Persons with Parkinson's who scored that Interpretation for PreTest}
#'     \item{PwP_PostTest}{Count of Persons with Parkinson's who scored that Interpretation for PostTest}
#' }
"scoreInterpretationTable"

#' 24 hour Heart Rate Variability Data
#'
#' Results from Kubios HRV Premium after analysing the
#' FirstBeat data from all participants
#'
#' @format ##`hrv24hour`
#' a data frame with 70 rows and 6 columns
#' \describe{
#'     \item{RecordID}{Participant Study ID}
#'     \item{variable}{Heart Rate Variabilty Variable}
#'     \item{PostTest}{value at PostTest}
#'     \item{PreTest}{value at PreTest}
#'     \item{Difference}{Difference between PreTest and PostTest}
#'     \item{Role}{Participant Role, Care Partner or Person with Parkinson's Disease}
#' }
"hrv24hr"


#' Gait Analysis Data
#'
#' @format ##`fga`
#' a data frame with 36 rows and 5 columns
#' \describe{
#'     \item{RecordID}{Participant Study ID}
#'     \item{Instrument}{Gait Analysis Instrument ID}
#'     \item{Test}{PreTest, PostTest, or Difference}
#'     \item{Value}{Value}
#' }
"fga"

#' Patients with Parkinson's Results Table
#'
#' @format ##`pwpTtestTable`
#' a data frame with 61 rows and 8 columns
#' \describe{
#'    \item{Instrument}{Instrument ID}
#'    \item{dimension}{dimension name, if applicable}
#'    \item{Mean Difference}{Mean Difference in score from PreTest to PostTest}
#'    \item{Std.Err.}{Standard Error of mean difference}
#'    \item{95% CI}{95% Confidence Interval of mean difference in score from PreTest to PostTest}
#'    \item{p-value}{pvalue from t test}
#'    \item{t}{statistic from t test}
#'    \item{df}{degrees of freedom from ttest}
#' }
"pwpTtestTable"

#' Care Partners Results Table
#'
#' @format ##`cpTtestTable`
#' a data frame with 61 rows and 8 columns
#' \describe{
#'    \item{Instrument}{Instrument ID}
#'    \item{dimension}{dimension name, if applicable}
#'    \item{Mean Difference}{Mean Difference in score from PreTest to PostTest}
#'    \item{Std.Err.}{Standard Error of mean difference}
#'    \item{95% CI}{95% Confidence Interval of mean difference in score from PreTest to PostTest}
#'    \item{p-value}{pvalue from t test}
#'    \item{t}{statistic from t test}
#'    \item{df}{degrees of freedom from ttest}
#' }
"cpTtestTable"
