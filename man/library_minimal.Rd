% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/library_minimal.R
\name{library_minimal}
\alias{library_minimal}
\title{Minimal Regular Expression Library}
\usage{
library_minimal(path, out = NULL, include.md = TRUE, delete.rmd = TRUE,
  ...)
}
\arguments{
\item{path}{The path to the regular expression library package.}

\item{out}{The directory to output the documents.}

\item{include.md}{logical.  If \code{TRUE} a .md rendering of the .Rmd file
is generated.}

\item{delete.rmd}{logical.  If \code{TRUE} the .Rmd file is removed.}

\item{\ldots}{Other arguments passed to internal functions.}
}
\value{
Generates a minimal .rda regular expression library and html documentation.
to load the .rda file use \code{\link[base]{load}}.
}
\description{
Generate a minimal regular expression library (a .rda list and html
documentation).
}
\examples{
\dontrun{
library_minimal(system.file("sample", package = "regextools"),
    document = FALSE, install = FALSE)
}
}
\seealso{
\code{\link[regextools]{library_list}},
\code{\link[base]{save}},
\code{\link[base]{base}}
}

