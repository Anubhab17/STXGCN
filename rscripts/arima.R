##ARIMA

library(forecast)

compute_arima <- function(train, h = 30, name_month = "DEC", pollutant = "PM25"){
  stopifnot(is.matrix(train))
  stopifnot(is.character(name_month))
  stopifnot(is.character(pollutant))
  arima_f <- matrix(0, h, ncol(train))
  for(i in seq(h))
  {
    for(j in 1:ncol(train)){
      arima_f[i,j] = as.vector(forecast(auto.arima((train[,i]),ic="aic"),h=h)$mean)
    }
  }
  df=data.frame(arima_f)
  write.csv(df,paste0(result_folder,"arima/" ,"ARIMA_",name_month, "_" ,pollutant ,".csv"))
}

for(k in seq(n_months)){
  compute_arima(training_data[[k]], h = 30, name_month = names_of_months[k], pollutant = "PM25")
}
