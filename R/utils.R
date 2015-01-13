## get counterparts to test_ family (internal use)
get_extract <- function(regex, input){

    input2 <- regmatches(input, gregexpr(regex, input, perl = TRUE))
    dput(input2)

}

get_remove <- function(regex, input){

    input2 <- gsub(regex, "", input, perl = TRUE)
    dput(input2)
}


get_split <- function(regex, input){

    input2 <- strsplit(input, regex, perl = TRUE)
    dput(input2)

}

## multiple gsub
rt_msub <-
function (pattern, replacement, text.var, fixed = TRUE, order.pattern = fixed, 
    ...) {

    if (fixed && order.pattern) {
        ord <- rev(order(nchar(pattern)))
        pattern <- pattern[ord]
        if (length(replacement) != 1) replacement <- replacement[ord]
    }
    if (length(replacement) == 1) replacement <- rep(replacement, length(pattern))
   
    for (i in seq_along(pattern)){
        text.var <- gsub(pattern[i], replacement[i], text.var, fixed = fixed, ...)
    }

    text.var
}


## First build the documentation and install the package
build_install <- function(path, document = TRUE, install = TRUE, ...){
    if (document){
        devtools::document(path)
    }
    if (install){
        devtools::install(path, quick = TRUE, build_vignettes = FALSE, 
            dependencies = TRUE, ...)
    }
}

## Helper to grab regular expression info and return formated dataframe of text
grab_regexpr_info <- function(path){

    ## make path to package man files
    path2 <- file.path(path, "man")
    man_files <- normalizePath(file.path(path2, dir(path2)))

    out <- invisible(lapply(man_files, function(x){
    
        ## read in the .Rd man files and keep the ones that have Regex: TRUE tag
        input <- suppressWarnings(readLines(x))  
        regexdet <- grep("\\section{Regex}{", input, fixed=TRUE)                                                                                               
        if (identical(integer(0), regexdet)) return(NULL)
        regexdetTRUE <- grepl("^\\s* TRUE\\s*$", input[regexdet + 1])
        if (!regexdetTRUE) return(NULL)

        ## collapse the inpuut into one string   
        input2 <- right_brace_key(paste(input, collapse="\n"))

        ## set up a function generator to grab particular tex tags
        grabber_ <- grabber(input2)

        ## grab the title, description, details, examples, and usage tags    
        title <- right_brace_unkey(rm_white_(grabber_("title")))
        description <- right_brace_unkey(rm_white_(grabber_("description")))
        details <- right_brace_unkey(rm_white_(grabber_("details")))
        examples <- right_brace_unkey(grabber_("examples"))
        regexpr <- right_brace_unkey(unlist(strsplit(gsub("^\n+|\n+$", "", grabber_("usage")), "\n")))
 
        ## output as a named list with descriptiion/details converted to markdown   
        list(title = title, description = convert_tex2markdown(description), 
            details = convert_tex2markdown(details), 
            examples = examples, regexpr = regexpr)
    
    }))
      
    ## make into a dataframe of regex info to grab pieces from later
    data.frame(do.call(rbind, out[!sapply(out, is.null)]))
}

## Closure to set the latex elements being searched for
grabber <- function(x) {
    function(pat) {
        out <- regmatches(x, 
            gregexpr(sprintf("(?<=\\\\%s\\{)([^}]*)(?=\\})", pat), 
                x, perl = TRUE)
        )[[1]]               
        if(identical(character(0), out)) return(NA)
        out
    }
}


## Sub out leading, trailing, and multiple white spaces
rm_white_ <-  function(x) {
    gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", x))
}

## Helper to grab the regular expressions fromt heir names
grab_regexpr <- function(path){

    ## Grab package name
    pkg <- read.dcf(normalizePath(file.path(path, "DESCRIPTION")))[, "Package"]
    
    ## Get the regex names and paste with pacckage name
    theregs <- grab_regexpr_info(path)[["regexpr"]]
    regxpr_char <- paste0("try(", paste(pkg, theregs, sep="::"), ")")

    ## Eval parse to try to return the regualr expression from their names
    ## library must be created and loaded locally
    setNames(lapply(regxpr_char, function(x) {
        m <- eval(parse(text=x))
        if (inherits("try-error", m)) return(NA)
        m
    }), theregs)
}

## Grab the meta info from the DECRIPTION file
grab_regexpr_meta <- function(path){
    descript <- read.dcf(normalizePath(file.path(path, "DESCRIPTION")))
    setNames(as.list(descript), colnames(descript))
}

## Convert .text formated text to .md format
convert_tex2markdown <- function(txt){

    ## Sub out R tex items pandoc misses for markdown KEY
    txt <- gsub("(\\\\code\\{)([^}]*)(\\})", "[[KEY1]]\\2[[KEY1]]", txt, perl=TRUE)
    txt <- gsub("(\\\\pkg\\{)([^}]*)(\\})", "[[KEY2]]\\2[[KEY2]]", txt, perl=TRUE)
    txt <- gsub("(\\\\bold\\{)([^}]*)(\\})", "[[KEY2]]\\2[[KEY2]]", txt, perl=TRUE)
    txt <- gsub("(\\\\strong\\{)([^}]*)(\\})", "[[KEY3]]\\2[[KEY3]]", txt, perl=TRUE)

    ## Write to external temp .tex file
    temp <- tempdir()
    txt <- cat(txt, file=file.path(temp, "temp.tex"))

    ## Use rmarkdown to convert to .md
    rmarkdown::pandoc_convert(file.path(temp, "temp.tex"), 
        output = file.path(temp, "temp.md"))

    ## Read back in and collapse
    readin <- paste(suppressWarnings(readLines(file.path(temp, "temp.md"))), 
        collapse=" ")

    ## Change the markdown keys into actual markdown
    rt_msub(paste0("[[KEY", 1:3, "]]"), c("`", "**", "***"), readin)
}




## key/remove escaped right braces and unkey after extraction
right_brace_key <- function(x){
    gsub("\\[}\\]", "[[RIGHTBRACEKEY2]]", gsub("\\\\}", "[[RIGHTBRACEKEY1]]", x))
}

right_brace_unkey <- function(x){
    gsub("[[RIGHTBRACEKEY2]]", "[}]", sub("[[RIGHTBRACEKEY1]]", "\\\\}", x))
}



# Visualize a Regular Expression
# 
# Visualize a regular expression via \url{https://www.debuggex.com}
# 
# @param pattern A regular expression pattern.
# @param \ldots Ignored.
# @references \url{http://stackoverflow.com/a/27574103/1000343}
# @author Matthew Flickinger
# @export
# @examples
# \donttest{
# view_regex("(?<=foo)\\s+[a-z]{1,2}(?<=foo)")
# }
debuggex <- function(pattern, ...){

    ## Code by Matthew Flickinger: http://www.matthewflickinger.com/
    ## http://stackoverflow.com/a/27574103/1000343

    payload <- list(title = "Untitled Regex",
        description = "No description",
        regex = pattern,
        flavor = "python",
        strFlags = "",
        testString = "My test data",
        unitTests = "[]",
        share = TRUE)

    rr <- httr::POST("https://www.debuggex.com/api/regex", 
        body=lapply(payload, jsonlite::unbox), encode="json")
    paste0("https://www.debuggex.com/r/", httr::content(rr)$token)
}

