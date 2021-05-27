library(tidyverse)
library(brms)

set.seed(10101)
n <- 250
data_df <- tibble(A = rnorm(n, mean = 1, sd = 1),
                  B = rnorm(n, mean = 0.25, sd = 2)
) %>% pivot_longer(cols = everything(), names_to = 'x', values_to = 'y')

data_df %>% 
  group_by(x) %>% 
  summarise(across(y, list(mean = mean, sd = sd)))

data_df %>% 
  ggplot(aes(x = x, y = y)) + geom_boxplot(width = 0.25) 

M8b_a <- brm(y ~ x, data = data_df)


M8b <- brm(bf(y ~ x, sigma ~ x), data = data_df)


anorexia_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/barm01/master/data/anorexia.csv")


anorexia_df %>% 
  group_by(Treat) %>% 
  summarise(across(Postwt, list(mean = mean, sd = sd)))

anorexia_df %>% 
  ggplot(aes(x = Treat, y = Postwt)) + geom_boxplot() + geom_jitter(width = 0.1)


M9b <- brm(bf(Postwt ~ Treat, sigma ~ Treat), data = anorexia_df)


# Robust regression -------------------------------------------------------

set.seed(10101)
n <- 25
data_df <- tibble(x = rnorm(n),
                  y = 5 + 0.5 * x + rnorm(n, sd = 0.1))

ggplot(data_df, aes(x = x, y = y)) + 
  geom_point() + 
  stat_smooth(method = 'lm') +
  ylim(4, 8)

data_df2 <- data_df
data_df2[12,2] <- 7.5

ggplot(data_df2, aes(x = x, y = y)) + 
  geom_point() +
  stat_smooth(method = 'lm') +
  ylim(4, 8)

M10 <- lm(y ~ x, data = data_df)
M11 <- lm(y ~ x, data = data_df2)

summary(M10)
summary(M11)

confint(M10)
confint(M11)


M13b <- brm(y ~ x, data = data_df)
M14b <- brm(y ~ x, data = data_df2)
M15b <- brm(y ~ x, data = data_df2, family = student())
