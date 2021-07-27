setup() {
    PATH_ROOT=`git rev-parse --show-toplevel`;
    load "$PATH_ROOT/Externals/BatsCore/test_helper/bats-support/load.bash";
    load "$PATH_ROOT/Externals/BatsCore/test_helper/bats-assert/load.bash";
}

@test 'GitSyntax::getNewlineEscape: must select first char in POSSIBLE_NL array for newlines substitution' {
    . ./GitSyntax/Commits.sh;
    run getNewlineEscape "line1\nline2.";
    assert_output 'ζ';
    assert_success;
}

@test 'GitSyntax::getNewlineEscape: must replace newlines with last char in POSSIBLE_NL array which was not used in input string' {
    . ./GitSyntax/Commits.sh;
    run getNewlineEscape "line1\nli\ζne2.";
    assert_output '╣';
    assert_success;
}

@test 'GitSyntax::getNewlineEscape: must return 1 if all chars in POSSIBLE_NL array are used in string' {
    . ./GitSyntax/Commits.sh;
    run getNewlineEscape "\nζ╣";
    assert_output '';
    assert_failure 1;
}
