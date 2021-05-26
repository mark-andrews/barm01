library(tidyverse)
library(brms)

weight_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/barm01/master/data/weight.csv")

weight_df_male <- weight_df %>% filter(gender == 'male')
weight_df_male <- filter(weight_df, gender == 'male')

M1 <- lm(weight ~ height, data = weight_df_male)
coef(M1)
sigma(M1)
summary(M1)
confint(M1)

M2 <- lm(weight ~ height + age, data = weight_df_male)
summary(M2)

anova(M1, M2)


# Bayesian linear regression ----------------------------------------------

M3b <- brm(weight ~ height, data = weight_df_male)
M3b
summary(M3b)
plot(M3b)

M4b <- brm(weight ~ height + age, data = weight_df_male)
