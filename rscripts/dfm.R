##DFM

library(dfms)

compute_dfm <- function(train, h = 30, r = 1, p = 10, name_month = "DEC", pollutant = "PM25"){
  stopifnot(is.matrix(train))
  stopifnot(is.character(name_month))
  stopifnot(is.character(pollutant))
  dfm_f <- matrix(0, h, ncol(train))
  for(i in seq(h))
  {
    for(j in 1:ncol(train)){
      d=diff(train,1)
      model_dfm=DFM(d,r=r,p=p)
      fc=predict(model1,h=h)
      fore=fc$X_fcst
      dfm_f[1,]=fore[1,]+PM2.5[n,]
      for(i in 2:h)
      {
        dfm_f[i,]=dfm_f[i-1,]+fore[i,]
      }
    }
  }
  df=data.frame(dfm_f)
  write.csv(df,paste0(result_folder,"dfm/" ,"DFM_",name_month, "_" ,pollutant ,".csv"))
}

for(k in seq(n_months)){
  compute_dfm(training_data[[k]], h = 30, r = 1,p = 10, name_month = names_of_months[k], pollutant = "PM25")
}

