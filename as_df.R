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
tab <- data.frame(matrix(as.numeric(s), ncol = ncol(s)))
names(tab) <- c("day", header)
tab <- mutate(tab, month = month)
mean(tab$`2015`)
mean(tab$`2016`)
tab %>% filter(day %in% (1:19)) %>% summarise(mean(.$`2017`))
tab %>% filter(day %in% (20:30)) %>% summarise(mean(.$`2017`))
tab <- tab %>% gather(year, deaths, -c(day, month)) %>%  mutate(deaths = as.numeric(deaths))
tab %>% filter(year != 2018) %>% ggplot(aes(day, deaths, col = year)) + geom_line() + geom_point() + geom_vline(xintercept = 20)
