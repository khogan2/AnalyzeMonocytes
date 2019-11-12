## AnalyzeMonocytes
![doi](../master/Images/zenodo.3373938.svg?sanitize=true)
### Single regressions, one-way anova tests, scatterplots, and boxplots for clinical bloodwork and gene expression data.
([AnalyzeMonocytes.R](../master/AnalyzeMonocytes.R)) will allow you to load a comma-delimited .csv with various datapoints, perform single regressions and one-way anova tests of Body Mass Index (BMI) vs. the variables Monocytes and Monocytes_PCT from the Complete Blood Count with Differential (CBC-D) results, and produce scatterplots and boxplots for the results. Additionally, you will be allowed to view the ranges of monocyte levels from low, normal, and high. Monocytes are a type of white blood cell that fight certain infections and help other white blood cells remove dead or damaged tissues, destroy cancer cells, and regulate immunity against foreign substances. Low levels of monocytes in the blood is known as monocytopenia and can be caused by anything that decreases the overall white blood cell count, such as a bloodstream infection, chemotherapy, or leukemia. High levels of monocytes in the blood is known as monocytosis and can reslut from the presence of chronic infection, an autoimmune or blood disorder, or leukemia. Detecting abnormal levels of monocytes in a CBC whether it be high or low levels is crucial in the detection of potential diseases, infections, and disorders.

Data (RobinsonEtAl_Sup1.csv) was downloaded from: 

Robinson, JM. et al. 2019. Complete blood count with differential: An effective diagnostic for IBS subtype in the context of BMI? BioRxiv. doi: https://doi.org/10.1101/608208.


## Results of Single Regression Test, BMI vs. Bloodwork parameter

Monocytes.regression <- lm(BMI ~ Monocytes, data = IBS1)
summary(Monocytes.regression)

Call:
lm(formula = BMI ~ Monocytes, data = IBS1)

Residuals:
   Min     1Q Median     3Q    Max 
-8.073 -4.555 -1.651  3.821 20.100 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  26.5538     1.6256  16.335   <2e-16 ***
> Monocytes     0.4434     3.3746   0.131    0.896    
---
> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 6.073 on 104 degrees of freedom
  (5 observations deleted due to missingness)
Multiple R-squared:  0.000166,	Adjusted R-squared:  -0.009448 
F-statistic: 0.01727 on 1 and 104 DF,  p-value: 0.8957

## Results of Single Regression Test, BMI vs. Bloodwork parameter

Monocytes_PCT.regression <- lm(BMI ~ Monocytes_PCT, data = IBS1)
summary(Monocytes_PCT.regression)

Call:
lm(formula = BMI ~ Monocytes_PCT, data = IBS1)

Residuals:
   Min     1Q Median     3Q    Max 
-8.445 -4.584 -1.576  3.897 19.602 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)    27.8968     1.9487   14.31   <2e-16 ***
> Monocytes_PCT  -0.1520     0.2576   -0.59    0.556    
---
> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 6.051 on 106 degrees of freedom
  (3 observations deleted due to missingness)
Multiple R-squared:  0.003276,	Adjusted R-squared:  -0.006127 
F-statistic: 0.3484 on 1 and 106 DF,  p-value: 0.5563



## Scatterplots

ggplot(IBS1, aes(x=BMI, y=Monocytes)) +
  geom_point() +    
  geom_smooth(method=lm)
  
  
ggplot(IBS1, aes(x=BMI, y=Monocytes_PCT)) +
  geom_point() +    
  geom_smooth(method=lm)


## Results of ANOVA: IBS-subtype vs. Bloodwork parameter

> Monocytes.aov <- aov(Monocytes ~ IBS.subtype, data = IBS1)
> summary(Monocytes.aov)
             Df Sum Sq Mean Sq F value Pr(>F)
IBS.subtype   1  0.057 0.05712    1.88  0.173
Residuals   106  3.222 0.03039               
3 observations deleted due to missingness
> sink('data_output/Monocytes_anova.txt', append = TRUE)
> print(Monocytes.aov)
> sink()

> Monocytes_PCT.aov <- aov(Monocytes_PCT ~ IBS.subtype, data = IBS1)
> summary(Monocytes.aov)
             Df Sum Sq Mean Sq F value Pr(>F)
IBS.subtype   1  0.057 0.05712    1.88  0.173
Residuals   106  3.222 0.03039               
3 observations deleted due to missingness
> sink('data_output/Monocytes_PCT_anova.txt', append = TRUE)
> print(Monocytes_PCT.aov)
> sink()
  
## Boxplots

boxplot(Monocytes ~ IBS.subtype, data = IBS1, main="Monocytes by IBS subtype", 
        xlab = "IBS.subtype", ylab = "Monocytes"
)

boxplot(Monocytes_PCT ~ IBS.subtype, data = IBS1, main="Monocytes_PCT by IBS subtype", 
        xlab = "IBS.subtype", ylab = "Monocytes_PCT"
)
