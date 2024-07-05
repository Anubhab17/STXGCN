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
  write.csv(df,paste0(result_folder,"DFM_",name_month, "_" ,pollutant ,".csv"))
}

for(k in seq(n_months)){
  compute_dfm(training_data[[k]], h = 30, r = 1,p = 10, name_month = names_of_months[k], pollutant = "PM25")
}








PM2.5=read.csv("/content/pm2.5_dec_data.csv")
PM2.5=as.matrix(PM2.5)
n=37572+36
test=PM2.5[(n+1):(n+48),]
T=PM2.5[1:n,]


d=diff(T,1)
model1=DFM(d,r=1,p=10)

fc=predict(model1,h=12)
fore=fc$X_fcst


F1=matrix(0,12,ncol(T))
F1[1,]=fore[1,]+PM2.5[n,]
for(i in 2:12)
{
  F1[i,]=F1[i-1,]+fore[i,]
}

T2=rbind(T[-(1:12),],test[1:12,])

d=diff(T2,1)
model1=DFM(d,r=1,p=10)

fc=predict(model1,h=12)
fore=fc$X_fcst
F2=matrix(0,12,ncol(T))
F2[1,]=fore[1,]+PM2.5[n+12,]
for(i in 2:12)
{
  F2[i,]=F2[i-1,]+fore[i,]
}


T3=rbind(T[-(1:24),],test[1:24,])

d=diff(T3,1)
model1=DFM(d,r=1,p=10)

fc=predict(model1,h=12)
fore=fc$X_fcst
F3=matrix(0,12,ncol(T))
F3[1,]=fore[1,]+PM2.5[n+24,]
for(i in 2:12)
{
  F3[i,]=F3[i-1,]+fore[i,]
}

T4=rbind(T[-(1:36),],test[1:36,])

d=diff(T4,1)
model1=DFM(d,r=1,p=10)

fc=predict(model1,h=12)
fore=fc$X_fcst
F4=matrix(0,12,ncol(T))
F4[1,]=fore[1,]+PM2.5[n+48,]
for(i in 2:12)
{
  F4[i,]=F4[i-1,]+fore[i,]
}


F=rbind(F1,F2,F3,F4)
df=data.frame(F)
write.csv(df,"APR_mid_DFM rolling PM25.csv")

