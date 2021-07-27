setup() {
    PATH_ROOT=`git rev-parse --show-toplevel`;
    load "$PATH_ROOT/Externals/BatsCore/test_helper/bats-support/load.bash";
    load "$PATH_ROOT/Externals/BatsCore/test_helper/bats-assert/load.bash";
}

@test 'GitSyntax::checkCommitStyle: must check with "title" preset by default' {
    . ./GitSyntax/Commits.sh;
    run checkCommitStyle "Commit message.";
    assert_output '';
    assert_success;
}

@test 'GitSyntax::checkCommitStyle: must check with preset from "--style" key' {
    . ./GitSyntax/Commits.sh;

    run checkCommitStyle "Commit message." --style "title";
    assert_output '';
    assert_success;

    run checkCommitStyle "Commit message (issue #256)." --style "title-issue";
    assert_output '';
    assert_success;

    run checkCommitStyle "feat: commit message" --style "conventional";
    assert_output '';
    assert_success;
}

@test 'GitSyntax::checkCommitStyle: must return 1 when commit not fit preset' {
    . ./GitSyntax/Commits.sh;
    run checkCommitStyle "Commit message" --style "title";
    assert_failure 1;
}

@test 'GitSyntax::checkCommitStyle: must not run getNewlineEscape if there are no newlines' {
    . ./GitSyntax/Commits.sh;
    run checkCommitStyle "feat: support for symbolsζ╣" --style "conventional";
    assert_success;
}

@test 'GitSyntax::checkCommitStyle: must return 2 when all symbols for replacing newlines are used in commit message' {
    . ./GitSyntax/Commits.sh;
    run checkCommitStyle "feat: support for sumbols\nζ╣." --style "conventional";
    assert_failure 2;
}
