file = "/Users/jonaswallstein/Library/Mobile Documents/com~apple~CloudDocs/Upf/MDA/Project/lts_content/lts_content.csv"
pledges = read.table(file, sep = ",", header = TRUE)

pledges$target2050  = c(100, 100, 100, 100, NA, 100, 80, 100, NA, 100, 100, 80, 100, 100, 100, NA, 100, 100, 80, 59, 100, NA, 
                        NA, 100, 100, 100, 100, 72, 100, 100, 50, NA, NA, 95, 100, 50, 80, 100, 80, NA, 100, 100, NA, 100, 100, NA,
                        100, NA, NA, 31, 100, 100, 100)
summary(pledges$target2050)
hist(pledges$target2050)
