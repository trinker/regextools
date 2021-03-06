#' Generate Regular Expression .rda  
#' 
#' Generate a .rda regular expression lists.
#' 
#' @param path The path to the regular expression library package.
#' @param out The file path to output the .rda file (see 
#' \code{\link[base]{save}} for details on saving).
#' @param name The name to assign the list to and to use for the .rda file.  If
#' \code{NULL} the package name is used.
#' @param \ldots Other arguments passed to internal functions.
#' @return Generates a minimal .rda regular expression library.  To load the 
#' .rda file use \code{\link[base]{load}}.
#' @export
#' @seealso \code{\link[base]{save}},
#' \code{\link[base]{base}}
#' @examples
#' \dontrun{
#' library_list(system.file("sample", package = "regextools"), 
#'      document = FALSE, install = FALSE)
#' 
#' sample             ## sample is a base R function
#' load("sample.rda")
#' sample             ## sample is now overwritten with the sample regex list
#' rm(sample)         ## remove the list (restore default sample)
#' }
library_list <- function(path, out = NULL, name = NULL, ...){

    ## Document and Install package path
    build_install(path = path, ...)

    ## grab the regex meta info
    regsmeta <- grab_regexpr_meta(path)

    if (is.null(name)) name <- regsmeta[["Package"]]
    
    ## grab the regexes
    env <- new.env(hash = FALSE)
    assign(name, grab_regexpr(path), envir=env)

    if (is.null(out)) out <- sprintf("%s.rda", name)
    save(list = name, file=out, envir = env)

    if (file.exists(out)) message(sprintf("%s list generated", name))
}