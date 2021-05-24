# Bayesian Approaches to Regression and Mixed Effects Models using R and brms

Bayesian methods are now increasingly widely used for data analysis based on linear and generalized linear models, and multilevel and mixed effects models.
The aim of this course is to provide a solid introduction to Bayesian approaches to these topics using R and the `brms` package.
Ultimately, in this course, we aim to show how Bayesian methods provide a very powerful, flexible, and extensible approach to general statistical data analysis.
We begin by covering Bayesian approaches to linear regression.
We will compare and contrast, in both practical and theoretical terms, the Bayesian approach and classical approach to linear regression.
This will allow us to easily identify the major similarities and major differences, both in terms of concepts and practice, between the Bayesian and classical approaches.
We will then proceed to Bayesian approaches to generalized linear models, including binary logistic regression, ordinal logistic regression, Poisson regression, zero-inflated models, etc.
In this coverage, we will see the very wide range of models to which Bayesian methods can be easily applied.
Finally, we will cover Bayesian approaches to multilevel and mixed effects models.
Here again, we will see how Bayesian methods allow us to easily extend traditionally used methods like linear and generalized linear mixed effects models.
We will also see how Bayesian methods allow us to control model complexity and solve algorithmic problems (e.g. model convergence problems) that can plague classical approaches to multilevel and mixed effects models.
Throughout this course, we will be using, via the brms package, Markov Chain Monte Carlo (MCMC) methods.
However, full technical details of MCMC will will be described here, but will be provided in subsequent Bayesian data analysis courses.

## Intended Audience

This course is aimed at anyone who is in interested in using Bayesian approaches to regression, multilevel, and mixed effects models in any area of science, including the social sciences, life sciences, physical sciences. No prior experience or familiarity with Bayesian statistics is required.

## Teaching Format

This course will be largely practical, hands-on, and workshop based. For many topics, there will first be some lecture style presentation, i.e., using slides or blackboard, to introduce and explain key concepts and theories. Then, we will work with examples and perform the analyses using R. Any code that the instructor produces during these sessions will be uploaded to a publicly available GitHub site after each session.

The course will take place online using Zoom. On each day, the live video broadcasts will occur between (UK Local Time; UTC/GMT) at:

* 12pm-2pm
* 3pm-5pm
* 6pm-8pm

All the sessions will be video recorded, and made available as soon as possible after each 2hr session on a private video hosting website.

# Assumed quantitative knowledge

We assume familiarity with inferential statistics concepts like hypothesis testing and statistical significance, and some practical experience with linear regression, logistic regression, mixed effects models.

## Assumed computer background

Some experience and familiarity with R is required. However, although we will be using R extensively, all the code that we use will be made available, and so attendees will usually just need to copy and paste and add minor modifications to this code.

## Equipment and software requirements

A computer with a working version of R or RStudio is required. R and RStudio are both available as free and open source software for PCs, Macs, and Linux computers. In addition to R and RStudio, some R packages, particularly brms, are required. Instructions on how to install R/RStudio and all required R packages are [available here](software.md).


The following RStudio server project can be used for anyone having trouble with Stan installation.
[![Binder](https://notebooks.gesis.org/binder/badge_logo.svg)](https://notebooks.gesis.org/binder/v2/gh/mark-andrews/hellobinder-rstan/HEAD?urlpath=rstudio)



# Course programme

## Day 1

* Topic 1: Bayesian linear models. We begin by covering Bayesian linear regression. For this, we will use the `brm` command from the `brms` package, and we will compare and contrast the results with the standard `lm` command.
By comparing and contrasting `brm` with `lm` we will see all the major similarities and differences between the Bayesian and classical approach to linear regression.
We will, for example, see how Bayesian inference and model comparison works in practice and how it differs conceptually and practically from inference and model comparison in classical regression.
As part of this coverage of linear models, we will also use categorical predictor variables and explore varying intercept and varying slope linear models.
* Topic 2: Extending Bayesian linear models. Classical normal linear models are based on strong assumptions that do not always hold in practice.
For example, they assume a normal distribution of the residuals, and assume homogeneity of variance of this distribution across all values of the predictors.
In Bayesian models, these assumptions are easily relaxed.
For example, we will see how we can easily replace the normal distribution of the residuals with a t-distribution, which will allow for a regression model that is robust to outliers.
Likewise, we can model the variance of the residuals as being dependent on values of predictor variables.

## Day 2

* Topic 3: Bayesian generalized linear models. Generalized linear models include models such as logistic regression, including multinomial and ordinal logistic regression, Poisson regression, negative binomial regression, zero-inflated models, and other models. Again, for these analyses we will use the `brms` package and explore this wide range of models using real world data-sets. In our coverage of this topic, we will see how powerful Bayesian methods are, allowing us to easily extend our models in different ways in order to handle a variety of problems and to use assumptions that are most appropriate for the data being modelled.
* Topic 4: Multilevel and mixed models. In this section, we will cover the multilevel and mixed effects variants of the regression models, i.e. linear, logistic, Poisson etc, that we have covered so far. In general, multilevel and mixed effects models arise whenever data are correlated due to membership of a group (or group of groups, and so on).
For this, we use a wide range of real-world data-sets and problems, and move between linear, logistic, etc., models are we explore these analyses. We will pay particular attention to considering when and how to use varying slope and varying intercept models, and how to choose between maximal and minimal models. We will also see how Bayesian approaches to multilevel and mixed effects models can overcome some of the technical problems (e.g. lack of model convergence) that beset classical approaches.
