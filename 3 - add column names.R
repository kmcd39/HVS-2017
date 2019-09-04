#rm(list = ls())


## This script parses SAS import scripts, puts into workable form, and associates with the three HVS records
## (occupied households, vacant households, and individuals)

# get helper fcns ------------------------------------------------------
aux.dir <- 
  "../"

source(paste0(aux.dir, "/aux fcns.R"))

# 
dest.dir <-
  "J:/REVENUE/NEW REVENUE FOLDER/OUTSIDE DATA & REPORTS (L)/HOUSING VACANCY DATA/2017/"


# parse SAS scripts -------------------------------------------------------

########### OCCUPIED

#note--
#  following file is modified from the one downloaded from the census website
# because there were some mistakes in their file (this is confirmed with folks from HPD)
# specifically the first replicate weight column (FW1) is duplicated.
# And In the Vacancy Records, the  "Reason not Available for Rent or Sale" (UF80) is mistakenly listed as one character but it's actually two.
# These are fixed in my modified versions of the file
sas.names <-
  readLines("2017\\rename occ columns.txt")

sas.names <-
  sub("label ",
    "",
    sas.names)


col.id <- list()
col.label <- list()

library(stringr)

for (i in sas.names) {
  col.id <-
    append(
      col.id,
      toupper(
      unlist(
      strsplit(i, "="))[1]))
  
  col.label <-
    append(
      col.label,
      str_extract(
      unlist(
        strsplit(i, "="))[2],
      "(?<=').*?(?=')"))
      #"'(.*?)'"))
}

#finding duplicate, commented out
#col.id[!duplicated(unlist(col.id))]
#duplicated(col.label)

# start an ongoing list of all HVS information
all.info <- 
  data.frame(occupied =
               unlist(col.label))

## regex and a fcn to mark duplicated rows and then clean them up a bit
col.label <-
  sub("\\.$",
      "",
      make.names(unlist(col.label),
                 unique = TRUE))
col.id
# creates a psuedo data dicionary to store ID information -- can use to reference HVS data dictionaries
occ.dd <- 
  data.frame(value = unlist(col.id),
             tag = col.label) %>%
  spread(key = tag, 
         value = value)

#order the dataframe to reflect order of column assignments
occ <-
  occ %>%
  select(
    unlist(col.id))

colnames(occ) <- 
  col.label

colnames(occ)

occ
#clean up and save
rm(col.id, col.label)

saveRDS(occ,
        paste0(dest.dir,
               "2017 hvs occupied.rds"))

#write.csv(occ, file = paste0(dest.dir,
#                             "2017 hvs occupied.csv"))


#######################################################################
# VACANCY records

colnames(vac) <-
  toupper(colnames(vac))

sas.names <-
  readLines("2017\\rename vac columns.txt")

sas.names <-
  sub("label ",
      "",
      sas.names)


col.id <- list()
col.label <- list()

for (i in sas.names) {
  col.id <-
    append(
      col.id,
      toupper(
        unlist(
          strsplit(i, "="))[1]))
  
  col.label <-
    append(
      col.label,
      str_extract(
        unlist(
          strsplit(i, "="))[2],
        "(?<=').*?(?=')"))
  #"'(.*?)'"))
}
#finding duplicate, commented out
#col.id[!duplicated(unlist(col.id))]
duplicated(col.label)


#add these labels to ongoing list of all hvs information
all.info <- 
  data.frame(cbind.fill(all.info,
                        data.frame(vacancy = unlist(col.label))))


## regex and a fcn to mark duplicated rows and then clean them up a bit
col.label <-
  sub("\\.$",
      "",
      make.names(unlist(col.label),
                 unique = TRUE))
col.label


# creates a psuedo data dicionary to store ID information -- can reference to HVS data dictionaries
vac.dd <- data.frame(value = unlist(col.id),
                     tag = col.label) %>%
  spread(key = tag, value = value)

#order the dataframe to reflect order of column assignments
vac <-
  vac %>%
  select(
    unlist(col.id))


colnames(vac) <- 
  col.label
colnames(vac)


#clean up and save
rm(col.id, col.label)

saveRDS(vac,
        paste0(dest.dir,
               "2017 hvs vacancy.rds"))

#write.csv(vac, file = paste0(dest.dir,
#                             "2017 hvs vacancy.csv"))


#######################################################################
# PERSON records

colnames(pers) <-
  toupper(colnames(pers))

sas.names <-
  readLines("2017\\rename pers columns.txt")

sas.names <-
  sub("label ",
      "",
      sas.names)


col.id <- list()
col.label <- list()

for (i in sas.names) {
  col.id <-
    append(
      col.id,
      toupper(
        unlist(
          strsplit(i, "="))[1]))
  
  col.label <-
    append(
      col.label,
      str_extract(
        unlist(
          strsplit(i, "="))[2],
        "(?<=').*?(?=')"))
  #"'(.*?)'"))
}
#finding duplicate, commented out
#col.id[!duplicated(unlist(col.id))]
sum(duplicated(col.label))

#add these labels to ongoing list of all hvs information
all.info <- 
  data.frame(cbind.fill(all.info,
                        data.frame(persons = unlist(col.label))))


## regex and a fcn to mark duplicated rows and then clean them up a bit
col.label <-
  sub("\\.$",
      "",
      make.names(unlist(col.label),
                 unique = TRUE))
col.label


# creates a psuedo data dicionary to store ID information -- can reference to HVS data dictionaries
pers.dd <- data.frame(value = unlist(col.id),
                     tag = col.label) %>%
  spread(key = tag, value = value)


#order the dataframe to reflect order of column assignments
pers <-
  pers %>%
  select(
    unlist(col.id))


colnames(pers) <- 
  col.label
colnames(pers)


#clean up and save
rm(col.id, col.label)

saveRDS(pers,
        paste0(dest.dir,
               "2017 hvs person.rds"))


#write.csv(pers, file = paste0(dest.dir,
#                              "2017 hvs person.csv"))

#write.csv(all.info,
#          file = "All HVS columns.csv")
