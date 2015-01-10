context("Checking testing functions")

test_that("test_extract returns logical",{
    
    expect_true(test_extract("\\w+", "I like candy.", list(c("I", "like", "candy"))))
    expect_equal(test_extract("\\w+", "I like candy.", list(c("I", "xxx", "candy"))),
        "Component 1: 1 string mismatch")

})

test_that("test_remove returns logical",{
    
    expect_true(test_remove("^\\s+|\\s+$", " I like candy ", "I like candy"))
    expect_equal(test_remove("^\\s+|\\s+$", " I like candy ", "I xxx candy"),
        "1 string mismatch")

})

test_that("test_split returns logical",{
    
    expect_true(test_split("(?<=[.?!])\\s+", "I see! When? Oh that's good.", 
        list(c("I see!", "When?", "Oh that's good."))))    
    expect_equal(test_split("(?<=[.?!])\\s+", "I see! When? Oh that's good.", 
        list(c("I see!", "xxx", "Oh that's good."))),
        "Component 1: 1 string mismatch") 
})

test_that("test_is.regex as expected",{
    
    expect_true(test_is.regex("\\w+"))    
    expect_false(test_is.regex("(\\w")) 
})


