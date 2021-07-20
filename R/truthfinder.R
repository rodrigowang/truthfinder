#' Title
#'
#' @param data
#' @param limit
#' @param max_iter
#' @param damping_factor
#' @param influence_parameter
#' @param initial_trust
#' @param similarity
#'
#' @return
#' @export
#'
#' @examples
truthfinder <- function(data, limit = 0.001, max_iter = 20,
                        damping_factor = 0.3,
                        influence_parameter = 0.5,
                        initial_trust = 0.9,
                        implication_function = NULL){

  dt <- data.table::data.table(data)
  dt[, n_claims := .N, by = source]
  dt[,source_trust := initial_trust]
  dt[, claim_belief := 0]
  it <- TRUE
  iter <- 1
  while(it == TRUE){
    #calculate log trust
    dt[,log_source_trust := - log(1 - source_trust)]
    ##update fact confidence
    dt[, confidence := sum(log_source_trust), by = .(object, fact)]
    ##update confidence with similarity
    dt = adjust_fact_confidence(dt, implication_function = implication_function,
                                influence_parameter = influence_parameter)
    ##adjust the fact confidence score
    dt[, new_claim_belief := 1 / (1 + exp(-damping_factor * confidence))]


    ##Update source trust
    dt[, new_source_trust := sum(new_claim_belief)/n_claims, by = source]


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
