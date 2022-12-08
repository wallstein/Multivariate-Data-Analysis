#install.packages("HSAUR2")

############################################
# 0 - setup: install packages, get data
############################################
  rm(list = ls())
  library("HSAUR2")
  library("ggplot2")
  library("MASS")

  data <- HSAUR2::USairpollution
  
############################################
# 1 - Create classes of pollution
############################################
# drop outliers: Chicago
  data <- data[-7,]
# get quantiles of air pollution
  quantile(data$SO2, probs = c(0.33,0.5,0.67))
# classify data into pollution_group = 1 (low pollution), 2 (medium pollution) and 3 (high pollution)
  data$pollution_group <- ifelse(data$SO2 < 14.0, 1, 2)
  data$pollution_group <- ifelse(data$SO2 > 29.13, 3,  data$pollution_group)
  
# plot data and classes
  plot1 <- ggplot(mapping = aes(x = wind, y = manu)) +
    geom_point(aes(colour = pollution_group), data = data)
  plot1

  polllution_lda = lda(pollution_group ~ wind + manu, data = data)
  polllution_lda
  
  polllution_lda.values <- predict(polllution_lda)
  col <- as.numeric(data$pollution_group)
  plot2 <- plot(polllution_lda.values$x[,1:2],col=col,xlab='Linear discriminant 1',
       ylab='Linear discriminant 2',cex.lab=1.5)

  