##GSTAR

library(gstar)
library(xts)
Loc = read.csv("Data/Daily_pm25_Location.csv")
L = na.omit(Loc[,c(1,2,3)])

compute_gstar <- function(train, location, h = 30, name_month = "DEC", p = 2, d = 1, pollutant = "PM25"){
  stopifnot(is.matrix(train))
  stopifnot(is.character(name_month))
  stopifnot(is.character(pollutant))
  dst = as.matrix(dist(location), diag = T, upper = T)
  dst1 = matrix(0, nrow = nrow(dst), ncol(dst))
  for(i in 1:nrow(dst))
  {
    for(j in 1:ncol(dst))
    {
      if(j==i) next
      dst1[i,j] = sum(dst[i, -j])/sum(dst[i,])
    }
  }
  
  W_inv = matrix(0, nrow(dst), ncol(dst))
  for(i in 1:nrow(dst))
  {
    for(j in 1:ncol(dst))
    {
      if(j==i) next
      W_inv[i,j] = sum(dst1[i, j])/sum(dst1[i,])
    }
  }
  
  foreGSTAR = predict(gstar(train, weight = W_inv, p = p, d = d, est = "OLS"), n = h)
  rownames(foreGSTAR) = 1:nrow(foreGSTAR)
  write.csv(data.frame(foreGSTAR),paste0(result_folder,"GSTAR_results/" ,"GSTAR_",name_month, "_" ,pollutant ,".csv"))
}

for(k in seq(n_months)){
  compute_gstar(train = train_valid_comb_data[[k]], location = L, h = 30, p = 2, d = 1, name_month = names_of_months[k], pollutant = "PM25")
}
