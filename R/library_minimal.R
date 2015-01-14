#' Minimal Regular Expression Library 
#' 
#' Generate a minimal regular expression library (a .rda list and html 
#' documentation).
#' 
#' @param path The path to the regular expression library package.
#' @param out The directory to output the documents.
#' @param include.md logical.  If \code{TRUE} a .md rendering of the .Rmd file 
#' is generated.
#' @param delete.rmd logical.  If \code{TRUE} the .Rmd file is removed.
#' @param \ldots Other arguments passed to internal functions.
#' @return Generates a minimal .rda regular expression library and html documentation.  
#' to load the .rda file use \code{\link[base]{load}}.
#' @export
#' @seealso \code{\link[regextools]{library_list}},
#' \code{\link[base]{save}},
#' \code{\link[base]{base}}
#' @examples
#' \dontrun{
#' library_minimal(system.file("sample", package = "regextools"), 
#'     document = FALSE, install = FALSE)
#' }
library_minimal <- function(path, out = NULL, include.md = TRUE, 
    delete.rmd = TRUE, ...){

    if (is.null(out)){
        ## grab the package name
        pack <- out <- grab_regexpr_meta(path)[["Package"]]
    } else {
        pack <- grab_regexpr_meta(path)[["Package"]]
    }

    ## Create home directory
    if (file.exists(out)) {
        message(paste0("\"", out, "\" already exists:\nDo you want to overwrite?\n"))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("`library_minimal` aborted")
        } else {
             unlink(out, recursive = TRUE, force = FALSE)
             suppressWarnings(dir.create(out))
        }
    } else {
        suppressWarnings(dir.create(out))
    }
  
    ## Create the .rda file
    library_list(path, out = file.path(out, paste0(pack, ".rda")), ...)

    ## Create the html documentation
    library_vignette(path, out, is.vignette = FALSE, include.html=TRUE, 
        include.md = include.md, ...)

    ## Remove .Rmd
    if (isTRUE(delete.rmd)) {
        unlink(file.path(out, paste0(pack, ".Rmd")), recursive = TRUE, 
            force = FALSE)
    }
}
