
binary_implication <- function(f1, f2){
  ifelse(f1 == f2,0,  - 1)
}




adjust_fact_confidence <- function(dt, influence_parameter = 0.5,
                                   implication_function = NULL){
  if(is.null(implication_function)){return(dt)}
  updates <- data.table()
  for (obj in unique(dt$object)){
    # print(obj)
    ind_obj = dt$object == obj
    temp = unique(dt[ind_obj,.(object, fact, confidence)])

    for(i in 1:nrow(temp)){

      concordance <- sum(temp$confidence[-i] * influence_parameter *
                           implication_function(temp$fact[-i], temp$fact[i]))

      updates <- rbind(updates, data.frame(object = obj,
                                           fact = temp$fact[i],
                                           concordance = concordance))
    }
  }
  dt[updates, on = .(object, fact), confidence := confidence + i.concordance]
  return(dt)
}
