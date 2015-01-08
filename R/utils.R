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
