#!/bin/bash

# Configure your name and email if you have not done so

git config --global user.email ${EMAIL}
git config --global user.name ${USERNAME}

# Ensure that the book will only be updated when the build is 
# triggered from the master branch.

[ "${TRAVIS_BRANCH}" != "master" ] && exit 0

# Clone the repository to the book-output directory

git clone -b gh-pages \
  https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git \
  book-output

# Copy locally built *.html files into 

cp -r /home/travis/build/ukgovdatascience/rap_companion/docs/* book-output

# Create .nojekyll file to prevent git from trying to build
# html pages with jekyll.

touch book-output/.nojekyll

# Add the locally built files to a commit and push

cd book-output
git add . -f
git commit -m "Automatic build update" || true
git push origin gh-pages
