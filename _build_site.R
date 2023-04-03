# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

library(quarto)
library(rmarkdown)
## library(biblio)
## library(readODS)
library(zip)

Repo <- "../r-vegetation-resources"

# Data Sets ----
Files <- list.files(file.path(Repo, "data"), full.names = TRUE)
Files <- Files[!Files %in% file.path(Repo, "data", c("_donot-run.R"))]

unlink("documents/course-data.zip")
zip("documents/course-data.zip", Files, mode = "cherry-pick")

# Installation Instructions ----


## # Reference List ----
## Refs <- read_ods(file.path(Repo, "downloads", "bib_references.ods"))
## 
## Bib <- read_bib("../../db-dumps/literatur_db/bib/MiguelReferences.bib")
## Bib <- subset(Bib, bibtexkey %in% Refs$bibtexkey)
## 
## reflist(Bib, "static/documents/Referenzen", title = "Empfohlene Referenzen",
##     author = "Miguel Alvarez", output = "pdf_document")

# Slides ----
Files <- list.files(file.path(Repo, "slides"), pattern = ".Rmd",
    full.names = TRUE)

for(i in Files) render(i)

Files <- sub(".Rmd", ".pdf", Files, fixed = TRUE)
file.copy(from = Files, to = "documents", overwrite = TRUE)

# Build the page ----
quarto_render()
## quarto_preview(port = "4200", host = "localhost")

# Commit changes ----
system(command = paste(c(
            "git add .",
            "git commit -m \"Commit from eclipse.\"",
            "git push"),
        collapse = " && "))
