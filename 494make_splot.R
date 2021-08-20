#makes alignment identity plots
#each alignment will need a new modified version of this script (see below for details). 

library(evobiR)
library(ggplot2)
library(reshape2)
  
#define window size for rolling window
windowsize <- 100

#readin must be a table of pairwise comparisions across alignment
rawdata <- read.table("extracted_sequences_494.fasta.reversed.out.table")
noname<-rawdata[-c(1,2)]

#for donor recipient pair
donor_recipient<- as.data.frame(noname[9,])
drwindow <- SlidingWindow("sum",donor_recipient,windowsize,1)
drwindow <- drwindow/windowsize

#for other grouping (copy paste and change index for as many as you need in a give group)
#note that these currrent assignments are only valid for this particular input file. you will need to change the following indexes. 
row1 <- as.vector(noname[2,])
row2 <- as.vector(noname[3,])
row3 <- as.vector(noname[5,])
#row4 <- as.vector(noname[10,])

#join all rows together
m1 <- rbind(row1,row2,row3)
summ1 <- colSums(m1)
identity <- c()
for(num in summ1){
  if(num==3){
    identity <- c(identity,1)  
  }
  else{
    identity <- c(identity,0)  
  }
}
groupwindow <- SlidingWindow("sum",identity,windowsize,1)
groupwindow <- groupwindow/windowsize

sequence <- seq_along(groupwindow)
plotdf <- data.frame(drwindow,groupwindow,sequence)

#plot time
#note: you will need to locate the gene of interest yourself, and adjust geom_point x choords appropriately
ggplot(data = plotdf, aes(x = sequence, y = value, color = variable)) +
  geom_line(aes(y = groupwindow, col = "Recipient and Neighbors")) + 
  geom_line(aes(y = drwindow, col = "Donor and Recipient")) +
  ggtitle("494 Alignment") +
  geom_point(aes(x=6758, y=1.0), colour="black") +
  geom_point(aes(x=8482, y=1.0), colour="black") +
  xlab("Alignment Position") + ylab("Rolling Window Identity") +
  theme_minimal()
ggsave("494_alignment.pdf",width=10,height=5)
      
