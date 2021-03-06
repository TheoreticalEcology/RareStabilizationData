#calculate observed growth rates:

log lambda function
lambda=function(file) {
if(file[i+1,x]==0 | file[i,x]==0){
  r=NA
}else{
  r=log(file[i+1,x]/file[i,x])
}
return(r)
}

#data: 5plarrea
abund=read.table("5plarrea.txt",header=T)
energy=read.table("5plarrea_E.txt",header=T)
lastyear=2005

#calc rel. E
relE=energy[,5:8]/energy[,4]
relE=relE[which(energy[,1]!=lastyear),]


#calc lambda
rates=matrix(data=NA,nrow=length(abund[,1])-1,ncol=length(abund[1,]))
for(i in 1:(length(abund[,1])-1)) {
  for(x in 1:length(abund[1,])) {
    rates[i,x]=lambda(abund)
  }
}
rates=rates[which(abund[,1]!=lastyear),]

plot(relE[,1],rates[,5],xlim=c(0,1),ylim=c(-3,3),main="5plarrea",xlab="relative E",ylab="log lambda")
points(relE[,2],rates[,6],pch=2,col=2)
points(relE[,3],rates[,7],pch=3,col=3)
abline(h=0,col="grey")

abline(lm(rates[,5]~relE[,1]),col=1)
abline(lm(rates[,6]~relE[,2]),col=2)
abline(lm(rates[,7]~relE[,3]),col=3)

legend(x=0.9,y=3,legend=c('dime','disp','pgfv'),col=1:3,pch=1:3)

cor.test(relE[,1],rates[,5])
cor.test(relE[,2],rates[,6])
cor.test(relE[,3],rates[,7])


