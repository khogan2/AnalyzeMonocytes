## BTEC330 Hogan Project2

## Install necessary packages

install.packages("ggplot2")
library(ggplot2)

## Read data
IBS1 <- read.csv("data/RobinsonEtAl_Sup1.csv", header = TRUE)

##  Single Regressions for BMI vs. Monocytes
##  Data was obtained from Robinson, et al. 2019 (doi: https://doi.org/10.1101/608208)
##  https://statquest.org/2017/10/30/statquest-multiple-regression-in-r/
##  http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/
##  http://r-statistics.co/Linear-Regression.html

## Single Regression Test

single.regression <- lm(BMI ~ Monocytes, data=IBS1)
summary(single.regression)

single.regression <- lm(BMI ~ Monocytes_PCT, data=IBS1)
summary(single.regression)

## Scatterplots
## https://www.statmethods.net/graphs/scatterplot.html


ggplot(IBS1, aes(x=BMI, y=Monocytes)) +
  geom_point() +    
  geom_smooth(method=lm) 


ggplot(IBS1, aes(x=BMI, y=Monocytes_PCT)) +
  geom_point() +    
  geom_smooth(method=lm)  
