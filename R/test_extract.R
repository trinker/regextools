#' Is Expression Valid and Does It Extract/Remove/Split as Expected?
#' 
#' A logical test of a regular expression's validity, extraction, removal, 
#' splitting results.  These functions are useful for unit testing of regular 
#' expressions.
#' 
#' @param regex A regular expression to test.
#' @param input The intput string(s) to extract/remove/split from.
#' @param output The desired output of: 
#' \describe{
#'   \item{extract}{\code{regmatches(input, gregexpr(regex, input, perl = TRUE))}}
#'   \item{remove}{\code{gsub(regex, "", input, perl = TRUE)}}
#'   \item{split}{\code{strsplit(input, regex, perl = TRUE)}}
#' }
#' @param lofical.  If \code{TRUE} \pkg{stringi}'s implementation of reguar 
#' expressions is utilized for testing.  This allows for more flexible use of
#' regular expressions.
#' @return Returns the results of \code{\link[base]{all.equal}} for the 
#' \code{input} and desired \code{output}.
#' @keywords test extract remove
#' @details These functions are inspired by Hadely Wickham's \pkg{testthat} 
#' package.  They can be used with \pkg{testthat} to test that regular 
#' expressions are valid, extracting, removing, and splitting as expected.  The 
#' user may create their own tests and utilize \code{\link[base]{all.equal}} or
#' \code{\link[testthat]{expect_equal}} to ensure the expression is acting as 
#' desired.
#' @export
#' @rdname testing
#' @seealso \code{\link[base]{all.equal}},
#' \code{\link[base]{gsub}},
#' \code{\link[base]{gregexpr}},
#' \code{\link[base]{regmatches}},
#'\code{\link[devtools]{test}}
#' @examples
#' test_extract("\\w+", "I like candy.", list(c("I", "like", "candy")))
#' 
#' test_remove("^\\s+|\\s+$", " I like candy ", "I like candy")
#' 
#' test_split("(?<=[.?!])\\s+", "I see! When? Oh that's good.", 
#'     list(c("I see!", "When?", "Oh that's good."))) 
#'     
#' test_valid("\\w+")     
test_extract <- function(regex, input, output, stringi = FALSE){

    if (stringi){
        input2 <- stringi::stri_extract_all_regex(input, regex)
    } else {
        input2 <- regmatches(input, gregexpr(regex, input, perl = TRUE))
    }
    all.equal(input2, output)
}

#' @export
#' @rdname testing
test_remove <- function(regex, input, output, stringi = FALSE){

    if (stringi){
        input2 <- stringi::stri_replace_all_regex(input, regex, "")
    } else {
        input2 <- gsub(regex, "", input, perl = TRUE)
    }
    all.equal(input2, output)

}


#' @export
#' @rdname testing
test_split <- function(regex, input, output, stringi = FALSE){

    if (stringi){
        input2 <- stringi::stri_split_regex(input, regex)
    } else {
        input2 <- strsplit(input, regex, perl = TRUE)
    }
    all.equal(input2, output)

}




#' @export
#' @rdname testing
test_valid <- function (regex, stringi = FALSE) {

    if (stringi){
        out <- suppressWarnings(try(stringi::stri_replace_all_regex("hello", regex, ""), 
        silent = TRUE))
    } else {
        out <- suppressWarnings(try(gsub(regex, "", "hello", perl = TRUE), 
        silent = TRUE))
    }
    ifelse(inherits(out, "try-error"), FALSE, TRUE)
}
