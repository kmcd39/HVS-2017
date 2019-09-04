# skip this one-- files have mistakes / idiosyn
#source("1 - download data.R")

source("2 - import data.R")

source("3 - add column names.R")

source("4 - setup weights & srvy objs.R")

source("hvs helper fcns.R")

save.image(file = "hvs all set up.Rdata")
