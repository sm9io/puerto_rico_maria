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
tail_index <- str_which(s, "Total")[1]
n <- str_count(s, "\\d+")
n_single <- which(n==1)
n_single
s <- s[-c((1:header_index), n_single, (tail_index:length(s)))]
length(s)
s <- str_remove_all(s, "[^\\d\\s]")
s <- str_split_fixed(s, "\\s+", n = 6)[,1:5]
tab <- matrix(as.numeric(s), ncol = ncol(s))
colnames(s) <- c("day", header)
s <- cbind(s, month = month)
mean(as.numeric(s[,"2015"]))
mean(as.numeric(s[,"2016"]))
mean(as.numeric(s[1:19,"2017"]))
mean(as.numeric(s[20:30,"2017"]))
s <- s %>% gather(year, deaths, -c(day, month)) %>%  mutate(deaths = as.numeric(deaths))
