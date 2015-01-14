#' Regular Expression Library Documentation
#' 
#' Generate a regular expression library package vignette or Rmd/html/md document.
#' 
#' @param path The path to the regular expression library package.
#' @param out The directory to output the  documents.
#' @param is.vignette logical.  Is this an actual package vignette or rendered 
#' html/md reference document.
#' @param include.html logical.  If \code{TRUE} an .html rendering of the .Rmd 
#' file is generated.
#' @param include.md logical.  If \code{TRUE} a .md rendering of the .Rmd file 
#' is generated.
#' @param theme A valid Bootstrap theme (see: 
#' \href{http://rmarkdown.rstudio.com/html_document_format.html#appearance-and-style}{RStudio Themes}).
#' @param iframe logical If \code{TRUE} the \href{https://www.debuggex.com/}{Debuggex} 
#' is included as an iframe rather than a link.
#' @param \ldots Other arguments passed to internal functions.
#' @return Generates a .Rmd document and optionally .html/.md versions.
#' @export
#' @seealso \code{\link[rmarkdown]{render}}
#' @examples
#' \dontrun{
#' library_vignette(system.file("sample", package = "regextools"), "vignette", 
#'     include.html=TRUE, document = FALSE, install = FALSE)
#' }
library_vignette <- function(path, out = file.path(path, "vignette"), 
    is.vignette = TRUE, include.html = !is.vignette, include.md = FALSE, 
    theme = "cerulean",  iframe = FALSE, ...){

    input <- suppressWarnings(readLines(system.file(sprintf(
        "templates/vignette_temp%s.txt", ifelse(is.vignette, "", "2")), 
        package = "regextools")))
    
    if (!file.exists(out)) suppressWarnings(dir.create(out))

    ## Document and Install package path
    build_install(path = path, ...)

    ## Grab the regexes's info
    regsinfo <- grab_regexpr_info(path)

    ## grab the regexes
    regs <- grab_regexpr(path)

    ## grab the regx meta info
    regsmeta <- grab_regexpr_meta(path)

    ## Debuggex visualization links
    debuggex_links <- lapply(regs, function(x) {
        out <- try(debuggex(as.character(x)))
        if (inherits("try-error", out)) return(NA)
        out
    })

    ## Prep the YAML
    auth <- eval(parse(text=regsmeta[[names(regsmeta)[grepl("Author", names(regsmeta))][1]]]))
    yaml <- sprintf(paste(input, collapse="\n"), regsmeta[["Package"]],
        paste(auth$given, auth$family),
        theme,
        "%", regsmeta[["Package"]], "%"
    )

    ## Make the Rmd
    rmd <- mapply(function(x, y){
        paste(
            paste0("# ", x[["title"]][[1]],
                "\n\n", x[["description"]][[1]]),
            paste("\n\n## Debuggex Diagram\n\n", 
                if (iframe) {
                    sprintf("<iframe src=\"%s\" height=\"500\" width=\"120%s\"></iframe>", y, "%")
                } else {
                    sprintf("<a href=\"%s\" target=\"_blank\">%s</a>", y, y)
                }
            ),
            ifelse(is.na(x[["details"]][[1]]), 
                "", 
                paste("\n\n### Details\n\n", x[["details"]][[1]])
            ),
            paste0("\n\n## Examples\n\n```{r}", x[["examples"]][[1]], "```\n"), 
        collapse="\n")
    }, split(regsinfo, nrow(regsinfo)), debuggex_links)

    vignrmd <- file.path(out, paste0(regsmeta[["Package"]], ".Rmd"))
    cat(paste(c(yaml, "\n```{r, echo=FALSE, message=FALSE}\nlibrary(sample)\n```",
        unlist(rmd)), collapse="\n"), file = vignrmd)

    ## Convert to .html and .md
    if (include.html && !is.vignette){
        rmarkdown::render(vignrmd)
    }
    if (include.md && !is.vignette){
        rmarkdown::render(vignrmd, output_file = gsub("\\.Rmd$", "\\.md", vignrmd))
    }
    
    if(file.exists(vignrmd)) message("Vignette Generated:\n", out)
}
