library(dplyr)
## this script is for ~2017~ hvs -- 2011 HVS is in 2011 folder.
## this is an aux script that defines fcns to make hvs coding human legible


# just renaming coop.rn fcn, also in aux fcns but coded differently
# use combine parameter to combine coops/condos
coop.rn <- function(data, combine = FALSE) {
  if(!combine) {
    data %>%
      mutate(Coop.condo.status =
               case_when(Coop.condo.status == 1 ~ "Not Coop or Condominium",
                         Coop.condo.status == 2 ~ "Condo",
                         Coop.condo.status == 3 ~ "Coop",
                         Coop.condo.status == 4 ~ "Respondent unsure")) %>%
      rename("Coop/Condo Status" = Coop.condo.status)
  } else
  if(combine) {
    data %>%
      mutate(Coop.condo.status =
               case_when(Coop.condo.status == 1 ~ "Not Coop or Condominium",
                         Coop.condo.status == 2 |
                           Coop.condo.status == 3 ~ "Coop/Condo",
                         Coop.condo.status == 4 ~ "Respondent unsure"))
  }
  
}

race.rn <- function(data) {
  data %>%
    mutate(Race.and.Ethnicity =
             case_when(Race.and.Ethnicity == 1 ~ "White non-hispanic",
                       Race.and.Ethnicity == 2 ~ "Black non-hispanic",
                       Race.and.Ethnicity == 3 ~ "Puerto Rican",
                       Race.and.Ethnicity == 4 ~ "Other Hispanic",
                       Race.and.Ethnicity == 5 ~ "Asian",
                       Race.and.Ethnicity == 6 ~ "Pacific Islander",
                       Race.and.Ethnicity == 7 ~ "Multiracial, non-hispanic")) %>%
    rename("Race and Ethnicity" = Race.and.Ethnicity)
}

hh.race.rn <- function(data) {
  data %>%
    mutate(Race.and.Ethnicity.of.householder =
             case_when(Race.and.Ethnicity.of.householder == 1 ~ "White, non-hispanic",
                       Race.and.Ethnicity.of.householder == 2 ~ "Black, non-hispanic",
                       Race.and.Ethnicity.of.householder == 3 ~ "Puerto Rican",
                       Race.and.Ethnicity.of.householder == 4 ~ "Other Hispanic",
                       Race.and.Ethnicity.of.householder == 5 ~ "Asian",
                       Race.and.Ethnicity.of.householder == 6 ~ "Pacific Islander",
                       Race.and.Ethnicity.of.householder == 7 ~ "Multiracial, non-hispanic")) %>%
    rename("Race and Ethnicity of Householder" = Race.and.Ethnicity.of.householder)
}

owner.rn <- function(data) {
  data %>%
    mutate(Tenure.1 =
             case_when(Tenure.1 == 1 ~ "Owner-occupied",
                       Tenure.1 == 9 ~ "Renter-occupied")) %>%
    rename("Tenure Type" = Tenure.1)
}

move.reason.rn <- function(data) {
  data %>%
    mutate(Reason.for.moving = 
             case_when(factor2numeric(Reason.for.moving) <= 5 ~ "Employment / Financial Reasons",
                       factor2numeric(Reason.for.moving) == 99 ~ "N/A (Didn't move in last four years)",
                       factor2numeric(Reason.for.moving) == 98 ~ "Didn't report",
                       factor2numeric(Reason.for.moving) == 18 ~ "Evicted, displaced, or harassed by landlord",
                       factor2numeric(Reason.for.moving) > 11 ~ "New Neighborhood, upgrade, looking to buy",
                       factor2numeric(Reason.for.moving) > 6 ~ "Marriage, Separation, Closer to Family, etc.",
                       TRUE ~ "Other Reason"))
}

units2TXCL <- function(data,
                       combine = FALSE) {
  if(combine) {
    data %>%
      mutate(Units.in.building = case_when(factor2numeric(Units.in.building) < 6 ~ "One to three units",
                                 TRUE ~ "Four or more units"))
  } else
    if(!combine) {
      data %>%
        mutate(Units.in.building = case_when(factor2numeric(Units.in.building) < 6 ~ "One to three units",
                                   factor2numeric(Units.in.building) < 9 ~ "Four to nine units",
                                   TRUE ~ "Ten or more units"))
    }
}

last.place.rn <- function(data) {
  data %>%
    mutate(Most.recent.place.lived =
             case_when(factor2numeric(Most.recent.place.lived) == 1 |
                         factor2numeric(Most.recent.place.lived) == 2 ~ "Never moved" # always same unit or same bldg (1 or 2)
                       
                       , factor2numeric(Most.recent.place.lived) >= 3 &
                         factor2numeric(Most.recent.place.lived) <= 7 ~ "Elsewhere in NYC"
                       
                       , factor2numeric(Most.recent.place.lived) >= 8 &
                         factor2numeric(Most.recent.place.lived) <= 9 ~ "Elsewhere in US"
                       
                       , factor2numeric(Most.recent.place.lived) >= 10 &
                         factor2numeric(Most.recent.place.lived) <= 14 ~ "Elsewhere in world"
                       
                       , factor2numeric(Most.recent.place.lived) == 98 ~ "Not Reported"
                       ))
}

control.status.rn <- function(data) {
  data %>%
    mutate(New.control.status.recode =
             case_when(factor2numeric(New.control.status.recode) == 1  ~ "Owner-occupied conventional"
                       , factor2numeric(New.control.status.recode) == 2 ~ "Owner-occupied pvt coop"
                       , factor2numeric(New.control.status.recode) == 5  ~ "Public Housing"
                       , factor2numeric(New.control.status.recode) == 12  ~ "Owner-occupied condo"
                       , factor2numeric(New.control.status.recode) == 21  ~ "HUD or other regulated"
                       , factor2numeric(New.control.status.recode) == 30  ~ "Stabilized pre 1947"
                       , factor2numeric(New.control.status.recode) == 31  ~ "Stabilized post 1947"
                       , factor2numeric(New.control.status.recode) == 80  ~ "Other Rental"
                       , factor2numeric(New.control.status.recode) == 85  ~ "Mitchell Lama rental or article 4"
                       , factor2numeric(New.control.status.recode) == 86  ~ "Mitchell Lama coop"
                       , factor2numeric(New.control.status.recode) == 90  ~ "Controlled"
                       , factor2numeric(New.control.status.recode) == 95  ~ "In Rem"
             ))
}
