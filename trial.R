library(tidyverse)
library(pdftools)
options(digits = 3)
fn <- system.file("extdata", "RD-Mortality-Report_2015-18-180531.pdf", package="dslabs")
system("cmd.exe", input = paste("start", fn))
class(fn)
txt <- pdf_text(fn)
str(txt)
x <- txt[9] %>% str_split("\n")
str(x)
s <- x[[1]]
str(s)
s <- str_trim(s)
s[1]
str_which(s, "2015")
header_index <- str_which(s, "2015")[1]
headers <- str_split(s[header_index], "\\s+")
month <- headers[[1]][1]
header <- headers[[1]][-1]
month
header
