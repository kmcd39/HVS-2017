dest.dir <- "./data/"

# "occupied records"
download.file("https://www2.census.gov/programs-surveys/nychvs/datasets/2017/microdata/uf_17_occ_web_b.txt",
              destfile = paste0(dest.dir, "HVS 2017 Occupied.txt"))

# "Person Records"
download.file("https://www2.census.gov/programs-surveys/nychvs/datasets/2017/microdata/uf_17_pers_web_b.txt",
              destfile = paste0(dest.dir, "HVS 2017 Person.txt"))
# "Vacant Records"
download.file("https://www2.census.gov/programs-surveys/nychvs/datasets/2017/microdata/uf_17_vac_web_b.txt",
              destfile = paste0(dest.dir, "HVS 2017 Vacant.txt"))

# SAS import script
download.file("https://www2.census.gov/programs-surveys/nychvs/datasets/2017/microdata/sas_import_program_17.txt",
              destfile = paste0(dest.dir, "HVS 2017 SAS import script.txt"))
