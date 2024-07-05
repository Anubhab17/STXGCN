##Create training datasets

data_folder <- "C:/Users/anubhab.biswas/OneDrive - SUPSI/Documenti/"
D <- as.matrix(read.csv(paste0(data_folder,"STXGCN/Data/PM25_Daily_Data.csv")))
result_folder <- paste0(data_folder,"STXGCN/results/")

n_months <- 12
names_of_months <- c("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG",
                     "SEP", "OCT", "NOV", "DEC")
tr <- c(1441,1472,1500,1531,1561,1592,1622,1653,1684,1714,1745,1775)

training_data <- list()

for(k in seq(n_months)){
  training_data[[k]] = D[1:tr[k],]
}

