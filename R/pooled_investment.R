#' Pooled investment algorithm
#'
#' @param data
#' @param limit
#' @param g
#' @param max_iter
#'
#' @return
#' @export
#'
#' @examples
pooled_investment <- function(data, limit = 0.001, g = 1.4, max_iter = 20){

  dt <- data.table::data.table(data)
  dt[, n_claims := .N, by = source]
  dt[,source_trust := 1]
  claims <- get_prior_belief(dt, type = 'uniform')
  dt[claims, on = .(object, fact), claim_belief := belief]


  it <- TRUE
  iter <- 1
  while(it == TRUE){

    dt[, invested_amount := source_trust/n_claims]
    dt[, claim_inv_received := 1/sum(invested_amount), .(object, fact)]
    dt[, new_source_trust := sum(invested_amount * claim_inv_received * claim_belief), by = source]

    dt[, hic := sum(new_source_trust/n_claims), by = .(object, fact)]
    dt[, hic_g := hic^g]
    sum_mut_exc <- dt[,.(hic_g = unique(hic_g)), by = .(object, fact)]
    sum_mut_exc[, sum_hic_g := sum(hic_g), by = .(object)]
    # print(sum_mut_exc)
    dt[sum_mut_exc, on = .(object, fact), sum_hic_g := i.sum_hic_g]
    dt[, new_claim_belief := hic * (hic_g)/(sum_hic_g), by = .(object)]

    dt[, new_source_trust := new_source_trust/max(new_source_trust)]
    dt[, new_claim_belief := new_claim_belief/max(new_claim_belief)]

    if(sum(abs(dt$source_trust - dt$new_source_trust)) < limit | iter >= max_iter){
      dt$source_trust = dt$new_source_trust
      dt$claim_belief = dt$new_claim_belief
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
