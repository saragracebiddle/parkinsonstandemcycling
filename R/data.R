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
#'    \item{Survey}{Survey ID:
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
#' @format ## `dimension_scores`
#' A data frame with 1632 rows and 6 columns:
#' \describe{
#'     \item{RecordID}{Participant ID}
#'     \item{Role}{Care Partner or PD Patient}
#'     \item{Test}{Pre Test or Post Test}
#'     \item{Survey} {Survey ID:
#'     BC -Brief Cope,
#'     BRS - Brief Resilience Scale,
#'     GAD7 -General Anxiety Disorder 7 Item,
#'     GD -Geriatric Depression Scale,
#'     PDQ39 - Parkinson's Disease Questionnaire 29 Items,
#'     PROMIS - PROMIS Global Health,
#'     RDA- Revised Dyadic Adjustment Scale,
#'     MOCA -Montreal Cognitive Assessment
#'     }
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
#'    \item{survey}{Survey}
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
#'     \item{survey}{survey}
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
