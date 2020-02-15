#!/bin/sh
# Script for Travis CI
# Checks msg of all commits in testing branch

# Getting path to Commmit.sh
FOLDER=`git rev-parse --show-toplevel`
. $FOLDER/GitSyntax/Commits.sh

# Checking if script running in Travis CI
if [[ $TRAVIS_PULL_REQUEST_BRANCH == "" ]]; then
    exit 0;
fi

# Getting commit messages
COMMITS=`git log --format='%B' "$TRAVIS_COMMIT_RANGE"`;
IFS=$'\n'
readarray -t MESSAGES <<<"$COMMITS"

printf "log: checking...\n\n";

for MESSAGE in ${MESSAGES[@]}; do
    printf "  "$MESSAGE"\n";
    checkCommitStyle $MESSAGE;

    ERROR=$?
    if [[ $ERROR -ne 0 ]]; then
        exit $ERROR;
    fi
done

printf "\n"
