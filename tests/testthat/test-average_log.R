test_that("Average Log algorithm works", {
  library(data.table)
  data = data.frame(source = c('source1','source1','source2','source2','source3','source3','source4',
                               'source4','source4'),
                    object = c('x','y','y','z','x','z','x','y','z'),
                    fact = c('4','7','7','5','3','5','3', '6','8'))
  res = average_log(data, max_iter = 20)
  expect_equal(res$res$claim_belief,
               c(1, 1, 0.149347618712353, 0.565474368254407, 0.444484643041074,
                 0.444484643041074, 0.729662656074313, 0.729662656074313,
                 0.565474368254407),
               tolerance = .002)
})
