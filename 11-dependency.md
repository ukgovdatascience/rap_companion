# Dependency and reproducibility {#dep}

_This section is in development. Please [contribute to the discussion](https://github.com/ukgovdatascience/rap_companion/issues/89)._

## Other people's code

You're likely to make use of other people's code when you develop your RAP project. Maybe you've imported packages to perform a statistical test, for example. These dependencies can be extremely helpful. They can:

* prevent you from recreating code that already exists
* save you time trying to solve a problem and optimise its solution
* give you access to code and solutions from experts in the field
* help to reduce the size of your scripts and make them more human-readable
* limit the need for you to update and fix problems yourself

### Limitations

Most statistical publications are [updated on a scheduled basis](https://www.gov.uk/government/statistics/announcements) when new data become available.

It's possible that you'll get some errors when you reuse your RAP project code for the next update, even if everything worked perfectly last time. Why? The maintainers of your dependencies may have changed the code and it no longer works as you expect.

Changes might not impact your publication. If changes do have an impact, the best case is that you'll get a helpful error message. At worst, your code will execute with an imperceptible but impactful error. Maybe a rounding function now rounds to the nearest 10 instead of the nearest 1000.

The problem is compounded if your dependencies depend on other dependencies, or if two of your dependencies require conflicting versions of a third dependency. You could get stuck in so-called [dependency hell](https://en.wikipedia.org/wiki/Dependency_hell).

The bottom line: your publication is dependent on particular software _and_ its state at a given time. How can you deal with this? This chapter considers a few possibilities given variation in tools, techniques and IT restrictions.

### Think lightweight

First, think about what you can do to reduce the chance of problems. To put it succinctly, [the tinyverse philosophy of dependency management](http://www.tinyverse.org/) suggests that:

>Lightweight is the right weight

To achieve this you could:

* minimise the number of dependencies and remove redundancy where possible
* avoid depending on packages that in turn have many dependencies
* restrict yourself to 'stable' packages for which recent changes were restricted to minor updates and bug-fixes
* review regularly your dependencies to establish if better alternatives exist 

### Record the packages and versions

It's not enough to simply minimise your dependencies. You need to think about how this impacts the reproducibility of your project. To ensure that your scripts are executed in the same way next time, you need to record the packages and their versions in some way. Then you or a colleague can recreate the environment in which the outputs were produced the first time round.

## Approaches

### Version numbers

Maintainers signal updates by increasing the version number of their software. This could be a simple patch of an earlier version's bug (e.g. version 3.2.7 replaces 3.2.6), or perhaps a major _breaking_ change (e.g. version 3.2.6 is update to version 4.0.0).

There are many ways to record each of the packages used in our analysis and their version numbers.

In R you could, for example, use the `session_info()` function from `devtools` package. This prints details about the current state of the working environment. 


```r
devtools::session_info()
```
```
─ Session info ─────────────────────────────────────────
setting  value                       
version  R version 3.5.2 (2018-12-20)
os       macOS High Sierra 10.13.6   
system   x86_64, darwin15.6.0        
ui       RStudio                     
language (EN)                        
collate  en_GB.UTF-8                 
ctype    en_GB.UTF-8                 
tz       Europe/London               
date     2019-03-01                  

─ Packages ────────────────────────────────────────────
package     * version    date       lib source                         
assertthat    0.2.0      2017-04-11 [1] CRAN (R 3.5.0)                 
backports     1.1.3      2018-12-14 [1] CRAN (R 3.5.0)                 
bookdown      0.7        2018-02-18 [1] CRAN (R 3.5.0)                 
callr         3.1.1      2018-12-21 [1] CRAN (R 3.5.0)                 
...
```

You could do something like `pkgs <- devtools::session_info()$packages` to save a dataframe of the packages and versions.

You can achieve a similar thing for Python with `pip freeze` in a shell script.


```bash
pip freeze
```
```
## alabaster==0.7.10
## anaconda-client==1.6.14
## anaconda-navigator==1.8.7
## anaconda-project==0.8.2
## appnope==0.1.0
## appscript==1.0.1
...
```

You can save this information with something like `pip freeze > requirements.txt` in the shell. The packages  should be 'pinned' to specific versions, meaning that they're in the form `packageName==1.3.2` rather than `packageName>=1.3.2`. We're interested in storing _specific versions_, not _specific versions or newer_.

But simply saving this information in your project folder isn't good dependency control. It:

* would be tedious for analysts to read these reports and download each recorded package version one-by-one
* records _every_ package and its version _on your whole system_, not just the ones relevant to your project
* isn't a reproducible or automated process

### Environments for dependency management

Ideally we want to automate the process of recording packages and their version numbers and have them installed in an isolated environment that's specific to our project. Doing this makes the project more portable -- you could run it easily from another machine that's configured differently to your own -- and it would therefore be more reproducible.

#### Package managers in R

There is currently no consensus approach for package management in R. Below are a few options, but this is a non-exhaustive list.

The [`packrat` package](https://rstudio.github.io/packrat/) is commonly used but [has known issues](https://rstudio.github.io/packrat/limitations.html). The RAP community has noted in particular that it has a problem compiling older package versions on Windows. [Join the discussion for more information](https://github.com/ukgovdatascience/rap_companion/issues/86). 

[A `packrat` walkthrough is available](https://rstudio.github.io/packrat/walkthrough.html), but the basic process is:

1. Activate 'packrat mode' in your project folder with `init()`, which records and snapshots the packages you've called in your scripts.
1. Install new packages as usual, except they're now saved to a _private package repository_ within the project, rather than your local machine.
1. By default, regular snapshots are taken to record the state of dependencies, but you can force one with `snapshot()`.
1. When opening the project fresh on a new machine, Packrat automates the process of fetching the packages -- with their recorded version numbers -- and storing them in a private package library created on the collaborator's machine.

As for other options, [the `checkpoint` package](https://github.com/RevolutionAnalytics/checkpoint/wiki) from Microsoft's Revolution Analytics works like `packrat` but you simply `checkpoint()` your project for a given _date_. This allows you to call the packages from that date into a private library for that project. It works by fetching the packages from the [Microsoft R Application Network (MRAN)](https://mran.microsoft.com/), which is a daily snapshot of [CRAN](https://cran.r-project.org/). Note that this doesn't permit control of packages that are hosted anywhere other than CRAN, such as Bioconductor or GitHub, and relies on Microsoft continuing to snapshot and store CRAN copies in MRAN.

Another option is `jetpack`, which is different to `packrat` because it uses a DESCRIPTION file to list your dependencies. [DESCRIPTION files are used in package development](http://r-pkgs.had.co.nz/description.html) to store information, including that package's dependencies. This is a lightweight option and can be run from the command line.

Paid options also exist, but are obviously less accessible and require maintenance. One example is [RStudio's Package Manager](https://www.rstudio.com/products/package-manager/).

#### Virtual environments in Python

In Python we can easily create an isolated environment for our project and load packages into it. This is possible with tools like [`virtualenv` and `Pipenv`](https://docs.python-guide.org/dev/virtualenvs/).

You can set up a virtual environment in your project folder, activate it, install any packages you need and then record them in a file for use in future. One way to do this is with `virtualenv`. After installation and having navigated to your project's home folder, you can follow something like this from the command line:


```bash
virtualenv venv  # create virtual environment folder
source venv/bin/activate  # activate the environment
pip install packageName  # install packages you need
pip freeze > requirements.txt  # save package-version list
deactivate  # deactivate the environment when done
```

When another user downloads your version-controlled project folder, the requirements.txt file will be there. Now they can create a virtual environment on their machine following steps 1 to 3 above, but rather than `pip install packageName` for each package they need, they can automate the process by installing everything from the requirements.txt file with:


```bash
pip install -r requirements.txt
```

This will download the packages one by one into the virtual environment in their copy of the project virtual environment. Now they'll be using the same packages you were when you developed your project.

## Containers

### Theory

Good package management deals with one of the major problems of dependency hell. But the problem is bigger. Collaborators could still encounter errors if they: 

* try to run your code in a later version of the language you used during development
* use a different or updated [Integrated Development Environment](https://en.wikipedia.org/wiki/Integrated_development_environment) (IDE, like RStudio or Jupyter Notebooks)
* try to re-run the analysis on a different system, like if they try to run code on a Linux machine but the original was built on a Microsoft machine

What you really want to do is create a virtual computer inside your computer -- a _container_ -- with everything you need to recreate the analysis under consistent conditions, regardless of who you are and what equipment you're using.

Imagine one of those ubiquitous [shipping containers](https://en.wikipedia.org/wiki/Intermodal_container). They are:

* capable of holding different cargo
* can provide an isolated environment from the outside world
* can be transported by various transport methods

This is what we want for our project as well. We want to put whatever we want inside, we want it to be isolated and we want to be able to run it from anywhere.

### Docker

Docker can seem daunting at first.

It works like this:

1. Create a 'dockerfile'. This is like a plain-text recipe that will build from scratch everything you need to recreate a project. It's just a textfile that you can put under version control.
1. Run the dockerfile to generate a Docker 'image'. The image is an instance of the environment and everything you need to recreate your analysis. It's a delicious cake you made following the recipe.
1. Other people can follow the dockerfile recipe to make their own copies of the delicious image cake. Each running instance of an image is called a container.

You can learn more about this process by [following the curriculum on Docker's website](https://docker-curriculum.com/). You can also read about the use of Docker [in the Department for Work and Pensions](https://dwpdigital.blog.gov.uk/2018/05/18/using-containers-to-deliver-our-data-projects/) (DWP). Phil Chapman [wrote more about the technical side of this process](https://chapmandu2.github.io/post/2018/05/26/reproducible-data-science-environments-with-docker/).

### Making it easier

You don't have to build everything from scratch. [Docker hub](https://hub.docker.com/) is a big library of pre-prepared container images. For example, the [rocker project on Docker hub](https://hub.docker.com/u/rocker) lists a number of images containing R-specific tools like [rocker/tidyverse](https://hub.docker.com/r/rocker/tidyverse) that contains R, RStudio and [the tidyverse packages](https://tidyverse.tidyverse.org/). You can specify a rocker image in your dockerfile to make your life easier. Learn more about [rOpenSci labs tutorial](http://ropenscilabs.github.io/r-docker-tutorial/)

As well as rocker, R users can set up Docker from within an interactive R session: [the `containerit` package](https://o2r.info/containerit/index.html) lets you create a dockerfile given the current state of your session. This simplifies the process a great deal.

R users can also read [Docker for the useR](https://github.com/noamross/nyhackr-docker-talk) by Noam Ross and [an introduction to Docker for R users](https://colinfay.me/docker-r-reproducibility/) by Colin Fay.
