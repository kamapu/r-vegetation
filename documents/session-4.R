# Download code ----

download.file(
  url = "https://kamapu.github.io/r-vegetation/documents/course-data.zip",
  destfile = "course-data.zip", method = "curl")
unzip("course-data.zip", overwrite = TRUE)
unlink("course-data.zip")

library(vegtable)
library(readODS)

# Formatting the taxonomic list ----

sam_splist <- readRDS("sam_splist.rds")

# Reshape tables ----
list_ods_sheets("Montaldo1975.ods")

# Importing samples
samples <- list()
for (i in c("Tab1", "Tab2", "Tab3")) {
  samples[[i]] <- cross2db(read_ods("Montaldo1975.ods", sheet = i))
}

samples <- do.call(rbind, samples)
head(samples)

# Importing header
header <- read_ods("Montaldo1975.ods", sheet = "header")
head(header)

header$ReleveID <- 1:nrow(header)
head(header)

# In the samples
samples$ReleveID <- header$ReleveID[match(samples$plot,
                                          header$original_number)]

# Linking taxonomic lists
" Agrostis     capillaris " == "Agrostis capillaris"
clean_strings(" Agrostis     capillaris ") == "Agrostis capillaris"

samples$species <- clean_strings(samples$species)

species_names <- unique(samples$species)

species <- match_names(species_names, sam_splist)

head(species)

subset(species, idx %in% idx[duplicated(idx)])

skip_name <- c(6911, 187442)

species <- subset(species, !idx %in% skip_name)

samples$TaxonUsageID <- species$TaxonUsageID[match(samples$species,
                                                   species$submittedname)]
any(is.na(samples$TaxonUsageID))

head(samples)

# Now we assemble a vegtable ---------------------------------------------------

montaldo <- new("vegtable")
montaldo

montaldo@header <- header
montaldo@samples <- samples
montaldo@species <- sam_splist

montaldo

# To be continued...

# Question: How to count species recorded in a community type ----

slotNames(montaldo)

montaldo@relations

summary(as.factor(montaldo$community_type))

new_relation(montaldo) <- "community_type"
montaldo@relations$community_type

montaldo <- count_taxa(species ~ ReleveID, data = montaldo,
                       include_lower = TRUE)
aggregate(species_count ~ community_type, data = montaldo@header, FUN = mean)

montaldo <- count_taxa(species ~ community_type, data = montaldo,
                       include_lower = TRUE)
montaldo@relations$community_type

# Save the object

saveRDS(montaldo, "montaldo-vegtable.rds")
