# Materi Hari ke-1

## Menulis dan menjalankan skrip ####

sebuah_data <- "Ini sebuah data"

## Library dan Package ----

install.packages("tidyverse") # dilakukan hanya sekali setalah install
install.packages("gaminder")

library(tidyverse) # dilakuan setiap kali membuka rstudio
library(gapminder)

## Memahami fungsi dari library ----
contoh_data <- gapminder

### CATATAN: Setiap fungsi dalam R berformat NAMA_FUNGSI(VARIABELNYA)

### Fungsi summary()
summary(contoh_data)

### Fungsi str()
str(contoh_data)

### Fungsi class()
class(contoh_data)

### Fungsi paste()
kalimat_1 <- "Jokowi kenal prabowo"
kalimat_2 <- "Prabowo kenal kaesang"

hasil_paste <- paste(kalimat_1, kalimat_2)
hasil_paste

hasil_paste <- paste(kalimat_1, "dan", kalimat_2)
hasil_paste

### TUGAS: Cobalah ubah fungsi paste() dengan paste0(), sebutkan perbedaannya 