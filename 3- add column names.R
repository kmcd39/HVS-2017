rm(list = ls())


aux.dir <- "J:/REVENUE/NEW REVENUE FOLDER/UTILITY/R"
source(paste0(aux.dir, "/aux fcns.R"))

library(stringr)

########### OCCUPIED
# (vacancy record renaming below)

## load data
dest.dir <- "./data/"

occ <-
  readRDS(paste0(dest.dir, 
                 "raw 2017 hvs occupied.rds"))


#note--
# following file is a copy and paste from the SAS import script
# it is the block that defines the column names for the occupied records
# ALSO
# seemingly the census bureau is very careless ! And has a DUPLICATE column name assingment in the SAS script
#  let's get rid of that. I get rid of that in the .txt -- it is one of the FW1 rows.
sas.names <-
  readLines("2017\\rename occ columns.txt")

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

# start an ongoing list of all HVS information
all.info <- data.frame(occupied = unlist(col.label))


## regex and a fcn to mark duplicated rows and then clean them up a bit
col.label <-
  sub("\\.$",
      "",
      make.names(unlist(col.label),
                 unique = TRUE))

# creates a psuedo data dicionary to store ID information -- can reference to HVS data dictionaries
occ.dd <- data.frame(value = unlist(col.id),
                     tag = col.label) %>%
  spread(key = tag, value = value)



#order the dataframe to reflect order of column assignments
occ <-
  occ %>%
  select(
    unlist(col.id))

colnames(occ) <- 
  col.label

colnames(occ)


#clean up and save
rm(col.id, col.label)

saveRDS(occ,
        paste0(dest.dir,
               "2017 hvs occupied.rds"))

# write.csv(occ, file = "2017 hvs occupied.csv")




#######################################################################
# VACANCY records
vac <-
  readRDS(paste0(dest.dir,
                 "raw 2017 hvs vacant.rds"))

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

# write.csv(vac, file = "2017 hvs vacancy.csv")


#######################################################################
# PERSON records
pers <-
  readRDS(paste0(dest.dir,
                 "raw 2017 hvs person.rds"))

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

# write.csv(pers, file = "2017 hvs person.csv")

#write.csv(all.info,
#          file = "All HVS columns.csv")
