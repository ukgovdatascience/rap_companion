# Guidelines for collaborating on the RAP companion

Thanks for thinking about contributing! If you make a significant contribution to this book we will happily add you to the [list of authors](https://ukgovdatascience.github.io/rap_companion/) to credit your effort.  

The [Reproducible Analytical Pipelines](https://gdsdata.blog.gov.uk/2017/03/27/reproducible-analytical-pipeline/) (RAP) [companion](https://ukgovdatascience.github.io/rap_companion/) makes use of hosting our [RAP_companion repo](https://github.com/ukgovdatascience/rap_companion) using [Github pages](https://pages.github.com/).  

## Instructions for collaborating on the RAP companion

These instructions draw heavily from the [document by Chase Petit on Github](https://gist.github.com/Chaser324/ce0505fbed06b947d962). 

The [RAP companion](https://ukgovdatascience.github.io/rap_companion/) is being developed as a community project whereby colleagues in Government Departments implementing the tools and techniques recommended by the RAP (aka [DataOps](https://en.wikipedia.org/wiki/Dataops)) paradigm have an accessible knowledge repository to share-and-learn best practice from.  

If contributing using the below methodology seems too difficult then you can always share your work with us via email and we can incorporate it into the book for you. However, we recommend you attempt to use git and Github as learning how to collaborate via this medium is a key skill in RAP best practice.  

# Collaboration workflow

## New to git and Github?

See Hadley Wickham's intro [here](http://r-pkgs.had.co.nz/git.html#git-rstudio).    

## Create a Github account

You need to setup [git](https://help.github.com/articles/set-up-git), get a [Github account](http://www.wikihow.com/Create-an-Account-on-GitHub) and access Github.  

Hadley Wickham also provides a [detailed walkthrough](http://r-pkgs.had.co.nz/git.html#git-rstudio) of how to set up and use git and Github within R Studio.  

## Seup Github authentication

You will need to set up [authentication to GitHub from Git](https://help.github.com/articles/set-up-git#next-steps-authenticating-with-github-from-git) as well.  

## Creating a Fork

A *fork* is a copy of a repository. Forking a repository allows you to freely experiment with changes without affecting the original project.  

Head over to the [GitHub page](https://github.com/ukgovdatascience/rap_companion) and click the "Fork" button (in the top right hand corner). It's just that simple (forking it does what's described in the figure below - it makes a copy on Github "in the cloud" for you, of another repo). Once you've done that, you can use your favourite git client to clone your repo or just head straight to the command line (recommended; for forking in git see [here for an alternative guide to forking](https://help.github.com/articles/fork-a-repo/)):  

```shell
# Clone your fork to your local machine
git clone git@github.com:USERNAME/rap_companion.git
```
Cloning creates a local copy of your forked repo on your local machine.  

## Git lingo

All this esoteric git parlance makes life difficult for those new to version control. We provide a diagram (based on [this blog](https://github.com/sf-wdi-21/notes/blob/master/how-tos/github-workflow.md)) to elucidate the git terms you will be using throughout this Github fork and pull request workflow (this workflow is suitable for an Open project with many potential collaborators).  

![GitHub Fork-Pull Workflow](/images/github_workflow.png)

## Terminology

Look at the figure above and find each of the keywords as described below. (Inspired by [this guide](https://raw.githubusercontent.com/sf-wdi-21/notes/master/how-tos/github-workflow.md)).  

* **Repository** is a collection of files that are tracked together by the git protocol, also known as a repo  

* **Remote vs Local** is the distinction between files (a repo) that live in a server, such as one managed by Github, and one that lives directly on your machine  

* **Fork** is a remote repo that is a direct copy of another remote repo  

* **Clone** is to bring down all files from a remote repo to your machine locally  

* **Remote** is an alias in your Github repo that points to a remote Github repo via its web address  

* **Origin** is the standard naming convention for *your* remote repo  

* **Upstream** is the standard naming convention for the *original* remote repo  

## Keeping Your Fork Up to Date

While this isn't an absolutely necessary step, if you plan on doing anything more than just a tiny quick fix, you'll want to make sure you keep your fork up to date by tracking the original "upstream" repo that you forked (this is because it is in constant development). To do this, you'll need to add a remote:  

```shell
# Add 'upstream' repo to list of remotes
git remote add upstream https://github.com/ukgovdatascience/rap_companion.git

# Verify the new remote named 'upstream'
git remote -v
```

Whenever you want to update your fork with the latest upstream changes, you'll need to first fetch the upstream repo's branches and latest commits to bring them into your repository:  

```shell
# Fetch from upstream remote
git fetch upstream

# View all branches, including those from upstream
git branch -va
```

Now, checkout your own master branch and merge the upstream repo's master branch:  

```shell
# Checkout your master branch and merge upstream
git checkout master
git merge upstream/master
```

If there are no unique commits on the local master branch, git will simply perform a fast-forward. However, if you have been making changes on master (in the vast majority of cases you probably shouldn't be - [see how to create your own development branch](http://r-pkgs.had.co.nz/git.html#git-branch), you may have to deal with conflicts. When doing so, be careful to respect the changes made upstream.  

Now, your local master branch is up-to-date with everything modified upstream. Still don't get it? For an alternative visual guide [see here](https://help.github.com/articles/fork-a-repo/).    

## Doing Your Work

### Create a Branch
Whenever you begin work on a new feature or bug-fix, it's important that you create a new branch. Not only is it proper git workflow, but it also keeps your changes organized and separated from the master branch so that you can easily submit and manage multiple pull requests for every task you complete.  

To create a new branch and start working on it:

```shell
# Checkout the master branch - you want your new branch to come from master
git checkout master

# Check your master branch is up to date
git pull

# Create a new branch named feature/new_branch (give your branch its own simple informative name)
git branch feature/new_branch

# Switch to your new branch
git checkout feature/new_branch
```

Now, go to town hacking away and making whatever changes you want to. When you're happy with the changes you've made to the book or created a new Chapter then you need to render the book.  

## Rendering the book

It's easiest to render the book from the command line. Make sure your in the correct repository (rap_companion) on the correct branch (the one you are working on). Then run the following code in your command line. This will output all the html pages from the Rmarkdown you have written (if new to bookdown then refer to the [bookdown book](https://bookdown.org/yihui/bookdown/)).   

```shell

Rscript -e "bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

```

Open the book locally in RStudio, by navigating to the docs folder in the Files tab (/rap_companion/docs), and left-clicking on the `index.html` file and viewing it in your browser. Check it looks as you desire, make changes and repeat the process until it looks correct.  

For full instructions on rendering see Yihu Xie's [bookdown bookdown book](https://bookdown.org/yihui/bookdown/build-the-book.html). 

## Submitting a Pull Request

### Cleaning Up Your Work

Prior to submitting your pull request, you might want to do a few things to clean up your branch and make it as simple as possible for the original repo's maintainer to test, accept, and merge your work.  

If any commits have been made to the upstream master branch, you should [rebase your development branch so that merging](https://www.atlassian.com/git/tutorials/merging-vs-rebasing) it will be a simple fast-forward that won't require any conflict resolution work.  

```shell
# Fetch upstream master and merge with your repo's master branch
git fetch upstream
git checkout master
git merge upstream/master

# If there were any new commits, rebase your development branch
git checkout feature/new_branch
git rebase master
```

Now, it may be desirable to squash some of your smaller commits down into a small number of larger more cohesive commits. You can do this with an interactive rebase:  

```shell
# Rebase all commits on your development branch
git checkout 
git rebase -i master
```

This will open up a text editor where you can specify which commits to squash.  

### Fixing issues

If your pull request fixes a specific issue, Github can automatically close that issue based on the commit message as [described by Hadley Wickham](http://r-pkgs.had.co.nz/git.html#github-issues).   

### Submitting

Once you've committed and pushed all of your changes to GitHub, go to the page for your fork on GitHub, select your development branch, and click the [pull request button](http://r-pkgs.had.co.nz/git.html#git-pullreq). If you need to make any adjustments to your pull request, just push the updates to GitHub. Your pull request will automatically track the changes on your development branch and update.  

## Reviewing and Accepting and Merging a Pull Request

There's nothing better than receiving a pull request! Thanks for your contribution to our project. :)  

The review of the pull request will be carried out by the owners of the repo from which you forked; in this case members of the [ukgovdatascience team](https://github.com/ukgovdatascience). Broadly our methodology will follow that described by [Hadley Wickham here](http://r-pkgs.had.co.nz/git.html#pr-accept).  

## Credit

If you contribute a significant amount to this project we will happily add you to the list of authors, crediting you for your efforts and recognising how you are engaged with fulfilling your [Civil Service objectives](https://www.gov.uk/government/publications/civil-service-competency-framework).  

## Other things

* Use a consistent style; [this](http://adv-r.had.co.nz/Style.html) is a good place to start!
 
## Additional Reading
* [Atlassian - Merging vs. Rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)

## Sources
* [Github - Chase Petit's guide](https://gist.github.com/Chaser324/ce0505fbed06b947d962)  
* [Github workflow - alternative](https://github.com/sf-wdi-21/notes/blob/master/how-tos/github-workflow.md)  
* [GitHub - Fork a Repo](https://help.github.com/articles/fork-a-repo)
* [GitHub - Syncing a Fork](https://help.github.com/articles/syncing-a-fork)
* [GitHub - Checking Out a Pull Request](https://help.github.com/articles/checking-out-pull-requests-locally)