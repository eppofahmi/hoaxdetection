# Pre-processing ----
library(dplyr) # paket bagian dari tidyverse
library(readr)

# data contoh
df <- read_csv("https://s3.amazonaws.com/assets.datacamp.com/blog_assets/test.csv",
               col_names = TRUE)

glimpse(df)

## Memilih kolom: menggunakan fungsi select() dari dplyr
kolom_terpilih <- df %>%
  select(Col1, Col2)

## Memfilter baris: menggunakan fungsi filter() dari dplyr
baris_terpilih <- df %>%
  filter(Col1 == "7")

## Merename nama kolom: menggunakan fungsi colname() atau colnames()
colnames(df)
colnames(df) <- c("Kolom1", "Kolom2", "Kolom3")
colnames(df)

## Memisah dan menggabungkan kolom: menggunakan fungsi separate() dan unite() dari dplyr
rm(list=ls()) # menghapus environment

library(gapminder)

contoh_data <- gapminder %>%
  filter(country == "Bosnia and Herzegovina")

# memisahkan
pisah_kolom <- gapminder %>%
  separate(country, into = c("nama1", "nama2", "nama3"), sep = " ", 
           remove = FALSE)

pisah_kolom <- contoh_data %>%
  separate(country, into = c("nama1", "nama2", "nama3"), sep = " ", 
           remove = FALSE)

# menggabungkan
gabung_kolom <- pisah_kolom %>%
  unite("negara", c("nama1", "nama2", "nama3"), sep = " ")

## Membuat kolom baru: menggunakan fungsi mutate() dari dplyr
kolom_baru <- gabung_kolom %>%
  mutate("setengah_pop" = pop/2)

## Menggabungkan dua data: menggunakan fungsin bind_col() atau bind_row() dari dplyr


### Gabung ke bawah: syarat: jumlah kolom sama
data1 <- gabung_kolom[1:10, ]
data2 <- gabung_kolom
gabung_kebawah <- bind_rows(data1, data2)

### Gabung ke kesamping: syarat jumlah baris sama
gabung_kesamping <- bind_cols(kolom_baru, pisah_kolom)

### Gabung data berdasarkan kolom tertentu
data_merge <- left_join(data2, data1, by = "year")