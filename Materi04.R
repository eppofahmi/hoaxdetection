# Teks processing ----
library(tidyverse)
library(textclean)
library(tidytext)

# data contoh
contoh_data <- read_csv("raw_data/from_kemen_1.csv", 
                         col_names = FALSE, trim_ws = FALSE)

glimpse(contoh_data)

colnames(contoh_data) <- c("created_at", "jam", "text", "reply", 
                           "reply_count", "retweet_count", "favorite_count", 
                           "urls")

contoh_data$text_asli <- contoh_data$text

glimpse(contoh_data)
# cek_teks <- check_text(contoh_data$text)

## Menghilangkan url: menggunakan fungsi dari textclean
contoh_data$text <- replace_html(contoh_data$text)
contoh_data$text <- replace_url(contoh_data$text)
contoh_data$text <- gsub(" ?(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", "", contoh_data$text) #adv remove url

## menghapus pic... :
contoh_data$text <- gsub("pic[^[:space:]]*", "", contoh_data$text)

head(contoh_data$text)

## Menghilangkan username: menggunakan fungsi dari text clean
contoh_data$text <- str_replace_all(contoh_data$text, 
                                    "(@[[:alnum:]_]*)", "") # replace username

## Menghilangkan emoticon: menggunakan fungsi dari text clean
contoh_data$text <- replace_emoji(contoh_data$text)

## Menghilangkan extra white space: menggunakan fungsi dari text clean
contoh_data$text <- replace_white(contoh_data$text)

## Menyeragamkan tulisan (lowercasing): menggunakan fungsi dasar tolower()
contoh_data$text <- tolower(contoh_data$text)
contoh_data$text <- replace_white(contoh_data$text)

# Menghapus hashtag 
contoh_data$text <- str_replace_all(contoh_data$text, 
                                    "(#[[:alnum:]_]*)", "")

# Menghapus tanda baca
contoh_data$text <- gsub("[[:punct:][:blank:]]+", " ", contoh_data$text)

contoh_data$text <- gsub("^[[:space:]]+", "", contoh_data$text)

# mengganti angka
contoh_data$text <- replace_time(contoh_data$text)
contoh_data$text <- replace_date(contoh_data$text, pattern = "([:alnum:]/[:alnum:])")
contoh_data$text <- replace_number(contoh_data$text)
head(contoh_data$text)

## Tokenisasi: menggunakan fungsi unnest_token() dari tidytext
library(tidytext)

hasil_token <- contoh_data %>%
  select(created_at, text_asli, text) %>%
  unnest_tokens(hsl_token, text, token = "ngrams", n = 2)

kata_populer <- hasil_token %>%
  # group_by(created_at) %>%
  count(hsl_token, sort = TRUE)

# install paket persiapan hari ke-2
install.packages("caret")
install.packages("tm")