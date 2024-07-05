library(evmix)

fit_pot_estimates <- function(train, u, name_month = "DEC", pollutant = "PM25"){
  stopifnot(is.matrix(train))
  stopifnot(is.character(name_month))
  stopifnot(is.character(pollutant))
  alpha=c()
  sig=c()
  for(i in seq(ncol(train)))
  {
    
    alpha[i]=fgpd(train[,i],u)$xi
    sig[i]=fgpd(train[,i],u)$sigmau
    
  }
  df=data.frame(cbind(alpha,sig))
  write.csv(df,paste0(result_folder,"PoT_Estimates_",name_month, "_" ,pollutant ,".csv"))
}


u_pm25 <- 60
for(j in seq(n_months)){
  fit_pot_estimates(training_data[[j]], u_pm25, name_month = names_of_months[j], pollutant = "PM25")
}
