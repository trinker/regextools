context("Checking rt_msub")

test_that("rt_msub subs multiple to one",{
    
    expect_equal(
        rt_msub(c("i", "e"), c("[IE]"), "i like it when it is great."),
        "[IE] l[IE]k[IE] [IE]t wh[IE]n [IE]t [IE]s gr[IE]at."
    )
})

test_that("rt_msub subs multiple to multiple",{
    expect_equal(
        rt_msub(c("i", "e"), c("[I]", "[E]"), "i like it when it is great."),
        "[I] l[I]k[E] [I]t wh[E]n [I]t [I]s gr[E]at."
    )

})