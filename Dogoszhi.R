x <- read.csv('Apportioning.csv',header=T)
z <- read.csv('Ceramic_type_master.csv',header=T)
ty <- read.csv('types.csv',header=T)
zdec <- z[which(z$SWSN_Type %in% ty$SWSN_Type),]
#zdec <- zdec[which(zdec$Decoration %in% c('bichrome','polychrome','undifferentiated dec')),]
#zdec <- read.csv('zdec.csv',header=T)
#zdec <- zdec[which(zdec$Include==1),]
z2 <- zdec[which(zdec$Dogozshi==1),]

sites <- as.vector(unique(x$Site))

out.mat <- matrix(NA,length(sites),5)

for (i in 1:length(sites)) {
  temp <- x[which(x$Site==sites[i]),]
  t2 <- 0
  t2 <- sum(temp[,16:17])
  t3 <- 0
  if (length(which(temp$Type %in% z2$SWSN_Type) >0)) {
    t3 <- sum(temp[which(temp$Type %in% z2$SWSN_Type),16:17])}
  t4 <- 0
  if (length(which(temp$Type %in% c('Mancos Black-on-white'))>0)){
    t4 <- sum(temp[which(temp$Type %in% c('Mancos Black-on-white')),16:17])}
  
  out.mat[i,1] <- as.character(temp[1,2])
  out.mat[i,2] <- as.character(temp[1,3])
  out.mat[i,3] <- t2
  out.mat[i,4] <- t3
  out.mat[i,5] <- t4
}

out.mat <- as.data.frame(out.mat)
colnames(out.mat) <- c('SWSN_ID','Site','All','Dogoszhi','Mancos')

write.csv(out.mat,file='out_mat.csv')

v <- read.csv('out_mat.csv',header=T)


plot(v$Dogoszhi/v$All,v$Mancos/v$Dogoszhi)

v$prop <- v$Dogoszhi/v$All

xx <- v[order(v$prop,decreasing=T),]

xx