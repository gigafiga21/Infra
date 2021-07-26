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
    REGEXP=`getCommitStyleRegexp $STYLE_NAME`;

    # Finding safe symbol to substitute newline character for allowing using `\n` in regex
    NL=""
    NL_POSSIBLE=("\ζ")
    if [[ $MESSAGE == *"\n"* ]]; then
        for NL_ITEM in $NL_POSSIBLE; do
            if [[ $MESSAGE != *"$NL_ITEM"* ]]; then
                NL=$NL_ITEM;
                break;
            fi
        done
    
        # Showing error if no substitution symbols found
        if [[ $NL == "" ]]; then
            printf "\nerror: looks like your commit message contains one of the [${NL_POSSIBLE[*]}] symbols.";
            printf "We use one of them to substitute \`\\n\` in the commit messages to extend regexp abilities.";
            printf "Please, rename your commit somehow.";
            return 2;
        fi

        MESSAGE=${MESSAGE//\n/$NL};
        REGEXP=${REGEXP//\n/$NL};
    fi

    # Checking commit syntax
    TEST=`echo -e ${MESSAGE} | sed -n -E "${REGEXP}"`;

    if [[ $TEST == "" ]]; then
        printf "\nerror: invalid commit syntax.";
        printf "\n\n  Valid syntax must match regexp ";
        echo $REGEXP;
        printf " \n\n";
        return 1;
    fi

    return 0;
}
