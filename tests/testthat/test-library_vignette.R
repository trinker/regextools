context("Checking library_vignette")

test_that("library_tvignette creates a .Rmd document",{
    
    temp1 <- tempdir()
    library_vignette(system.file("sample", package = "regextools"), file.path(temp1, "vignette"),
        is.vignette = FALSE, include.html = FALSE, document = FALSE, install = FALSE)
    
    expect_true(file.exists(file.path(temp1, "vignette/sample.Rmd")))
    unlink(file.path(temp1, "vignette"), recursive = TRUE, force = FALSE)

})






