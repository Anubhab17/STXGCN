##HA

compute_ha <- function(train, h = 30, name_month = "DEC", pollutant = "PM25"){
  stopifnot(is.matrix(train))
  stopifnot(is.character(name_month))
  stopifnot(is.character(pollutant))
  ha <- matrix(0, h, ncol(train))
  for(i in seq(h))
  {
    for(j in 1:ncol(train)){
      ha[i,j] = mean(train[(nrow(train)-12):nrow(train),j])
    }
  }
  df=data.frame(ha)
  write.csv(df,paste0(result_folder,"HA_",name_month, "_" ,pollutant ,".csv"))
}

for(k in seq(n_months)){
  compute_ha(training_data[[k]], h = 30, name_month = names_of_months[k], pollutant = "PM25")
}

