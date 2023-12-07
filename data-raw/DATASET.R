## code to prepare `DATASET` dataset goes here
#list of all ordinal scales used in the surveys
#each scale is uniquely named
lookupordinals <- list(
  posbool = c('Yes' = 1,
              'No' = 0),

  negbool = c('Yes' = 0,
              'No' = 1),

  posagree = c('Strongly agree' = 5,
               'Strongly Agree' = 5,
               'Agree' = 4,
               'Neutral' = 3,
               'Disagree' = 2,
               'Strongly disagree' = 1,
               'Strongly Disagree' = 1),

  negagree = c('Strongly agree' = 1,
               'Strongly Agree' = 1,
               'Agree' = 2,
               'Neutral' = 3,
               'Disagree' = 4,
               'Strongly disagree' = 5,
               'Strongly Disagree' = 5),

  agreelevels = c('Always Agree' =5,
                  'Almost Always Agree' =4,
                  'Occasionally Agree' =3,
                  'Frequently Disagree' =2,
                  'Almost Always Disagree' =1,
                  'Always Disagree' =0),

  difficultylevels = c('Without any difficulty' =5,
                       'With a little difficulty' =4,
                       'With some difficulty' =3,
                       'With much difficulty' =2,
                       'Unable to do'=1),

  howoftenfivepoint = c('Never' =1,
                        'Rarely'=2,
                        'Sometimes'=3,
                        'Often'=4,
                        'Always'=5),

  howoftenfivepointusual = c('Never' =5,
                             'Rarely' =4,
                             'Sometimes' =3,
                             'Often' =2,
                             'Always' =1),

  howmuchfivepoint = c('Not at all' =1,
                       'A little bit'=2,
                       'Somewhat'=3,
                       'Quite a bit'=4,
                       'Very much'=5),

  howmuchfivepointreverse = c('Not at all' = 5,
                              'A little bit' = 4,
                              'Somewhat' = 3,
                              'Quite a bit' = 2,
                              'Very much' =1),

  howoftensixpoint =c('Never'=5,
                      'Rarely'=4,
                      'Occasionally'=3,
                      'More often than not'=2,
                      'Most of the time' =1,
                      'All the time' =0),

  howofteninaweek = c('Never'=0,
                      'Rarely'=1,
                      'Occasionally'=2,
                      'Almost everyday' =3,
                      'Almost Everyday' =3,
                      'Everyday' =4),

  howofteninamonth = c('Never' =0,
                       'Less than once a month'=1,
                       'Once or twice a month'=2,
                       'Once or twice a week'=3,
                       'Once a day'=4,
                       'More often'=5),

  gadseven = c('Not at all sure' =0,
               'Several days'=1,
               'Over half the days'=2,
               'Nearly every day'=3),

  gadeight =c('Not difficult at all' = 0,
              'Somewhat difficult' =1,
              'Very difficult'=2,
              'Extremely difficult' =3),

  copingamount = c("I haven't been doing this at all" =1,
                   "A little bit" =2,
                   "A medium amount" =3,
                   "I've been doing this a lot"=4),

  sleepquality =c('Very poor' = 1,
                  'Poor' = 2,
                  'Fair'=3,
                  'Good'=4,
                  'Very good' =5),

  pdqlevels = c('Never' = 0,
                'Occasionally' =1,
                'Sometimes' =2,
                'Often' =3,
                'Always' =4,
                'Always or cannot do at all' = 4),

  painlevels = c('No pain' =0,'1'=1,'2'=2,'3'=3,'4'=4,'5'=5,'6'=6,'7'=7,'8'=8,'9'=9)
)

#which surveys use which scoring methods
lookupmethods <- list(
  'BC' = 'mean',
  'RDA' = 'sum_rm',
  'PROMIS' = 'sum_no_na',
  'BRS' = 'mean',
  'PDQ39' = 'perc',
  'GD' = 'sum_rm',
  'GAD7'= 'sum_rm'
)


dimsbysurvey <- list(
  'BC' = c('Active Coping','Use of Informational Support','Positive Reframing',
           'Planning','Emotional Support','Venting','Humor','Acceptance',
           'Religion','Self-blame','Self-distraction','Denial',
           'Substance Use','Behavioral Disengagement',
           'Problem-Focused Coping','Emotion-Focused Coping',
           'Avoidant Coping',
           'Problem-Focused Coping-Partial','Emotion-Focused Coping-Partial'),
  'RDA' = c('Decision Making','Values','Affection','Stability','Conflict',
            'Activities','Discussion','Consensus','Satisfaction','Cohesion',
            'Total Score RDAS'),
  'PROMIS' = c('Physical Function','Anxiety','Depression',
               'Sleep Disturbance','Fatigue','Social Participation', 'Pain Interference'),
  'PDQ39' = c('Mobility','Activities of Daily Living',
              'Emotional Well Being','Stigma',
              'Social Support','Cognition','Communication',
              'Bodily Discomfort'),
  'BRS' = c('Total Score BRS'),
  'GD'= c('Total Score GDS'),
  'GAD7' = c('Total Score GAD-7')
)


