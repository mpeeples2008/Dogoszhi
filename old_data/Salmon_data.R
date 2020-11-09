x <- read.csv('Mancos_Salmon.csv',header=T)

sites <- as.character(unique(x$Site.Name))

out <- matrix(0,length(sites),2)
colnames(out) <- c('Mancos','Dogoszhi')
rownames(out) <- sites

for (i in 1:length(sites)) {
  temp <- x[which(as.character(x$Site.Name)==sites[i]),]
  out[i,1] <- sum(temp$Count)
  
  temp2 <- temp[which(temp$Style %in% c('Dogoszhi','Chaco')),]
  out[i,2] <- sum(temp2$Count)
  
}