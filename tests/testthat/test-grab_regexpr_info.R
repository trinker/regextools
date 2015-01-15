context("Checking grab_regexpr_info")

test_that("grab_regexpr_info grabs infor from a roxygen2/devtools style package",{
    
    out <- structure(list(title = structure(list(title = "Abbreviations"), .Names = "title"), 
            description = structure(list(description = "Find abbreviates that contain capitals or or lower case. Must have at minimum 1 letter followed by a period folowed by another letter and period. May contain additional letters and spaces."), .Names = "description"), 
            details = structure(list(details = NA), .Names = "details"), 
            examples = structure(list(examples = "\ninput <- c(\"I want $2.33 at 2:30 p.m. to go to A.n.p.\",\n    \"She will send it A.S.A.P. (e.g. as soon as you can) said I.\",\n    \"Hello world.\", \"In the U. S. A.\")\n\nregmatches(input, gregexpr(rm_abbreviation, input, perl = TRUE))\ngsub(rm_abbreviation, \"\", input, perl = TRUE)\nstrsplit(input, rm_abbreviation, perl = TRUE)\n"), .Names = "examples"), 
            regexpr = structure(list(regexpr = "rm_abbreviation"), .Names = "regexpr")), .Names = c("title", 
        "description", "details", "examples", "regexpr"), row.names = c(NA, 
        -1L), class = "data.frame")
    
    expect_equal(grab_regexpr_info(system.file("sample", package = "regextools")), out)
    
})