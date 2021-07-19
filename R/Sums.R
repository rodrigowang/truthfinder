#' Sums
#' Implement Sums algorithm
#'
#' @param data data.table
#' @param limit numeric
#' @param max_iter numeric
#'
#' @return list
#' @export
#'
#' @examples
#' data = data.frame(source = c('source1','source1','source2','source2','source3','source3','source4',
#' 'source4','source4'),
#' object = c('x','y','y','z','x','z','x','y','z'),
#' fact = c('4','7','7','5','3','5','3', '6','8'))
#' Sums(data)
#' @importFrom data.table ":="
Sums <- function(data, limit = 0.001, max_iter = 20){
  dt <- data.table::data.table(data, key = c('object','fact'))
  dt[, n_claims := .N, by = source]
  dt[,source_trust := 0]
  claims <- get_prior_belief(dt, type = 'fixed')
  dt[claims, on = .(object, fact), claim_belief := belief]

  it <- TRUE
  iter <- 1
  while(it == TRUE){

    dt[, new_source_trust := sum(claim_belief), by = .(source)]
    dt[, new_claim_belief := sum(new_source_trust), by = .(object, fact)]

    dt[, new_source_trust := new_source_trust/max(new_source_trust)]
    dt[, new_claim_belief := new_claim_belief/max(new_claim_belief)]

    trust <- unique(dt[,.(source, source_trust, new_source_trust)])
    if(sum(abs(trust$source_trust - trust$new_source_trust)) < limit |  iter >= max_iter){
      it = FALSE
      break
    }

    dt$source_trust = dt$new_source_trust
    dt$claim_belief = dt$new_claim_belief
    iter <- iter + 1
  }

  return (list(res = dt,
               iter = iter))
}
