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

# Looking at R^2
summary(M1)$r.squared
var(M1$model$weight)
var(residuals(M1))
1 - var(residuals(M1)) / var(M1$model$weight)
var(predict(M1)) / var(M1$model$weight)

# Bayesian linear regression ----------------------------------------------

M3b <- brm(weight ~ height, data = weight_df_male)
M3b
summary(M3b)
plot(M3b)

bayes_R2(M3b)

M4b <- brm(weight ~ height + age, data = weight_df_male)

waic(M3b)
waic(M4b)

loo_compare(waic(M3b), waic(M4b))

prior_summary(M3b)

# change priors

newprior_1 <- prior(normal(0, 10), class = b)

M5b <- brm(weight ~ height + age,
           prior = newprior_1,
           data = weight_df_male)

prior_summary(M5b)


#posterior_summary(M5b) %>% as_tibble()
fixef(M4b)
fixef(M5b)

newprior_2 <- c(prior(normal(0, 10), class = b, coef = height),
                prior(normal(0, 2), class = b, coef = age))

M6b <- brm(weight ~ height + age,
           prior = newprior_2,
           data = weight_df_male)

prior_summary(M6b)
fixef(M6b)

newprior_3 <- c(prior(normal(0, 10), class = b, coef = height),
                prior(normal(0, 2), class = b, coef = age),
                prior(normal(0, 0.1), class = sigma))

M7b <- brm(weight ~ height + age,
           prior = newprior_3,
           data = weight_df_male)
