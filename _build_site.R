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

# Program ----
Files <- file.path(Repo, "course-program", c(
        "program-sessions.Rmd",
        "screenplay.Rmd"))

for(i in Files) render(i)

Files <- sub(".Rmd", ".pdf", Files, fixed = TRUE)
file.copy(from = Files, to = "documents", overwrite = TRUE)

# Installation Instructions ----
Files <- file.path(Repo, "further-documents", "installing-software.Rmd")

for(i in Files) render(i)

Files <- sub(".Rmd", ".pdf", Files, fixed = TRUE)
file.copy(from = Files, to = "documents", overwrite = TRUE)

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

# RSessions ----
Files <- list.files(file.path(Repo, "r-sessions"), full.names = TRUE)
file.copy(from = Files, to = "documents", overwrite = TRUE)

# Other files ----
# TODO: Perhaps also installation script
Files <- c(file.path(Repo, "handout/_book/vegetation_in_r.pdf"))
file.copy(from = Files, to = "documents", overwrite = TRUE)

# Build the page and preview ----
quarto_render()

# Block dealing with Rmd files
Files <- list.files(file.path("docs", "documents"), full.names = TRUE)
Files <- Files[grepl("_notebook-session", Files, fixed = TRUE)]
Files_new <- gsub("_notebook-session", "notebook-session", Files, fixed = TRUE)
file.rename(from = Files, to = Files_new)
Site <- readLines(file.path("docs", "sessions.html"))
Site <- gsub("_notebook-session", "notebook-session", Site, fixed = TRUE)
writeLines(Site, file.path("docs", "sessions.html"))

quarto_preview()
quarto_preview_stop()

# Commit changes ----
system(command = paste(c(
            "git add .",
            "git commit -m \"Commit from eclipse.\"",
            "git push"),
        collapse = " && "))
