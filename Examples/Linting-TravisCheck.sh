#!/bin/sh
# Script for Travis CI
# Run linters pointed in "Linters/Linting.sh"

FOLDER=`git rev-parse --show-toplevel`
. $FOLDER/Linters/Linting.sh

if [[ $TRAVIS_PULL_REQUEST_BRANCH == "" ]]; then
    exit 0;
fi

# Getting file names with changes
FILE_LIST=$(git diff ${TRAVIS_COMMIT_RANGE[0]} HEAD --name-only);

linting "$FILE_LIST";
