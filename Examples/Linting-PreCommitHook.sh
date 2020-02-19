#!/bin/sh
# Script for git pre-commit hook
# keeps in file .git/hooks/pre-commit

FOLDER=`git rev-parse --show-toplevel`
. $FOLDER/Linters/Linting.sh

# Getting file names with changes
FILE_LIST=$(git diff --diff-filter=d --cached --name-only);

linting "$FILE_LIST";