#list of named dimensions for surveys
#with corresponding items
dimensions <- list(
  'Active Coping' = c(2,7),
  'Use of Informational Support' = c(10,23),
  'Positive Reframing' =c(12,17),
  'Planning' =c(14,25),
  'Emotional Support' =c(5,15),
  'Venting' =c(9,21),
  'Humor' =c(18,28),
  'Acceptance' =c(20,24),
  'Religion' =c(22,27),
  'Self-blame' =c(13,26),
  'Self-distraction' =c(1,19),
  'Denial' =c(3,8),
  'Substance Use'= c(4,11),
  'Behavioral Disengagement' =c(6,16),
  'Problem-Focused Coping' = c(2,7,10,12,14,17,23,25),
  'Emotion-Focused Coping' = c(5,9,13,15,18,20,21,22,24,26,27,28),
  'Avoidant Coping' = c(1,3,4,6,8,11,16,19),
  'Problem-Focused Coping-Partial' = c(2,7,10,12,14),
  'Emotion-Focused Coping-Partial' = c(5,9,13,15),
  'Decision Making' = c(3,6),
  'Values' = c(1,5),
  'Affection' = c(2,4),
  'Stability' = c(7,9),
  'Conflict' = c(8,10),
  'Activities' = c(11,13),
  'Discussion' = c(12,14),
  'Consensus' = seq(1,6),
  'Satisfaction' = seq(7,10),
  'Cohesion' = seq(11,14),
  'Physical Function' = seq(1,4),
  'Anxiety' = seq(5,8),
  'Depression' = seq(9,12),
  'Fatigue' = seq(13,16),
  'Sleep Disturbance' = seq(17,20),
  'Social Participation' = seq(21,24),
  'Pain Interference' = seq(25,28),
  'Mobility' = seq(1,10),
  'Activities of Daily Living' = seq(11,16),
  'Emotional Well Being' = seq(17,22),
  'Stigma' = seq(23,26),
  'Social Support' = seq(27,29),
  'Cognition' = seq(30,33),
  'Communication' = seq(34,36),
  'Bodily Discomfort' = seq(37,39),
  'Total Score BRS' = seq(1,6),
  'Total Score GDS' = seq(1,15),
  'Total Score GAD-7' = seq(1,7),
  'Total Score RDAS' = seq(1,14)
)

#list of different ways scores are evaluated
methods <- list(
  mean = function(x) mean(x, na.rm = TRUE),
  sum_rm = function(x) sum(x, na.rm = TRUE),
  sum_no_na = function(x) sum(x, na.rm = FALSE),
  perc = function(x) (sum(x) / (length(x) * 4)) * 100
)

GAD7labels <- c('Not at all', 'Several days',
                'Over half the days', 'Nearly every day')
BRlabels <- c('Strongly Disagree', 'Disagree', 'Neutral', 'Agree',
              'Strongly Agree')

PROMISlabelsA <- c('Without any difficulty', 'With a little difficulty',
                   'With some difficulty','With much difficulty',
                   'Unable to do')

PROMISlabelsB <- c('Never', 'Rarely', 'Sometimes', 'Often', 'Always')

PROMISlabelsC <- c('Not at all', 'A little bit', 'Somewhat', 'Quite a bit',
                   'Very much')

BClabels <- c('Not at all', 'A little bit','A medium amound', 'A lot')


