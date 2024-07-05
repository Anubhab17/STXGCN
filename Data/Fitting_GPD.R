library(evmix)

data_folder <- "C:/Users/anubhab.biswas/OneDrive - SUPSI/Documenti/"
D <- as.matrix(read.csv(paste0(data_folder,"STXGCN/Data/PM25_Daily_Data.csv")))

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
  write.csv(df,paste0(data_folder,"STXGCN/Data/","PoT_Estimates_",name_month, "_" ,pollutant ,".csv"))
}


n_months <- 12
names_of_months <- c("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG",
                     "SEP", "OCT", "NOV", "DEC")
tr <- c(1441,1472,1500,1531,1561,1592,1622,1653,1684,1714,1745,1775)

training_data <- list()

for(k in seq(n_months)){
  training_data[[k]] = D[1:tr[k],]
}

u_pm25 <- 60
for(j in seq(n_months)){
  fit_pot_estimates(training_data[[j]], u_pm25, name_month = names_of_months[j], pollutant = "PM25")
}




