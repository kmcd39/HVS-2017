## if you're not running scripts in order
'aux.dir <-
  "J:/REVENUE/NEW REVENUE FOLDER/OUTSIDE DATA & REPORTS (L)/HELPER R SCRIPTS"
source(paste0(aux.dir, "/aux fcns.R"))
'
'
rm(list = ls())
occ <-
  readRDS(paste0(dest.dir,
                 "2017 hvs occupied.rds"))

vac <-
  readRDS(paste0(dest.dir,
                 "2017 hvs vacancy.rds"))

pers <-
  readRDS(paste0(dest.dir,
                 "2017 hvs person.rds"))
'
######################################################################
## do some renaming and reclassifying...
# these reassignments were determined from data dictionaries -- when import script was wonky and dd clarified
occ <- occ %>% rename(Aggregate.person.weight = Final.household.weight)
occ <- occ %>% rename(Hispanic.origin.flag = Hispanic.Origin)
occ <- occ %>% rename(Householder.hispanic.origin = Hispanic.origin)

## convert values to factors & weights to numerics
# colums with topcodes values and various flags kept as factors even if generally numeric
## weights are divided appropriately
## --(in data dictionary it specifies "5 implied decimal places")
colnames(occ)[155:156]
occ <-
  occ %>%
  mutate_at(c(1:154, 157:187),
            as.factor) %>%
  mutate_at(c(155:156, 188:267),
            list(~as.numeric(.) / 100000 ))

## convert to appropriate types
pers <- 
  pers %>% 
  mutate_at(c(1:39, 41:66),
            as.factor) %>%
  mutate_at(c(40, 67:146),
            list(~as.numeric(.) / 100000 ))

# do vacancy records too
vac <-
  vac %>%
  mutate_at(c(1:56, 58:63),
            as.factor) %>%
  mutate_at(c(57, 64:143),
            list(~as.numeric(.) / 100000 ))

# pers %>% summarise_all(class)
########################################################
## Create merged set w/ occ and pers & occ and vac
# drop rep weights from occ set because you'll be using person weights for these estimates
# this is necessary for househould data organized by ethnicity etc.
occ %>%
  select((-1 * which(colnames(occ) %in% colnames(select(pers, -Sequence.number))))) %>%
  colnames()
  
  
occ.pers <-
  left_join(pers,
            select(occ, (-1 * which(colnames(occ) %in% colnames(select(pers, -Sequence.number))))), #line is a mess but it works
            by = "Sequence.number")

#occ.vac <-
#  bind_rows(occ, vac)

########################################################
## Set up as surveys
# CAPS will indicate srvy object
# these use replicate weights and information from the HVS survey design to setup objects
# so srvyr package can automatically estimate standard errors etc.
library(srvyr)

# occupied
OCC <- as_survey_rep(occ,
                     variables = c(1:154, 157:187),
                     repweights = 188:267,
                     weights = 155,
                     scale = 4 / 80,
                     rscales = rep(1, 80),  ## 80s because there are 80 rep weights
                     combined_weights = TRUE,
                     mse = TRUE)

# persons
PERS <- as_survey_rep(pers,
                      variables = c(1:39, 41:66),
                      repweights = 67:146,
                      weights = 40,
                      scale = 4 / 80,
                      rscales = rep(1, 80),
                      combined_weights = TRUE,
                      mse = TRUE)
                      
# vacancy
VAC <- as_survey_rep(vac,
                     variables = c(1:56, 58:63),
                     repweights = 64:143,
                     weights = 57,
                     scale = 4 / 80,
                     rscales = rep(1, 80),
                     combined_weights = TRUE,
                     mse = TRUE)


OCC.PERS <- as_survey_rep(occ.pers,
                          variables = c(1:39, 42:66, 147:288, 291:319),
                          repweights = 67:146,
                          weights = 40,
                          scale = 4 / 80,
                          rscales = rep(1, 80),
                          combined_weights = TRUE,
                          mse = TRUE)


'
saveRDS(OCC,
        file = paste0(dest.dir,
                      "OCC Survey.RDS"))

saveRDS(PERS,
        file = paste0(dest.dir,
                      "PERS Survey.RDS"))

saveRDS(VAC,
        file = paste0(dest.dir,
                      "VAC Survey.RDS"))

saveRDS(OCC.PERS,
        file = paste0(dest.dir,
                      "OCC-PERS Merged.RDS"))

'