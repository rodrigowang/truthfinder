test_that("investment algorithm works", {
  library(data.table)
  data = data.frame(source = c('source1','source1','source2','source2','source3','source3','source4',
                               'source4','source4'),
                    object = c('x','y','y','z','x','z','x','y','z'),
                    fact = c('4','7','7','5','3','5','3', '6','8'))
  res = investment(data, max_iter = 20)
  expect_equal(res$res$claim_belief,
               c(0.0117243468143135, 0.459698144479884, 0.459698144479884, 1,
                 0.438573124236826, 1, 0.438573124236826, 0.000518118364471912,
                 0.000518118364471912),
               tolerance = .002)
})
