# TODO:   Installing packages required for this course
# 
# Author: Miguel Alvarez
################################################################################

# update installed packages
update.packages(ask = FALSE)

# CRAN packages
pkgs <- c(
    "devtools",
    "knitr",
    "readODS",
    "rmarkdown",
    "sf",
    "tidyr",
    "taxize",
    "Taxonstand",
    "vegan",
    "WorldFlora")

# Installed Packages only if not yet done
inst_pkgs <- rownames(installed.packages())
install.packages(pkgs = pkgs[!pkgs %in% inst_pkgs])

# Packages from github
library(devtools)

install_github("kamapu/biblio")
install_github("kamapu/yamlme")
install_github("ropensci/taxlist")
install_github("kamapu/vegtable")
