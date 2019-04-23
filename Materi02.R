# Mengenal jenis data ----

## vector 

a <- c(1,2,5.3,6,-2,4) # numeric vector
b <- c("one","two","three") # character vector
c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE) #logical vector

## data frame

id <- c(1,2,3,4) #vector kolom id
name <- c("tom", "jerry", "dora", "emon") #vector kolom name
score <- c(85.4,78.3,88.9,90) #vector kolom score

# membuat data frame dari kolom vector
mydata <- data.frame(id,name,score)

# menambahkan nama kolom
names(mydata) <- c("ID","Nama","Nilai")

print(mydata)

# mengambil kolom 1 sampai 3
mydata[1:3]

# mengambil kolom dengan nama "ID" dan "Nilai"
mydata[c("ID","Nilai")]

# mengambil satu kolom dengan nama "Nilai"
mydata$Nilai

## list

w <- list(name="Fred", age=25, height=159.7)
x <- list("saya",5.4,1,FALSE)

print(x[1]) # mengakses melalui urutan indeks
print(w['name']) # mengakses melalui key

# Ekspor dan impor----
## data csv
library(readr)
df <- read_csv("https://s3.amazonaws.com/assets.datacamp.com/blog_assets/test.csv",
               col_names = TRUE)
df <- read_csv("https://s3.amazonaws.com/assets.datacamp.com/blog_assets/test.csv",
               col_names = FALSE)
df <- read_csv("https://s3.amazonaws.com/assets.datacamp.com/blog_assets/test.csv",
               col_names = c("x", "y", "z"))

## data xlsx ----
library(readxl)
xlsx_data1 <- read_excel("data/anggaran.xlsx", sheet = "Sheet1", skip = 3)

# menyimpan dalam bentuk xls/xlsx
library(openxlsx)
openxlsx::write.xlsx(xlsx_data1, file = "datasets.xlsx")

## data txt ----
df <- read.table("https://s3.amazonaws.com/assets.datacamp.com/blog_assets/test.txt", 
                 header = FALSE)
df

df <- read.delim("https://s3.amazonaws.com/assets.datacamp.com/blog_assets/test_delim.txt", 
                 sep="$")
df
