folder_path <- "C:/Users/anubhab.biswas/OneDrive - SUPSI/Documenti/STXGCN_Metric/" 
#change this to the folder you have cloned the repository in
  
result_folder <- paste0(folder_path,"results/")
data_folder <- paste0(folder_path,"data/")

library(Metrics)

compute_mase <- function(pollutant){
  
  names_of_months <- c("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG",
                       "SEP", "OCT", "NOV", "DEC")
  tr <- c(1441,1472,1500,1531,1561,1592,1622,1653,1684,1714,1745,1775)
  tr <- tr + 20
  D <- read.csv(paste0(data_folder,pollutant,"_Daily_Data.csv"))
  model_name <- c("HA","ARIMA","DFM","GSTAR","LSTM","STGCN","STXGCN")
  
  ha_f <- list()
  arima_f <- list()
  dfm_f <- list()
  gstar_f <- list()
  lstm_f <- list()
  stgcn_f <- list()
  stxgcn_f <- list()
  test_set <- list()
  mase_comp <- array(0,c(length(names_of_months),7,ncol(D)))
  df <- list()
  mase_mean <- list()
  
  for(i in 1:length(names_of_months)){
    ha_f[[i]] <- read.csv(paste0(result_folder,"HA/HA_",names_of_months[i],"_",pollutant,".csv"))[,-1]
    arima_f[[i]] <- read.csv(paste0(result_folder,"ARIMA/ARIMA_",names_of_months[i],"_",pollutant,".csv"))[,-1]
    dfm_f[[i]] <- read.csv(paste0(result_folder,"DFM/DFM_",names_of_months[i],"_",pollutant,".csv"))[,-1]
    gstar_f[[i]] <- read.csv(paste0(result_folder,"GSTAR/GSTAR_",names_of_months[i],"_",pollutant,".csv"))[,-1]
    lstm_f[[i]] <- read.csv(paste0(result_folder,"LSTM/LSTM_",names_of_months[i],"_",pollutant,".csv"))[,-1]
    stgcn_f[[i]] <- read.csv(paste0(result_folder,"STGCN/STGCN_",names_of_months[i],"_",pollutant,".csv"))[,-1]
    stxgcn_f[[i]] <- read.csv(paste0(result_folder,"STXGCN/STXGCN_",names_of_months[i],"_",pollutant,".csv"))[,-1]
    test_set[[i]] <- as.matrix(D[((tr[i]+1):(tr[i]+30)),])
   
    for(j in 1:ncol(D)){
      mase_comp[i,1,j] = mase((test_set[[i]])[,j],(ha_f[[i]])[,j])
      mase_comp[i,2,j] = mase((test_set[[i]])[,j],(arima_f[[i]])[,j])
      mase_comp[i,3,j] = mase((test_set[[i]])[,j],(dfm_f[[i]])[,j])
      mase_comp[i,4,j] = mase((test_set[[i]])[,j],(gstar_f[[i]])[,j])
      mase_comp[i,5,j] = mase((test_set[[i]])[,j],(lstm_f[[i]])[,j])
      mase_comp[i,6,j] = mase((test_set[[i]])[,j],(stgcn_f[[i]])[,j])
      mase_comp[i,7,j] = mase((test_set[[i]])[,j],(stxgcn_f[[i]])[,j])
      
    }
    df[[i]] <- data.frame(mase_comp[i,,])
   `rownames<-` (df[[i]],model_name)
    write.csv(df[[i]],paste0(result_folder,"MASE_stationwise_",names_of_months[i],"_",pollutant,".csv"))
    mase_mean[[i]] <- rowMeans((mase_comp[i,,]))
    mase_mean[[i]] <- cbind(model_name,mase_mean[[i]])
    mase_mean[[i]] <- data.frame(mase_mean[[i]])
    write.csv(mase_mean[[i]],paste0(result_folder,"MASE_overall_",names_of_months[i],"_",pollutant,".csv"))
  }
  
  
  
  
  
}

compute_mase("PM25")







