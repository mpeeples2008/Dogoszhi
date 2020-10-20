sites <- as.vector(unique(x$Site))

out.mat <- matrix(NA,length(sites),5)

for (i in 1:length(sites)) {
  temp <- x[which(x$Site==sites[i]),]
  t2 <- 0
  t2 <- sum(temp[,7:ncol(temp)])
  t3 <- 0
  if (length(which(temp$Type %in% z2$SWSN_Type) >0)) {
    t3 <- sum(temp[which(temp$Type %in% z2$SWSN_Type),7:ncol(temp)])}
  t4 <- 0
  if (length(which(temp$Type=='Mancos Black-on-white')>0)){
    t4 <- sum(temp[which(temp$Type=='Mancos Black-on-white'),7:ncol(temp)])}
  
  out.mat[i,1] <- as.character(temp[1,2])
  out.mat[i,2] <- as.character(temp[1,3])
  out.mat[i,3] <- t2
  out.mat[i,4] <- t3
  out.mat[i,5] <- t4
}

out.mat <- as.data.frame(out.mat)
colnames(out.mat) <- c('SWSN_ID','Site','All','Dogoszhi','Mancos')

write.csv(out.mat,file='out_mat.csv')

v <- read.csv
