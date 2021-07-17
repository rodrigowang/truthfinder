#' get_prior_belief
#'
#' Auxiliary function to produce the prio beliefs selected by the user on each algorithm.
#' Algorithms do have by default some prior belief
#'
#' @param data data.table
#' @param type string
#'
#' @return
#' @export
#'
get_prior_belief <- function(data, type){
  if(type == 'fixed'){
    return(unique(data.table(object = data$object, fact = data$fact, belief = 0.5,
                             key = c('object','fact'))))
  }
  if(type == 'voted'){
    priors <- data.table(data)
    priors <- priors[, .(qtd = .N), by = .(object,fact)]
    priors[, belief := qtd/sum(qtd), by = .(object)]
    return(priors[,.(object, fact, belief)])
  }
}
