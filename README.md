
<!-- README.md is generated from README.Rmd. Please edit that file -->

**NOTE: This is a package to apply algorithms of truth discovery
<https://en.wikipedia.org/wiki/Truth_discovery> and
<https://arxiv.org/abs/1409.6428> and
<https://www.semanticscholar.org/paper/Knowing-What-to-Believe-(when-you-already-know-Pasternack-Roth/579e1e9217cfed6d563cedf8f8fdcd1604fc0917>**

# truthfinder

<!-- badges: start -->

<!-- badges: end -->

Determine the veracity of multi-source data in order to resolve
conflicts.

## Installation

You can install truthfinder like so:

``` r
devtools::install_github("rodrigowang/truthfinder")
```

## Quick demo

Use majority voting algorithm `majority_voting()`:

``` r
library(truthfinder)
data = data.frame(source = c('source1','source1','source2','source2','source3','source3','source4',
                             'source4','source4'),
                  object = c('x','y','y','z','x','z','x','y','z'),
                  fact = c('4','7','7','5','3','5','3', '6','8'))
res = majority_voting(data)
```

The function returns a list with two elements. A data.table containing
the resulted claim belief and the source trust and an integer indicating
the number of iteractions it used do get the results.
