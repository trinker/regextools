context("Checking library_vignette")

test_that("library_vignette creates a .Rmd document",{
    
#    temp1 <- tempdir()
#    library_vignette(system.file("sample", package = "regextools"), file.path(temp1, "vignette"),
#        is.vignette = FALSE, include.html = FALSE, document = FALSE, install = FALSE)

#    expect_true(file.exists(file.path(temp1, "vignette/sample.Rmd")))
#    unlink(file.path(temp1, "vignette"), recursive = TRUE, force = FALSE)

})


test_that("library_vignette creates a .html & md document",{
    
#    temp2 <- tempdir()
#    library_vignette(system.file("sample", package = "regextools"), file.path(temp2, "vignette"),
#        is.vignette = FALSE, include.html = TRUE, include.md = TRUE, document = FALSE, install = FALSE)
    
#    expect_true(all(file.exists(file.path(temp2, paste0("vignette/sample.", c("Rmd", "html", "md"))))))
#    unlink(file.path(temp2, "vignette"), recursive = TRUE, force = FALSE)
})




