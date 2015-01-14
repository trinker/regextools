#' Regular Expression Minimal .rda Library 
#' 
#' Generate a minimal .rda regular expression library.
#' 
#' @param path The path to the regular expression library package.
#' @param out The directory to output the  documents.
#' @param \ldots Other arguments passed to internal functions.
#' @return Generates a minimal .rda regular expression library.
#' @export
#' @seealso \code{\link[base]{save}}
#' @examples
#' \dontrun{
#' library_list(system.file("sample", package = "regextools"), 
#'     document = FALSE, install = FALSE)
#' }
library_list <- function(path, out = NULL, ...){

    ## Document and Install package path
    build_install(path = path, ...)

    ## grab the regx meta info
    regsmeta <- grab_regexpr_meta(path)

    ## grab the regexes
    env <- new.env(hash = FALSE)
    assign(regsmeta[["Package"]], grab_regexpr(path), envir=env)

    if (is.null(out)) out <- sprintf("%s.rda", regsmeta[["Package"]])
    save(list = regsmeta[["Package"]], file=out, envir = env)

    if (file.exists(out)) message(sprintf("%s list generated", regsmeta[["Package"]]))
}