library(data.table)
#' Majority Voting
#'
#'  Baseline truth discovery method, where the belief that X takes value v is
#'  simply the number of sources who makes that assertion. Sources are
#'  considered to be equally trustworthy.
#'
#' @param data data.frame
#'
#' @return list
#' @export
#'
#' @examples
#' data = data.frame(source = c('source1','source1','source2','source2','source3','source3','source4',
#' 'source4','source4'),
#' object = c('x','y','y','z','x','z','x','y','z'),
#' fact = c('4','7','7','5','3','5','3', '6','8'))
#' majority_voting(data)
#'
#' @importFrom data.table ":="
majority_voting <- function(data){

  DT = data.table::data.table(data)
  DT[, qtt := .N, by=.(object,fact)]
  DT[, total := .N, by = .(object)]
  DT[, claim_belief := qtt/total, by = .(object)]

  return (list(
    res = DT,
    iter = 0
  ))
}
