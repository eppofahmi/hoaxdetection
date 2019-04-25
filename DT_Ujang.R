library(readr)
hashtag_ujang <- read_delim("raw_data/hashtag_ujang.csv", 
                            ";", escape_double = FALSE, trim_ws = TRUE)