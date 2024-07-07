##DFM
library(dfms)

compute_dfm <- function(train, h = 30, name_month = "DEC",r=1, p=10, pollutant = "PM25"){
  stopifnot(is.matrix(train))
  stopifnot(is.character(name_month))
  stopifnot(is.character(pollutant))
  dfm_f = matrix(0, h, ncol(train))
  dfm <- data.frame(predict(DFM(diff(train,1),r=r,p=p), h=h)$X_fcst)
  dfm_f[1,] = as.matrix(dfm[1,], nrow = 1) + matrix(train[nrow(train),], nrow = 1)
  for(i in 2:h){
    dfm_f[i,] = as.matrix(dfm_f[i - 1,] + dfm[i,])
  }
  write.csv(data.frame(dfm_f),paste0(result_folder,"DFM10_results/" ,"DFM_",name_month, "_" ,pollutant ,".csv"))
}

for(k in seq(n_months)){
  compute_dfm(train_valid_comb_data[[k]], h = 30, r=1, p=10, name_month = names_of_months[k], pollutant = "PM25")
}