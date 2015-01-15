## ----, echo=FALSE, results='asis', warning=FALSE-------------------------
library(regextools)
thefuns <- readLines("vignettes/functions_table/functions.R")
cat(paste(thefuns, collapse="\n"))

