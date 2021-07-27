setup() {
    PATH_ROOT=`git rev-parse --show-toplevel`;
    load "$PATH_ROOT/Externals/BatsCore/test_helper/bats-support/load.bash";
    load "$PATH_ROOT/Externals/BatsCore/test_helper/bats-assert/load.bash";
}

@test 'GitSyntax::testCommitStyleRegexp: must fit desired commit messages for "title" preset regex' {
    source ./GitSyntax/Commits.sh;
    REGEXP=`getCommitStyleRegexp title`;

    # Must accept following commit messages
    for COMMIT_MSG in "Commit name." "Commit 123 name."; do
        run testCommitStyleRegexp "$COMMIT_MSG" "$REGEXP";
        assert_output;
    done

    # Must reject following commit messages
    for COMMIT_MSG in "Commit name" "4ommit name." "commit name."; do
        run testCommitStyleRegexp "$COMMIT_MSG" "$REGEXP";
        assert_output '';
    done
}

@test 'GitSyntax::testCommitStyleRegexp: must fit desired commit messages for "title-issue" preset regex' {
    source ./GitSyntax/Commits.sh;
    REGEXP=`getCommitStyleRegexp title-issue`;

    # Must accept following commit messages
    for COMMIT_MSG in "Commit name (issue #1)." "Commit 123 name (issue #256)."; do
        run testCommitStyleRegexp "$COMMIT_MSG" "$REGEXP";
        assert_output;
    done

    # Must reject following commit messages
    for COMMIT_MSG in "Commit name." "4ommit name (issue #256)." "Commit name (issue #b)." "Commit name (#1)."; do
        run testCommitStyleRegexp "$COMMIT_MSG" "$REGEXP";
        assert_output '';
    done
}

@test 'GitSyntax::testCommitStyleRegexp: must fit desired commit messages for "conventional" preset regex' {
    source ./GitSyntax/Commits.sh;
    REGEXP=`getCommitStyleRegexp conventional`;

    # Must accept commit messages of following types
    for COMMIT_TYPE in "build" "chore" "ci" "docs" "feat" "fix" "perf" "refactor" "revert" "style" "test"; do
        run testCommitStyleRegexp "$COMMIT_TYPE: commit name" "$REGEXP";
        assert_output;
    done

    # Must accept following commit messages with scope and important commits
    for COMMIT_MSG in "feat!: commit name" "feat(scope): commit name" "feat(scope)!: commit name"; do
        run testCommitStyleRegexp "$COMMIT_MSG" "$REGEXP";
        assert_output;
    done

    # Must accept following multiline commit messages
    for COMMIT_MSG in "feat: line 1\nline 2." "feat: line 1\nline 2\nfooter: line 3." "feat: line 1\nline 2\nline 3\nfooter: line 4."; do
        NL=`getNewlineEscape "$COMMIT_MSG"`;
        MESSAGE=${COMMIT_MSG//\\n/$NL};
        REGEXP=${REGEXP//\\n/$NL};

        run testCommitStyleRegexp "$MESSAGE" "$REGEXP";
        assert_output ;
    done

    # Must reject following commit messages
    for COMMIT_MSG in "commit name" "feat: commit name." "feat(): commit name" "feat(a\nb): commit name" "fix:"; do
        run testCommitStyleRegexp "$COMMIT_MSG" "$REGEXP";
        assert_output '';
    done

    # Must reject following multilite commit messages
    for COMMIT_MSG in "feat: line 1\ntype: line 2\nline 3." "feat: line 1\nline 2"; do
        NL=`getNewlineEscape "$COMMIT_MSG"`;
        MESSAGE=${COMMIT_MSG//\\n/$NL};
        REGEXP=${REGEXP//\\n/$NL};

        run testCommitStyleRegexp "$MESSAGE" "$REGEXP";
        assert_output '';
    done
}
