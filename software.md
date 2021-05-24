# Software requirements

The required software for this workshop is all free and open source
and will run identically on Windows, Mac OS X, and Linux platforms.

There are six main pieces of software to install:

-   [R](https://www.r-project.org/): An environment for statistical
    computing.
-   [Rstudio](https://www.rstudio.com/): An integrated development
    environment for using R.
-   [tidyverse](https://www.tidyverse.org/): A bundle of R packages to
    use R the modern way.
-   Miscellaneous R packages: Other vital, or just handy, R packages.
-   [Stan](http://mc-stan.org/): A Bayesian probabilistic modelling
    language.
-   [brms](https://github.com/paul-buerkner/brms): An R package to
    interface with [Stan](http://mc-stan.org/).
-   An ad hoc R package named `priorexposure`.

All of the above installation should be easy and painless except
possibly for the installation of [Stan](http://mc-stan.org/), which can
possibly be tricky because it is an external program and requires
addition programming tools like c++ libraries and compilers etc.
However, in the instructions below there are links to pages that provide
ample detail on how to install and test [Stan](http://mc-stan.org/) and
all its dependencies.

## Installing R

Go to the [R](https://www.r-project.org/) website and follow the links
for downloading. On Windows, this should lead you to

-   <https://cran.r-project.org/bin/windows/base/>.

Downloading this and following the usual Windows installation process,
you\'ll then have a full working version of R.

On Macs, the installation procedure is essentially identical. The latest
Mac installer should be available at

-   <https://cran.r-project.org/bin/macosx/>.

Download this and follow the usual Mac installation process to get a
full working version of R for Macs.

## Installing Rstudio

Using Rstudio is not strictly necessary. You can do all you need to do
with R without using Rstudio. However, many people have found that using
R is more convenient and pleasant when working through Rstudio. To
install it, go to the [Rstudio](https://www.rstudio.com/) website,
specifically to

-   <https://www.rstudio.com/products/rstudio/download/>

which will list all the available installers. Note that you just want
the Rstudio *desktop* program. The Rstudio *server* is something else
(basically it is for providing remote access to Rstudio hosted on Linux
servers).

Again, you\'ll just follow the usual installation process for Windows or
Macs to install Rstudio using these installers.

## Installing the tidyverse packages

The so-called [tidyverse](https://www.tidyverse.org/) is a collection of
interrelated R packages that implement essentially a new standard
library for R. In other words, the
[tidyverse](https://www.tidyverse.org/) gives us a bundle tools for
doing commonplace data manipulation and visualization and programming.
It represents the modern way to use R, and in my opinion, it\'s the best
way to use R. All the [tidyverse](https://www.tidyverse.org/) packages
can be installed by typing the following command in R:

``` {.R}
install.packages("tidyverse")
```

The main packages that are contained within the
[tidyverse](https://www.tidyverse.org/) bundle are listed
[here](https://www.tidyverse.org/packages/).

## Installing Miscellaneous R packages

There are a bunch of other R packages that we either will use. Here are the main ones:
``` {.R}
install.packages("lme4")
```

## Installing Stan

Stan is a probabilistic programming language. Using the Stan language,
you can define arbitrary probabilistic models and then perform Bayesian
inference on them using
[MCMC](https://en.wikipedia.org/wiki/Markov_chain_Monte_Carlo),
specifically using [Hamiltonian Monte
Carlo](https://en.wikipedia.org/wiki/Hamiltonian_Monte_Carlo).

In general, Stan is a external program to R; it does not need to be used
with R. However, one of the most common ways of using Stan is by using
it through R and that is what we will be doing in this workshop.

To use Stan with R, you need to install an R package called
[rstan](http://mc-stan.org/users/interfaces/rstan). However, you also
need additional external tools installed in order for
[rstan](http://mc-stan.org/users/interfaces/rstan) to work.

Instructions for installing rstan on can be found here:

- <https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started>

Specific instructions for different platforms can be found by following links from this page.

## Installing brms

If the installation of R, Rstudio and Stan seemed to go fine, you can
get the [brms](https://github.com/paul-buerkner/brms) R package, which
makes using Stan with R particularly easy when using conventional
models.

To get [brms](https://github.com/paul-buerkner/brms), first start
Rstudio (whether on Windows, Macs, Linux) and then run

```r
install.packages('brms')
```

You can test that it worked by running the following code, which should take around 1 minute to complete.

```r
library(tidyverse)
library(brms)

data_df <- tibble(x = rnorm(10))

M <- brm(x ~ 1, data = data_df)
```

## Trouble getting `rstan` and `brms` working on Windows using R 4.0?

Here's what I did to get `rstan` and `brsm` working on Windows using R 4.0?

1. First, in R, install `rstan`.
```r
install.packages("rstan")
```

2. In Windows, download and run this [Rtools 4 installer](https://cran.r-project.org/bin/windows/Rtools/rtools40-x86_64.exe).

3. Back in R, type the following line.
```r
writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron")
```

4. *Restart R*

5. Check that RTools is working.
```r
pkgbuild::has_build_tools(debug = TRUE)
```
This should simply return `TRUE`.

6. Install `brms`.
```r

install.packages('brms')
```

7. Test the `brms` code above, i.e. with the `M <- brm(x ~ 1, data = data_df)`.

## Another test installing Stan, `rstan`, `brms` on Windows

As as test, I installed Stan, `rstan`, and `brms` from scratch on Windows.

First, I did this: 

* Uninstall R and RStudio completely.
* Delete my Documents/R (default location of R packages) folder
* Reinstall R and RStudio from latest versions

Then, I installed `rstan`.
``` {.R}
install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)
```

Then, I installed `rtools` using 64 bit installer here https://cran.r-project.org/bin/windows/Rtools/, i.e. https://cran.r-project.org/bin/windows/Rtools/rtools40-x86_64.exe

Then, I tested Stan/`rstan` with
```{.R}
library(rstan)
example(stan_model,run.dontrun = TRUE)
```
There was a lot of output, but it eventually (after about 3-5 minutes) finished with samples from a model.

Then, I installed `tidyverse` and `brms`.

```{.R}
install.packages("tidyverse")
install.packages("brms")
```


Then, tested the tiny `brms` model.
```{.R}
library(tidyverse)
library(brms)

data_df <- tibble(x = rnorm(10))

M <- brm(x ~ 1, data = data_df)
```

And all was well.


# If all else fails?

The following RStudio server project can be used for anyone having trouble with Stan installation.
[![Binder](https://notebooks.gesis.org/binder/badge_logo.svg)](https://notebooks.gesis.org/binder/v2/gh/mark-andrews/hellobinder-rstan/HEAD?urlpath=rstudio)


While this *does* work, the binder service may limit the RAM size of some models. As such, while the smaller models will work, the more RAM hungry ones might not work.
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
