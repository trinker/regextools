context("Checking library_template")

test_that("library_template creates a library package with correct components",{
    
    regex_lib <- file.path(tempdir(), "DELETE_ME")
    suppressMessages(library_template(regex_lib))
    expect_true(file.exists(regex_lib))
    expect_true(file.exists(file.path(regex_lib, "README.md")))
    expect_true(file.exists(file.path(regex_lib, "tests")))
    expect_true(file.exists(file.path(regex_lib, "tests/testthat")))
    expect_true(file.exists(file.path(regex_lib, "tests/testthat.R")))
    expect_true(file.exists(file.path(regex_lib, "DESCRIPTION")))
    expect_true(file.exists(file.path(regex_lib, "NEWS")))
    expect_true(file.exists(file.path(regex_lib, "travis.yml")))
    unlink(regex_lib, recursive = TRUE, force = FALSE)

})



