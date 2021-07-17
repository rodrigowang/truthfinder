test_that("Sums algorithm works", {
  library(data.table)
  data = data.frame(source = c('source1','source1','source2','source2','source3','source3','source4',
                               'source4','source4'),
                    object = c('x','y','y','z','x','z','x','y','z'),
                    fact = c('4','7','7','5','3','5','3', '6','8'))
  res = Sums(data, max_iter = 20)
  expect_equal(res$res$claim_belief,
               c(1, 1, 0.185498592062133, 0.531810070918643, 0.533597813708339,
                 0.533597813708339, 0.816289150727564, 0.816289150727564,
                 0.531810070918643),
               tolerance = .002)
})
