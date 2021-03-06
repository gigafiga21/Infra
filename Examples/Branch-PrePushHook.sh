#!/bin/sh
# Script for git pre-push hook
# keeps in file .git/hooks/pre-push

FOLDER=`git rev-parse --show-toplevel`
. $FOLDER/GitSyntax/Branch.sh

checkBranchStyle false;
ERROR=$?;

if [[ $ERROR -ne 0 ]]; then
    exit 1;
fi

exit 0;
