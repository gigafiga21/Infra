#!/bin/sh
# Script for git commit-msg hook
# keeps in file .git/hooks/commit-msg

FOLDER=`git rev-parse --show-toplevel`
. $FOLDER/GitSyntax/Commits.sh
printf "log: checking..."

# Getting commit message
MESSAGE=`cat $1`;

# Checking commit syntax 
checkCommitStyle $MESSAGE;
ERROR=$?;

if [[ $ERROR -ne 0 ]]; then
    exit 1;
fi

printf "\n";
exit 0;
