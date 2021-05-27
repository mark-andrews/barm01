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


# Mixed effects models ----------------------------------------------------

library(lme4)
ggplot(sleepstudy,
       aes(x=Days, y=Reaction)
) + geom_point() +
  stat_smooth(method='lm', se=F, size=0.5) +
  facet_wrap(~Subject) +
  theme_classic()

lmer(Reaction ~ Days + (1|Subject), data = sleepstudy)

M16 <- lmer(Reaction ~ Days + (Days|Subject), data = sleepstudy)
summary(M16)
M17b <- brm(Reaction ~ Days + (Days|Subject), data = sleepstudy)


classroom_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/barm01/master/data/classroom.csv")


M18 <- lmer(mathscore ~ ses + (ses|schoolid) + (ses|classid), data = classroom_df)
summary(M18)

M19 <- lmer(mathscore ~ ses + (ses|schoolid) + (ses||classid), data = classroom_df)

M20 <- lmer(mathscore ~ ses + (ses|schoolid) + (1|classid), data = classroom_df)

M21b <- brm(mathscore ~ ses + (ses|schoolid) + (ses|classid), 
            cores = 4,
            data = classroom_df)

M22b_prior = c(
  set_prior('lkj(2)', class = 'cor'),
  prior(cauchy(0, 1), class = sd, coef = ses, group = classid)
)

M22b <- brm(mathscore ~ ses + (ses|schoolid) + (ses|classid), 
            cores = 4,
            prior = M22b_prior,
            data = classroom_df)

prior_summary(M22b)
plot(M22b)

M23b_prior = set_prior('lkj(2)', class = 'cor')

M23b <- brm(mathscore ~ ses + (ses|schoolid) + (1|classid), 
            cores = 4,
            prior = M23b_prior,
            data = classroom_df)

loo_compare(waic(M22b), waic(M23b))
waic(M22b)
waic(M23b)

loo_compare(loo(M22b), loo(M23b))


mathach_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/barm01/master/data/mathachieve.csv") 


M24 <- lmer(mathach ~ ses + sex + minority + (ses + sex + minority|school), data = mathach_df)
M25b <- brm(mathach ~ ses + sex + minority + (ses + sex + minority|school),
            cores = 4,
            data = mathach_df)
plot(M25b)

science_df <- read_csv('https://raw.githubusercontent.com/mark-andrews/barm01/master/data/science.csv')


# ordinal logistic --------------------------------------------------------

wvs_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/barm01/master/data/wvs.csv")

wvs_df <- mutate(wvs_df, 
                 poverty = factor(poverty, 
                                  levels = c('Too Little', 'About Right', 'Too Much'),
                                  ordered = T))

wvs_df %>% pull(poverty) %>% class()
wvs_df %>% pull(poverty) %>% levels()

wvs_df %>% 
  mutate(age_grp = ntile(age, 5)) %>%
  ggplot(mapping = aes(x = poverty)) + 
  geom_bar(position="dodge") + 
  facet_wrap(~age_grp, nrow = 1) +
  scale_fill_manual(values=c( "#E69F00", "#999999", "#56B4E9")) +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 8, angle = -60),
        legend.position = 'bottom',
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 8))


M26b <- brm(poverty ~ age,
            data = wvs_df,
            family = cumulative(link = 'logit'),
            cores = 4)


M27b <- brm(like ~ PrivPub + sex + (1|school),
            family = cumulative(link = 'logit'),
            cores = 4,
            data = science_df)


# Mixed effects count models ----------------------------------------------

owls <- read_csv('https://raw.githubusercontent.com/mark-andrews/barm01/master/data/owls.csv')

# Take a look at some of the data
ggplot(owls,
       aes(x = SiblingNegotiation, fill = SexParent)
) + geom_histogram(position = 'dodge', binwidth = 1) + facet_wrap(~FoodTreatment, nrow = 2)

# There's no real reason to use normal(0, 100) as the non-default prior below.
# But I just put it in anyway.

# Mixed effects Poisson
M28b <- brm(SiblingNegotiation ~ FoodTreatment + SexParent + offset(log(BroodSize)) + (1|Nest),
           data = owls, 
           cores = 4, 
           prior = set_prior('normal(0, 100)'), 
           family = poisson())

# Mixed effects zero inflated Poisson
M29b <- brm(SiblingNegotiation ~ FoodTreatment + SexParent + offset(log(BroodSize)) + (1|Nest),
            data = owls, 
            cores = 4, 
            prior = set_prior('normal(0, 100)'), 
            family = zero_inflated_poisson())

# Mixed effects zero inflated Poisson
# where the probability of a zero or non-zero outcome is 
# a binary logistic regression function of two predictors
M30b <- brm(bf(SiblingNegotiation ~ FoodTreatment + SexParent + offset(log(BroodSize)) + (1|Nest),
                zi ~ FoodTreatment + SexParent),
             data = owls, 
             cores = 4, 
             prior = set_prior('normal(0, 100)'), 
             family = zero_inflated_poisson())


# Mixed effects zero inflated Negative binomial 
# where the probability of a zero or non-zero outcome is 
# a binary logistic regression function of two predictors
M31b <- brm(bf(SiblingNegotiation ~ FoodTreatment + SexParent + offset(log(BroodSize)) + (1|Nest),
                 zi ~ FoodTreatment + SexParent),
              data = owls, 
              cores = 4, 
              prior = set_prior('normal(0, 100)'), 
              family = zero_inflated_negbinomial())
