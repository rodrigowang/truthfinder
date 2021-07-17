test_that("multiplication works", {
  data = data.frame(source = c('source1','source1','source2','source2','source3','source3','source4',
                               'source4','source4'),
                    object = c('x','y','y','z','x','z','x','y','z'),
                    fact = c('4','7','7','5','3','5','3', '6','8'))
  res = majority_voting(data)
  expect_equal(res$res$claim_belief, c(0.3333333, 0.6666667, 0.6666667,
                          0.6666667, 0.6666667, 0.6666667,
                          0.6666667, 0.3333333, 0.3333333),
                   tolerance = .002)
})
