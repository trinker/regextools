context("Checking library_list")

test_that("library_list creates a .rda file",{
    
    temp <- tempdir()

    library_list(system.file("sample", package = "regextools"),
        out = file.path(temp, "sample.rda"), document = FALSE, install = FALSE)
    
    expect_true(file.exists(file.path(temp, "sample.rda")))
    unlink(file.path(temp, "sample.rda"), recursive = TRUE, force = FALSE)

})