lookupordinals <- list(
  posbool = c('Yes' = 1,
              'No' = 0),

  negbool = c('Yes' = 0,
              'No' = 1),

  posagree = c('Strongly agree' = 5,
               'Strongly Agree' = 5,
               'Agree' = 4,
               'Neutral' = 3,
               'Disagree' = 2,
               'Strongly disagree' = 1,
               'Strongly Disagree' = 1),

  negagree = c('Strongly agree' = 1,
               'Strongly Agree' = 1,
               'Agree' = 2,
               'Neutral' = 3,
               'Disagree' = 4,
               'Strongly disagree' = 5,
               'Strongly Disagree' = 5),

  agreelevels = c('Always Agree' =5,
                  'Almost Always Agree' =4,
                  'Occasionally Agree' =3,
                  'Frequently Disagree' =2,
                  'Almost Always Disagree' =1,
                  'Always Disagree' =0),

  difficultylevels = c('Without any difficulty' =5,
                       'With a little difficulty' =4,
                       'With some difficulty' =3,
                       'With much difficulty' =2,
                       'Unable to do'=1),

  howoftenfivepoint = c('Never' =1,
                        'Rarely'=2,
                        'Sometimes'=3,
                        'Often'=4,
                        'Always'=5),

  howoftenfivepointusual = c('Never' =5,
                             'Rarely' =4,
                             'Sometimes' =3,
                             'Often' =2,
                             'Always' =1),

  howmuchfivepoint = c('Not at all' =1,
                       'A little bit'=2,
                       'Somewhat'=3,
                       'Quite a bit'=4,
                       'Very much'=5),

  howmuchfivepointreverse = c('Not at all' = 5,
                              'A little bit' = 4,
                              'Somewhat' = 3,
                              'Quite a bit' = 2,
                              'Very much' =1),

  howoftensixpoint =c('Never'=5,
                      'Rarely'=4,
                      'Occasionally'=3,
                      'More often than not'=2,
                      'Most of the time' =1,
                      'All the time' =0),

  howofteninaweek = c('Never'=0,
                      'Rarely'=1,
                      'Occasionally'=2,
                      'Almost everyday' =3,
                      'Almost Everyday' =3,
                      'Everyday' =4),

  howofteninamonth = c('Never' =0,
                       'Less than once a month'=1,
                       'Once or twice a month'=2,
                       'Once or twice a week'=3,
                       'Once a day'=4,
                       'More often'=5),

  gadseven = c('Not at all sure' =0,
               'Several days'=1,
               'Over half the days'=2,
               'Nearly every day'=3),

  gadeight =c('Not difficult at all' = 0,
              'Somewhat difficult' =1,
              'Very difficult'=2,
              'Extremely difficult' =3),

  copingamount = c("I haven't been doing this at all" =1,
                   "A little bit" =2,
                   "A medium amount" =3,
                   "I've been doing this a lot"=4),

  sleepquality =c('Very poor' = 1,
                  'Poor' = 2,
                  'Fair'=3,
                  'Good'=4,
                  'Very good' =5),

  pdqlevels = c('Never' = 0,
                'Occasionally' =1,
                'Sometimes' =2,
                'Often' =3,
                'Always' =4,
                'Always or cannot do at all' = 4),

  painlevels = c('No pain' =0,'1'=1,'2'=2,'3'=3,'4'=4,'5'=5,'6'=6,'7'=7,'8'=8,'9'=9)
)


PROMIStscores <- data.frame(
  actualScore = rep(seq.int(4,20), times = 7),
  tscore = c(
    c(22.9, 26.9, 29.1, 30.7, 32.1, 33.3, 34.4, 35.6, 36.7, 37.9, 39.1, 40.4, 41.8, 43.4, 45.3, 48.0, 56.9),
    c(40.3, 48.0, 51.2, 53.7, 55.8, 57.7, 59.5, 61.4, 63.4, 65.3, 67.3, 69.3, 71.2, 73.3, 75.4, 77.9, 81.6),
    c(41.0, 49.0, 51.8, 53.9, 55.7, 57.3, 58.9, 60.5, 62.2, 63.9, 65.7, 67.5, 69.4, 71.2, 73.3, 75.7, 79.4),
    c(33.7, 39.7, 43.1, 46.0, 48.6, 51.0, 53.1, 55.1, 57.0, 58.8, 60.7, 62.7, 64.6, 66.7, 69.0, 71.6, 75.8),
    c(32.0, 37.5, 41.1, 43.8, 46.2, 48.4, 50.5, 52.4, 54.3, 56.1, 57.9, 59.8, 61.7, 63.8, 66.0, 68.8, 73.3),
    c(27.5, 31.8, 34.0, 35.7, 37.3, 38.8, 40.5, 42.3, 44.2, 46.2, 48.1, 50.0, 51.9, 53.7, 55.8, 58.3, 64.2),
    c(41.6, 49.6, 52.0, 53.9, 55.6, 57.1, 58.5, 59.9, 61.2, 62.5, 63.8, 65.2, 66.6, 68.0, 69.7, 71.6, 75.8)
    ),
  dimension = rep(c("Physical Function", "Anxiety", "Depression",
                    "Fatigue", "Sleep Disturbance", "Social Participation",
                    "Pain Interference"), each = 17)
)

usethis::use_data(lookupordinals,
                  lookupmethods,
                  dimsbysurvey,
                  dimensions,
                  methods,
                  PROMIStscores,
                  overwrite = TRUE,
                  internal = TRUE)

rm(dimensions, dimsbysurvey, lookupmethods, lookupordinals, methods)

