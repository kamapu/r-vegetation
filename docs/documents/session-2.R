# Second session ----

## Taxonomic Names Resolution ----

# Download data
download.file(
  url = "https://kamapu.github.io/r-vegetation/documents/course-data.zip",
  destfile = "course-data.zip", method = "curl")
unzip("course-data.zip", overwrite = TRUE)
unlink("course-data.zip")

library(readODS)
library(taxize)

# Load the ODS book
list_ods_sheets("Montaldo1975.ods")
montaldo <- read_ods("Montaldo1975.ods", sheet = "Tab1")
head(montaldo)

m_species <- montaldo[1:10, "species"]
m_species

m_resolve <- resolve(m_species)$gnr
head(m_resolve)

summary(as.factor(m_resolve$data_source_title))

head(m_resolve)

## Introduction to taxlist ----

install.packages("taxlist")

library(taxlist)

iris_sp <- new("taxlist")
iris_sp

levels(iris_sp) <- c("species", "genus", "family", "kingdom")
levels(iris_sp)

iris_sp <- add_concept(iris_sp, TaxonName = "Plantae", Level = "kingdom")
summary(iris_sp, "all")

iris_sp <- add_concept(iris_sp, TaxonName = "Iridaceae", Level = "family",
                       Parent = 1)
summary(iris_sp, "all")

# Additional functions
indented_list(iris_sp)

?df2taxlist

# Example data
Easplist

summary(Easplist, "papyrus")

slotNames(Easplist)
head(Easplist@taxonNames)
head(Easplist@taxonRelations)
head(Easplist@taxonViews)
head(Easplist@taxonTraits)

summary(Easplist, "Papyrus")

?taxlist::summary

summary(Easplist, "Galium")
summary(Easplist, "Galium", exact = TRUE)

summary(Easplist, "Rubiaceae")


