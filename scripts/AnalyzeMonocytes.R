## BTEC330 Hogan Project2

## Install necessary packages

install.packages("ggplot2")
library(ggplot2)

## Read data
IBS1 <- read.csv("data/RobinsonEtAl_Sup1.csv", header = TRUE)
head(IBS1)

IBS1$Monocytes_result <- "NA"

IBS1$Monocytes_PCT_result <- "NA"


## Assign "HIGH", "NORMAL", or "LOW" based on clinical range to the Monocytes_result parameter

IBS1$Monocytes_result[IBS1$Monocytes > 0.8] <- "HIGH"

IBS1$Monocytes_result[IBS1$Monocytes <= 0.8 & IBS1$Monocytes >= 0.2] <- "NORMAL"

IBS1$Monocytes_result[IBS1$Monocytes < 0.2] <- "LOW"

write.csv(IBS1, "data_output/Monocytes.csv")


## Assign "HIGH", "NORMAL", or "LOW" based on clinical range to the Monocytes_PCT_result parameter

IBS1$Monocytes_PCT_result[IBS1$Monocytes_PCT > 12] <- "HIGH"

IBS1$Monocytes_PCT_result[IBS1$Monocytes_PCT <= 12 & IBS1$Monocytes_PCT >= 5] <- "NORMAL"

IBS1$Monocytes_PCT_result[IBS1$Monocytes_PCT < 5] <- "LOW"

write.csv(IBS1, "data_output/Monocytes_PCT.csv")

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

## Single Regression Test, BMI vs. Bloodwork parameter
Monocytes.regression <- lm(BMI ~ Monocytes, data = IBS1)
summary(Monocytes.regression)

## Single Regression Test, BMI vs. Bloodwork parameter
Monocytes_PCT.regression <- lm(BMI ~ Monocytes_PCT, data = IBS1)
summary(Monocytes_PCT.regression)

## Output the results to a file
## http://www.cookbook-r.com/Data_input_and_output/Writing_text_and_output_from_analyses_to_a_file/
sink('data_output/Monocytes_regression.txt', append = TRUE)
print(Monocytes.regression)
sink()

## Output the results to a file
## http://www.cookbook-r.com/Data_input_and_output/Writing_text_and_output_from_analyses_to_a_file/
sink('data_output/Monocytes_PCT_regression.txt', append = TRUE)
print(Monocytes_PCT.regression)
sink()

## ANOVA: IBS-subtype vs. Bloodwork parameter
## http://www.sthda.com/english/wiki/one-way-anova-test-in-r
Monocytes.aov <- aov(Monocytes ~ IBS.subtype, data = IBS1)
summary(Monocytes.aov)
sink('data_output/Monocytes_anova.txt', append = TRUE)
print(Monocytes.aov)
sink()

## ANOVA: IBS-subtype vs. Bloodwork parameter
## http://www.sthda.com/english/wiki/one-way-anova-test-in-r
Monocytes_PCT.aov <- aov(Monocytes_PCT ~ IBS.subtype, data = IBS1)
summary(Monocytes.aov)
sink('data_output/Monocytes_PCT_anova.txt', append = TRUE)
print(Monocytes_PCT.aov)
sink()

## Scatterplots
## https://www.statmethods.net/graphs/scatterplot.html

ggplot(IBS1, aes(x = BMI, y = Monocytes)) +
  geom_point() +    
  geom_smooth(method = lm) 

png("fig_output/Monocytes_scatterplot.png")
Monocytes_scatterplot <- ggplot(IBS1, aes(x = BMI, y = Monocytes)) +
  geom_point() +    
  geom_smooth(method = lm) 

png("fig_output/Monocytes_scatterplot.png")
Monocytes_PCT_scatterplot <- ggplot(IBS1, aes(x = BMI, y = Monocytes_PCT)) +
  geom_point() +    
  geom_smooth(method = lm) 

print(Monocytes_scatterplot)
dev.off()

print(Monocytes_PCT_scatterplot)
dev.off()

## Box plots
## https://www.statmethods.net/graphs/boxplot.html

boxplot(Monocytes ~ IBS.subtype, data = IBS1, main="Monocytes by IBS subtype", 
        xlab = "IBS.subtype", ylab = "Monocytes"
)

boxplot(Monocytes_PCT ~ IBS.subtype, data = IBS1, main="Monocytes_PCT by IBS subtype", 
        xlab = "IBS.subtype", ylab = "Monocytes_PCT"
)

png("fig_output/Monocytes_boxplot.png")
Monocytes_boxplot <- boxplot(Monocytes ~ IBS.subtype, data = IBS1, main="Monocytes by IBS subtype", 
                       xlab = "IBS.subtype", ylab = "Monocytes"
)
print(Monocytes_boxplot)
dev.off()

png("fig_output/Monocytes_PCT_boxplot.png")
Monocytes_PCT_boxplot <- boxplot(Monocytes ~ IBS.subtype, data = IBS1, main="Monocytes_PCT by IBS subtype", 
                             xlab = "IBS.subtype", ylab = "Monocytes_PCT"
)
print(Monocytes_PCT_boxplot)
dev.off()
