context("Checking testing functions")

test_that("get_extract returns logical",{
    
    expect_equal(regextools:::get_extract("\\w+", "I like candy."), list(c("I", "like", "candy")))
})

test_that("get_remove returns logical",{
    
    expect_equal(regextools:::get_remove("^\\s+|\\s+$", " I like candy "), "I like candy")

})

test_that("get_split returns logical",{
    
    expect_equal(regextools:::get_split("(?<=[.?!])\\s+", "I see! When? Oh that's good."), 
        list(c("I see!", "When?", "Oh that's good.")))    

})


