library(tidyverse)
library(tidytext)
library(textclean)
library(lubridate)

# Data 
dataset <- read_csv("TurnBackHoax.csv", trim_ws = FALSE)
dataset <- dataset %>%
  select(-c(1:2, 4:7, 12:13, 16:18, 20:24))
dataset <- dataset %>%
  select(-c(2:4))

# Data terkait dengan hoax
salah <- dataset %>%
  filter(str_detect(full_text, "SALAH"))
salah <- salah %>%
  separate(created_at, into = c("created_at", "jam"), sep = " ", remove = TRUE)

# pre-process data tanggal
salah$created_at <- ymd(salah$created_at)

# distribusi
salah %>%
  group_by(created_at) %>%
  count(created_at, sort = TRUE) %>%
  ggplot(aes(x = created_at, y = n, group = 1)) + 
  geom_line() + theme_minimal()

# cleaning 
clean <- tweet_cleaner(data = salah$full_text_norm)

salah$full_text_norm <- clean$clean_text

write_csv(salah, "salah.csv")
