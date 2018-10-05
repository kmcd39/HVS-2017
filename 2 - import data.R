library(SAScii)

?parse.SAScii
?read.SAScii

getwd()

parse.SAScii("2017\\import-occupied.txt",
             lrecl = 1334)

parse.SAScii("2017\\import-occupied.txt")

parse.SAScii("2017\\import-vacant.txt")

parse.SAScii("2017\\import-person.txt")


occ <-
  read.SAScii("2017\\HVS 2017 Occupied.txt",
              sas_ri = "2017\\import-occupied.txt")


vac <-
  read.SAScii("2017\\HVS 2017 Vacant.txt",
              sas_ri = "2017\\import-vacant.txt")

pers <-
  read.SAScii("2017\\HVS 2017 Person.txt",
              sas_ri = "2017\\import-person.txt")

rm(list = setdiff(ls(),
                  c("occ", "vac", "pers")))


saveRDS(occ,
        paste0(dest.dir,
               "raw 2017 hvs occupied.rds"))

saveRDS(vac,
        paste0(dest.dir,
               "raw 2017 hvs vacant.rds"))

saveRDS(pers,
        paste0(dest.dir,
               "raw 2017 hvs person.rds"))
