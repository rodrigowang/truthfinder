#' investment
#' Implement investment algorithm.  In the Investment algorithm, sources “invest”
#' their trustworthiness uniformly among their claims. The belief in each claim is
#' a non-linear function of g, normally 1.2, and the source’s trustworthiness is
#' updated as the sum of the beliefs in their claims, weighted by the proportion
#' of trust invested by all sources in the claim.
#' Since claims with higher-trust sources get higher belief, these claims become
#' relatively more believed and their sources become more trusted.
#'
#' @param data data.table
#' @param limit numeric
#' @param g numeric
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
#' investment(data)
#' @importFrom data.table ":="
investment <- function(data, limit = 0.001, g = 1.2, max_iter = 20){

  dt <- data.table::data.table(data)
  dt[, n_claims := .N, by = source]
  dt[,source_trust := 1]
  claims <- get_prior_belief(dt, type = 'voted')
  dt[claims, on = .(object, fact), claim_belief := belief]


  it <- TRUE
  iter <- 1
  while(it == TRUE){

    dt[, invested_amount := source_trust/n_claims]
    dt[, claim_inv_received := 1/sum(invested_amount), .(object, fact)]
    dt[, new_source_trust := sum(invested_amount * claim_inv_received * claim_belief), by = source]

    dt[, new_claim_belief := sum(new_source_trust/n_claims)^g, by = .(object, fact)]


    dt[, new_source_trust := new_source_trust/max(new_source_trust)]
    dt[, new_claim_belief := new_claim_belief/max(new_claim_belief)]

    if(sum(abs(dt$source_trust - dt$new_source_trust)) < limit | iter >= max_iter){
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
