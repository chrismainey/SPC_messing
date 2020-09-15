library(data.table)
library(ggplot2)

xmr <-
  function(x, index){
    lag <- shift(x, n=1)
    mr <- abs(x-lag)
    mean_s <- mean(x)
    mean_mr <- mean(na.omit(mr))
    
    UCL <- mean_s + (3*mean_mr / 1.128)
    LCL <- mean_s - (3*mean_mr / 1.128)
    
    rule <- ifelse(x>UCL,1,ifelse(x<LCL,3,2))
    
    ggplot(data.frame(index, x), aes(x=index, y=x))+
      geom_point(aes(col=factor(rule)))+
      geom_line()+
      geom_hline(yintercept=mean_s, col="red")+
      geom_hline(yintercept=UCL, col="dodgerblue2")+
      geom_hline(yintercept=LCL, col="purple")
  }

set.seed(123)

dt <- data.frame(id = seq(30),
                 val = rnorm(30, 30,5))

#dt$val[10] <- dt$val[10] +10
dt$val[11] <- dt$val[11] +20

xmr(x=dt$val, index=dt$id)
