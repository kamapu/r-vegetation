# Session 3 ----

download.file(
  url = "https://kamapu.github.io/r-vegetation/documents/course-data.zip",
  destfile = "course-data.zip", method = "curl")
unzip("course-data.zip", overwrite = TRUE)
unlink("course-data.zip")

library(vegtable)

releves <- readRDS("sanmartin1998.rds")

slotNames(releves)

# Taxonomic List
releves@species

# Header data
head(releves@header)

# Samples
head(releves@samples)

# Statistics from taxonomic information ----
releves <- readRDS("sanmartin1998.rds")
releves

releves@species

# Counting taxa
releves <- count_taxa(
  object = species ~ ReleveID,
  data = releves,
  suffix = "_count"
)
releves

# To check the suitable ranks
levels(releves@species)

# Counting taxa
releves <- count_taxa(
  object = genus ~ ReleveID,
  data = releves,
  suffix = "_count"
)

names(releves@header)

summary(releves@header$species_count)
summary(releves$species_count)

summary(releves$genus_count)

# To check the suitable ranks
levels(releves@species)

# Counting taxa
releves <- count_taxa(
  object = genus ~ ReleveID,
  data = releves,
  suffix = "_count2",
  include_lower = TRUE
)

summary(releves$genus_count)
summary(releves$genus_count2)

# Counting taxa
releves <- count_taxa(
  object = family ~ ReleveID,
  data = releves,
  suffix = "_count",
  include_lower = TRUE
)

summary(releves$family_count)

# Working with attributes
head(releves@species@taxonTraits)
summary(as.factor(releves@species@taxonTraits$origin_status))
