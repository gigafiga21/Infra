#!/bin/sh
# Script for Travis CI
# Checks branch name before merging

FOLDER=`git rev-parse --show-toplevel`
. $FOLDER/GitSyntax/Branch.sh

checkBranchStyle true;

ERROR=$?
if [[ $ERROR -ne 0 ]]; then
    exit $ERROR;
fi
