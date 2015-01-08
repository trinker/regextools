#' Does Expression Extract/Remove/Split as Expected?
#' 
#' A logical test of a regular expression's extraction, removal, splitting 
#' results.  These functions are useful for unit testing of regular expressions.
#' 
#' @param regex A regular expression to test.
#' @param input The intput string(s) to extract/remove/split from.
#' @param output The desired output of: 
#' \describe{
#'   \item{extract}{\code{regmatches(input, gregexpr(regex, input, perl = TRUE))}}
#'   \item{remove}{\code{gsub(regex, "", input, perl = TRUE)}}
#'   \item{split}{\code{strsplit(input, regex, perl = TRUE)}}
#' }
#' @return Returns the results of \code{\link[base]{all.equal}} for the 
#' \code{input} and desired \code{output}.
#' @keywords test extract remove
#' @details These functions are inspired by Hadely Wickham's \pkg{testthat} 
#' package.  They can be used with \code{\link[regextools]{test_library}} to test 
#' that regular expressions are extracting, removing, and splitting as 
#' exprected.  The user may create their own tests and utilize 
#' \code{\link[base]{all.equal}} to ensure the expression is acting as desired.
#' @export
#' @rdname testing
#' @seealso \code{\link[base]{all.equal}},
#' \code{\link[base]{gsub}},
#' \code{\link[base]{gregexpr}},
#' \code{\link[base]{regmatches}},
#' \code{\link[regextools]{test_library}}
#' @examples
#' test_extract("\\w+", "I like candy.", list(c("I", "like", "candy")))
#' 
#' test_remove("^\\s+|\\s+$", " I like candy ", "I like candy")
#' 
#' test_split("(?<=[.?!])\\s+", "I see! When? Oh that's good.", 
#'     list(c("I see!", "When?", "Oh that's good."))) 
test_extract <- function(regex, input, output){

    input2 <- regmatches(input, gregexpr(regex, input, perl = TRUE))
    all.equal(input2, output)

}

#' @export
#' @rdname testing
test_remove <- function(regex, input, output){

    input2 <- gsub(regex, "", input, perl = TRUE)
    all.equal(input2, output)

}


#' @export
#' @rdname testing
test_split <- function(regex, input, output){

    input2 <- strsplit(input, regex, perl = TRUE)
    all.equal(input2, output)

}


