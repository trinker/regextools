#' \pkg{regextools}: A regular expression documentation, testing, and storage framework.
#'
#' \pkg{regextools} extends the \pkg{devtools}, \pkg{roxygen2}, & \pkg{testthat}
#' packages to regular expressions library documentation, testing, and storage.
#' The framework assumes the user will document and store regular expressions
#' as an R package via the \pkg{devtools}, \pkg{roxygen2}, & \pkg{testthat} 
#' packages.  This extends these existing frameworks to work make regular 
#' expression management easier for long term documentation, maintenance, and 
#' testing.  The only change to these existing frameworks is that the user must
#' include a tag \code{@@section Regex: TRUE} in the \pkg{roxygen2} markup, 
#' indicating the object is a regular expression.  
#'
#' \pkg{regextools} is a philosophy of regular expression management that sees
#' unit testing and transparency of test coverage as an essential part of 
#' maintaining a regular expression library.  In the spirit of transparent unit 
#' testing, \pkg{regextools} adds functions to test regular expressions, 
#' extending the \pkg{testthat} package.  This avoids unforeseen breaks due to 
#' changes in a regular expression and explicitally describes the expression's 
#' intended behavior.  \pkg{regextools} offers a template system that encourages 
#' this transparent unit testing philosophy through the use of 
#' \href{https://github.com/}{GitHub}, 
#' \href{https://travis-ci.org}{Travis-CI}, and the 
#' \href{https://github.com/jimhester/covr}{\pkg{covr}} package to i to indicate 
#' coverage in the GitHub README.md.  For more information on Travis-CI in R see 
#' \code{\link[devtools]{use_travis}}.
#'
#' \pkg{regextools} also highlights the need for minimal, clear, description of
#' a regular expression's behavior.  \pkg{regextools} provides tools to generate
#' html, .md, and .Rmd vignettes from existing \pkg{roxygen2} markup rather than
#' the more verbose package help documentation.  Regular expressions are often
#' difficult to parse, particularly as the expression's complexity grows.  Visual
#' presentation of the regular expression can enhance the maintainer and user's
#' abilities to understand the expression's design.  \pkg{regextools} includes
#' a link/iframe of \href{https://www.debuggex.com}{Debuggex's} terrific visual 
#' diagram representation of regular expressions.  
#'
#' @docType package
#' @name regextools
#' @aliases regextools package-regextools
NULL
