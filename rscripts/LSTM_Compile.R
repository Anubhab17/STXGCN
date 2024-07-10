library(readr)
result_LSTM = data.frame("Time" = 1:30)
month_name = "DEC"
pollutant_name = "PM25"
for(i in 1:37){
  file_name = paste0(month_name,"/","LSTM","_",month_name,"_",pollutant_name,
                     "_","V",i,".csv")
  data = read.csv(file_name)
  #col_name = paste0("V",i)
  result_LSTM = cbind(result_LSTM, data$X0)
}
result_LSTM = result_LSTM[,-1]
col_name = c(paste0("V",1:37))
colnames(result_LSTM) = col_name
write.csv(result_LSTM,paste0("LSTM_",month_name, "_" ,pollutant_name ,".csv"))
