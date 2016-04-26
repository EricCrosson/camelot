#!/usr/bin/env bash
# Written by Eric Crosson
# 2016-04-26

# Exit under these circumstances -- when we don't care about publishing javadoc
if [[ "$TRAVIS_REPO_SLUG" != "stormosson/camelot" || \
            "$TRAVIS_PULL_REQUEST" != "false" || \
            "$TRAVIS_BRANCH" != "master" ]]; then
    exit
fi

# Get to the Travis build dir, configure git and clone the repo
cd $HOME
git config --global user.email "travis@travis-ci.org"
git config --global user.name "travis-ci"
git clone --quiet --branch=deliverables https://${GH_TOKEN}@github.com/stormosson/camelot $HOME/camelot

# Commit and push changes
cd $HOME/camelot
git rm -rf *
cp -Rf $HOME/deliverables/* ./
git add -f .
git commit -m "Latest javadoc on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to deliverables"
git push -fq origin deliverables > /dev/null
