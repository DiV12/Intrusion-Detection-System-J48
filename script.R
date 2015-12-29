
#data preperation for anamoly and misuse detection 
#author: Dhivya Govindarajan 
#date: Oct 11 2015


#input files 

setwd("~/Desktop/optimized_attacks_normal") #set working directory 


filename<-c('WarezMaster','WarezClient','TearDrop','Spy',
            'Rootkit','Pod','PHF','Perl','NMap','MultiHop',
            'LoadModule','Land','IPSweep','Imap','GuessPassword',
            'FTPWrite','BufferOverflow','Back','Satan','Normal',
            'Neptune','Smurf','PortSweep')

#save file as list 
r<-list()
length_files<-data.frame(matrix(nrow=23,ncol=2))
length_files[,1]<-filename
colnames(length_files)<-c('Name','Length')

for (i in 1:length(filename))
{
  newFilename<-paste0('Optimized_',filename[i])
  
  dataFile<-read.table(newFilename,header = FALSE,sep = ",")
  
  dataFile$class<-filename[i]
  
  length_files$Length[i]<-length(dataFile$V1)
  
  r[[i]]<-dataFile
  
}

#merging to create a new file 
misusedFile<-data.frame()
for (i in 1:length(filename))
{
  if (filename[i]=='Normal'|filename[i]=='Neptune')
  {
    misusedFile<-rbind(misusedFile,r[[i]][sample(1000),])
  }
  
  else 
  {
    misusedFile<-rbind(misusedFile,r[[i]])
  }
  
}

#newfile
anamoly<-misusedFile
id<-which(anamoly$class!='Normal')
anamoly$class[id]<-"Attack"


misused_shuffle<-misusedFile[sample(nrow(misusedFile)),]
View(misused_shuffle)
anamoly_shuffle<-anamoly[sample(nrow(anamoly)),]
View(anamoly_shuffle)




