load("hvs all set up.Rdata")

library(dplyr)
library(srvyr)
library(knitr)
source("../aux fcns.R")

occ.dd$Gross.rent.income.ratio

summary(
  factor2numeric(occ$Gross.rent.income.ratio))

OCC %>%
  mutate(Gross.rent.income.ratio =
           factor2numeric(Gross.rent.income.ratio) ) %>%
  filter(Gross.rent.income.ratio < 9999 &
           Gross.rent.income.ratio > 0) %>%
  mutate(Gross.rent.income.ratio =
           Gross.rent.income.ratio / 10 ) %>%
  summarise(survey_quantile(Gross.rent.income.ratio
                            ,quantiles = seq(0,1,.1)
                            ,vartype = "se")) %>%
  tbl.theme()


OCC %>%
  mutate(Gross.rent.income.ratio =
           factor2numeric(Gross.rent.income.ratio) ) %>%
  filter(Gross.rent.income.ratio < 9999 &
           Gross.rent.income.ratio > 0) %>%
  mutate(Gross.rent.income.ratio =
           Gross.rent.income.ratio / 10 ) %>%
  summarise(survey_median(Gross.rent.income.ratio)) %>%
  tbl.theme()
