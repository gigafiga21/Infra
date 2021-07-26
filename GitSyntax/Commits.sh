#!/bin/sh

# Gets regexp by it's name for commit style checking
# Echoes regexp, if preset not exists - echoes `$1`
# Returns 0 if preset with name `$1` exists, 1 if not
# {String} $1 - name of the commit style
function getCommitStyleRegexp {
    STYLE_NAME="${1}";

    case "${STYLE_NAME}" in
        title)
            echo '/^[A-Z].*\.$/p';
            return 0 ;;
        title-issue)
            echo '/^[A-Z].* (issue \#[0-9]*)\.$/p';
            return 0 ;;
        conventional)
            echo '';
            return 0 ;;
        *)
            echo "${STYLE_NAME}";
            return 1 ;;
    esac
}

# Checks git commit naming style
# {String} $1 - commit message to check
# {String} --style - style of the commit
function checkCommitStyle {
    # Initialization
    MESSAGE=$1; shift;
    STYLE_NAME="title";
    while [ -n "$1" ]; do
        case "$1" in
            --style)
                STYLE_NAME=$2;
                shift ;;
        esac
        shift;
    done

    # Checking commit syntax
    REGEXP=`getCommitStyleRegexp $STYLE_NAME`;
    TEST=`echo "$MESSAGE" | sed -n "$REGEXP"`;

    if [[ $TEST == "" ]]; then
        printf "\nerror: invalid commit syntax."
        printf "\n\n  Valid syntax must match regexp $REGEXP \n\n"
        return 1;
    fi

    return 0;
}
