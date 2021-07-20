test_that("truthfinder default", {
  data <- data.frame(source = c('a','a','b','b','c','c','d','d','d','e','e','e'),
                     object = c('e1','e2','e1','e3','e2','e3','e1','e2','e3','e1','e2','e3'),
                     fact = c('1','4','1','3','4','3','1','3','2','1','2','3'))
  res = truthfinder(data, max_iter = 5)
  expect_equal(res$res$claim_belief,
               c(0.86026593317889, 0.715559626671818, 0.86026593317889, 0.808375188896792,
                 0.715559626671818, 0.808375188896792, 0.86026593317889, 0.58488838789443,
                 0.58488838789443, 0.86026593317889, 0.607562596781994, 0.808375188896792),
               tolerance = .002)
})

test_that("truthfinder with parameters", {
  data <- data.frame(source = c('a','a','b','b','c','c','d','d','d','e','e','e'),
                     object = c('e1','e2','e1','e3','e2','e3','e1','e2','e3','e1','e2','e3'),
                     fact = c('1','4','1','3','4','3','1','3','2','1','2','3'))
  res = truthfinder(data, max_iter = 5,
                    damping_factor = 0.8,
                    influence_parameter = 0.6)
  expect_equal(res$res$claim_belief,
               c(1, 0.999999999999998, 1, 1, 0.999999999999998, 1, 1, 0.883613177435389,
                 0.883613177435389, 1, 0.970776763002556, 1),
               tolerance = .002)
})


test_that("truthfinder with binary implication works", {
  data <- data.frame(source = c('a','a','b','b','c','c','d','d','d','e','e','e'),
                     object = c('e1','e2','e1','e3','e2','e3','e1','e2','e3','e1','e2','e3'),
                     fact = c('1','4','1','3','4','3','1','3','2','1','2','3'))
  res = truthfinder(data, max_iter = 5,
                    implication_function = binary_implication,
                    damping_factor = 0.8,
                    influence_parameter = 0.6)
  expect_equal(res$res$claim_belief,
               c(0.999999992204397, 0.99999843055603, 0.999999992204397, 0.999999986821861,
                 0.99999843055603, 0.999999986821861, 0.999999992204397, 0.000173081798401466,
                 2.30437957398162e-05, 0.999999992204397, 0.00042442547495276,
                 0.999999986821861),
               tolerance = .002)
})


test_that("truthfinder with defined implication works", {
  data <- data.frame(source = c('a','a','b','b','c','c','d','d','d','e','e','e'),
                     object = c('e1','e2','e1','e3','e2','e3','e1','e2','e3','e1','e2','e3'),
                     fact = c('1','4','1','3','4','3','1','3','2','1','2','3'))
  new_f <- function(f1, f2){
    ifelse(f1 == f2,0,  - 10)
  }
  res = truthfinder(data, max_iter = 5,
                    implication_function = new_f,
                    damping_factor = 0.8,
                    influence_parameter = 0.6)
  expect_equal(res$res$claim_belief,
               c(0.888662884249818, 0.0230191813516698, 0.888662884249818, 0.469310132701043,
                 0.0230191813516698, 0.469310132701043, 0.888662884249818, 0.00126375250102444,
                 0.00013199618082356, 0.888662884249818, 0.00468871021783079,
                 0.469310132701043),
               tolerance = .002)
})
