test_that("pooled investment works", {
  data = data.frame(source = c('source1','source1','source2','source2','source3','source3','source4',
                               'source4','source4'),
                    object = c('x','y','y','z','x','z','x','y','z'),
                    fact = c('4','7','7','5','3','5','3', '6','8'))
  res = pooled_investment(data, max_iter = 5)
  expect_equal(res$res$claim_belief,
               c(0.0132772907248118, 0.564191716911328, 0.564191716911328, 1,
                 0.586224817802235, 1, 0.586224817802235, 0.00540546506778945,
                 0.00262911814816507),
               tolerance = .002)
})
