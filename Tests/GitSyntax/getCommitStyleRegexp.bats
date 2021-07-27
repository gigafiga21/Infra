setup() {
    PATH_ROOT=`git rev-parse --show-toplevel`;
    load "$PATH_ROOT/Externals/BatsCore/test_helper/bats-support/load.bash";
    load "$PATH_ROOT/Externals/BatsCore/test_helper/bats-assert/load.bash";
}

@test 'GitSyntax::getCommitStyleRegexp: must echo suitable regexp for "title" preset name' {
    . ./GitSyntax/Commits.sh;
    run getCommitStyleRegexp title;
    assert_output '/^[A-Z].*\.$/p';
    assert_success;
}

@test 'GitSyntax::getCommitStyleRegexp: must echo suitable regexp for "title-issue" preset name' {
    . ./GitSyntax/Commits.sh;
    run getCommitStyleRegexp title-issue;
    assert_output '/^[A-Z].* \(issue \#[0-9]*\)\.$/p';
    assert_success;
}

@test 'GitSyntax::getCommitStyleRegexp: must echo suitable regexp for "conventional" preset name' {
    . ./GitSyntax/Commits.sh;
    run getCommitStyleRegexp conventional;
    assert_output '/^(build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test)(\([^\n]+\)|)!?:([^\n]*[^.]|[^:]*\n[^\n]*\.)$/p';
    assert_success;
}

@test 'GitSyntax::getCommitStyleRegexp: must echo input if first arg is not known as preset name' {
    REGEXP=/^aaaaa.*$/p;
    . ./GitSyntax/Commits.sh;
    run getCommitStyleRegexp $REGEXP;
    assert_output $REGEXP;
    assert_failure 1;
}
