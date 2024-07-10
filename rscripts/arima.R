##ARIMA

library(forecast)

compute_arima <- function(train, h = 30, name_month = "DEC", pollutant = "PM25"){
  stopifnot(is.matrix(train))
  stopifnot(is.character(name_month))
  stopifnot(is.character(pollutant))
  arima_f <- matrix(0, h, ncol(train))
  for(j in 1:ncol(train))
  {
      arima_f[,j] = as.vector(predict(arima(train[,j],order = c(4, 0, 2)),n.ahead=h)$pred)
  }
  df=data.frame(arima_f)
  write.csv(df,paste0(result_folder,"Arima402/" ,"ARIMA_",name_month, "_" ,pollutant ,".csv"))
}

for(k in seq(n_months)){
  compute_arima(train_valid_comb_data[[k]], h = 30, name_month = names_of_months[k], pollutant = "PM25")
}