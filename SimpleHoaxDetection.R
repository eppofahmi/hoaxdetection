library(dplyr)
library(tm)
library(caret)

#------
# Import data
data <- read.csv("sample.csv",sep = ";")
#------

#------
# Vectorization
#------
datavector <- tm::VectorSource(data$tweet)
corpus <- tm::VCorpus(datavector)

# Create DTM
dtm <- tm::DocumentTermMatrix(corpus)
dtm <- as.matrix(dtm)
dtm <- as.data.frame(dtm)
dtm <- dplyr::mutate(dtm,label = data$label)
dtm$label <- as.factor(dtm$label)

# Save vector model
readr::write_rds(dtm,"vectormodel.rds")
#------

#------
# Split into testing and training data
#-----
# Set ratio between training and testing
train_ratio <- 0.8

# Set seed to make randomize reproducible
set.seed(123)

# Get random index
train_index <- caret::createDataPartition(dtm$label,p=train_ratio,list = FALSE)

# Split data
train <- dtm[train_index,]
test <- dtm[-train_index,]

#--------
# Model fitting for training data
#-------
# Fit the model
modelfit <- caret::train(label ~ ., data=train,method="knn")

# Save machine learning model
readr::write_rds(modelfit,"modelfit.rds")
#-------

#-------
# Testing
#-------
modelpredict <- caret::predict.train(modelfit,newdata = test)
# Confusion matrix
confmat <- caret::confusionMatrix(modelpredict,test$label)
confmat$overall
confmat$table
confmat$byClass
#-------

#-------
# Prediction
#-------
text_to_predict <- "akhirnya apa apa begitu canggih"

# Tokenize
tokens <- tm::Boost_tokenizer(text_to_predict)

# Create empty data frame from text_to_predict
dfpredict <- matrix(0,1,ncol(dtm))
dfpredict <- as.data.frame(dfpredict)
colnames(dfpredict) <- colnames(dtm)

# Create dtm for new data using vector model
for (token in tokens) {
  index <- which(colnames(dtm)==token)
  dfpredict[c(index)] <- dfpredict[c(index)] + 1
}
dfpredict <- as.data.frame(dfpredict)

# Predict
caret::predict.train(modelfit,newdata = dfpredict,type="prob")
#--------