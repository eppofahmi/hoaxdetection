# Skrip ini digunakan untuk mengeksplorasi postingan dari akun @TunrBackHoax yang mengandung term [SALAH] dari awal adanya akun hingga tanggal 20 April 2019. Data terdiri dari 14. 

library(tidyverse)

# Data
salah <- read_csv("raw_data/salah.csv", trim_ws = FALSE)

glimpse(salah)

# distribusi
salah %>%
  count(created_at) %>%
  ggplot(aes(x = created_at, y = n, group = 1)) + 
  geom_line() + theme_minimal()

# topik hoax
kata_dihilangkan <- data_frame(kata = c("salah", "selengkapnya", "penjelasan", 
                                        "referensi", "indonesia", "disinformasi"))

token_kata <- salah %>%
  select(created_at, full_text_norm) %>%
  separate(created_at, into = c("Tahun", "Bulan", "Tanggal"), sep = "-") %>%
  unnest_tokens(token_kata, full_text_norm, token = "words") %>%
  filter(!token_kata %in% kata_dihilangkan$kata)

# buzz words 
token_kata %>%
  group_by(token_kata) %>%
  count(token_kata, sort = TRUE) %>%
  head(n = 10) %>%
  ggplot(aes(x = reorder(token_kata, n), y = n)) + 
  geom_col() + coord_flip()

# kata unik per tahun
token_kata %>%
  group_by(Tahun) %>%
  count(token_kata, sort = TRUE) %>%
  bind_tf_idf(token_kata, Tahun, n) %>%
  top_n(10) %>%
  ggplot(aes(x = reorder(token_kata, tf_idf), y = tf_idf, fill + tahun)) + 
  geom_col() + coord_flip() + 
  facet_wrap(~Tahun, scales = "free_y")
