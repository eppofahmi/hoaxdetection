library(dplyr)
library(tm)
library(caret)

#-------------
# import data
data <- read.csv("sample.csv",sep = ";")

#-------------
# VECTORIZE DATA
datavector <- tm::VectorSource(data$tweet)
corpus <- tm::VCorpus(datavector)

# create dtm
tdm <- tm::DocumentTermMatrix(corpus)
tdm <- as.matrix(tdm)
tdm <- as.data.frame(tdm)

# add label
tdm <- dplyr::mutate(tdm,label = data$label)
tdm$label <- as.factor(tdm$label) #factor something like category

#------------
# train test split
train_ratio <- 0.8

# set seed to make reproducible
set.seed(123)

# get random index
train_index <- caret::createDataPartition(tdm$label,p=train_ratio,list = FALSE)

# split results
train <- tdm[train_index,]
test <- tdm[-train_index,]


#------------------
# model fitting
modelfit <- caret::train(label ~ ., data=train,method="nnet")
#knn
#nb
#rf
#nnet


#----------------
# testing
modelpredict <- caret::predict.train(modelfit,newdata = test)
confmat <- caret::confusionMatrix(modelpredict,test$label)
confmat$overall
confmat$table
confmat$byClass


#----------------
# prediction
#----------------
text_to_predict <- "akhirnya apa apa begitu canggih"

# tokenize
tokens <- tm::Boost_tokenizer(text_to_predict) %>%
  as.list()

# create empty data frame from unknown data
dfpredict <- matrix(0,1,ncol(tdm))
dfpredict <- as.data.frame(dfpredict)
colnames(dfpredict) <- colnames(tdm)

# create dtm from vector model
for (token in tokens) {
  index <- which(colnames(tdm)==token)
  dfpredict[c(index)] <- dfpredict[c(index)] + 1
}
dfpredict <- as.data.frame(dfpredict)

# prediction
caret::predict.train(modelfit,newdata = dfpredict,type="prob")

#
