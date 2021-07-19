test_that("truthfinder works", {
  data = data.frame(source = c('source1','source1','source2','source2','source3','source3','source4',
                               'source4','source4'),
                    object = c('x','y','y','z','x','z','x','y','z'),
                    fact = c('4','7','7','5','3','5','3', '6','8'))
  res = truthfinder(data, max_iter = 10)
  expect_equal(res$res$claim_belief,
               c(0.569567840174903, 0.644085086485248, 0.644085086485248, 0.65132260942535,
                 0.641172079646889, 0.65132260942535, 0.641172079646889, 0.566760945796511,
                 0.566760945796511),
               tolerance = .002)
})
