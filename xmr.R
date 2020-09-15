set.seed(123)

dt <- data.frame(id = seq(30),
                 val = rnorm(30, 30,5))

#dt$val[10] <- dt$val[10] +10
dt$val[11] <- dt$val[11] +20

dt$lag <- Hmisc::Lag(dt$val, -1)
dt$mr <- abs(dt$val-dt$lag)
mean_s <- mean(dt$val)
mean_mr <- mean(na.omit(dt$mr))

UCL <- mean_s + (3*mean_mr / 1.128)
LCL <- mean_s - (3*mean_mr / 1.128)

dt$rule <- ifelse(dt$val>UCL,1,ifelse(dt$val<LCL,3,2))

library(ggplot2)

ggplot(dt, aes(x=id, y=val))+
  geom_point(aes(col=factor(rule)))+
  geom_line()+
  geom_hline(yintercept=mean_s, col="red")+
  geom_hline(yintercept=UCL, col="dodgerblue2")+
  geom_hline(yintercept=LCL, col="purple")

