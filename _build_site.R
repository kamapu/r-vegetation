# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

library(rmarkdown)
library(blogdown)
library(biblio)
library(readODS)
library(zip)
## library("git2r")

Repo <- "../r-vegetation-resources"

# Produce data set
Files <- list.files(file.path(Repo, "data"), full.names = TRUE)
Files[!grepl(".log", Files, fixed = TRUE)]
unlink("static/documents/KursDateien.zip")
zip("static/documents/KursDateien.zip", Files, mode = "cherry-pick")

# Instruction for installing
Files <- file.path(Repo, "downloads", "installieren.Rmd")
render(Files)

Files <- sub(".Rmd", ".pdf", Files, fixed = TRUE)
file.copy(from = Files, to = "static/documents", overwrite = TRUE)

# Reference list
Refs <- read_ods(file.path(Repo, "downloads", "bib_references.ods"))

Bib <- read_bib("../../db-dumps/literatur_db/bib/MiguelReferences.bib")
Bib <- subset(Bib, bibtexkey %in% Refs$bibtexkey)

reflist(Bib, "static/documents/Referenzen", title = "Empfohlene Referenzen",
    author = "Miguel Alvarez", output = "pdf_document")

# Folien
Files <- list.files(file.path(Repo, "Folien"), pattern = ".Rmd",
    full.names = TRUE)

for(i in Files) render(i)

Files <- sub(".Rmd", ".pdf", Files, fixed = TRUE)
file.copy(from = Files, to = "static/documents", overwrite = TRUE)

# Build the page
build_site(build_rmd = TRUE)
## serve_site()
## stop_server()

# Commit changes
## Files <- list.files(recursive = TRUE, full.names = TRUE)
## add(path = Files)
## commit(message = "Commit from git2r")
system("git add . && git commit -m \"Commit from eclipse.\" && git push")
## push() # TODO: Wise way to add credentials
