# Infra
Everything for project infrastructure - scripts, configs, etc. for fast start.

## Available scripts
- git syntax checks (branches, commits msgs, etc.)
    - [Commit msg checking](#commit-msg)
    - [Branch name checking](#branch-name)
- [linting](#linting)
- build
    - [universal makefile for cpp](#cpp-make)


## <a name="commit-msg"></a> Commit msg checking
Script is in file `GitSyntax/Commit.sh`  

Bash function `checkCommitStyle`  
```sh
# Checks git commit naming style:
# `[Commmit msg starting from capital letter] (issue #[issue id]).`
# {String} $1 - commit message to check
# {String} --style - preset name for checking commit style
```

Example of usage:
```sh
. ./GitSyntax/Commits.sh
checkCommitStyle $COMMITMSG
```
For more examples see `Examples/Commit-*.sh` scripts.


## <a name="branch-name"></a> Branch name checking
Script is in file `GitSyntax/Branch.sh`  

Bash function `checkBranchStyle`  
```sh
# Checks current git branch naming style:
# `[developer's nickname].[2words-issue-description-with-dash-separator].[issue id]`
# {Boolean} $1 - loaded in CI or not
```

Example of usage:
```sh
. ./GitSyntax/Branch.sh
checkBranchStyle $IS_IN_CI
```
For more examples see `Examples/Branch-*.sh` scripts.

## <a name="linting"></a> Linting
Script is in file `Linters/Linting.sh`  

Bash function `linting`  
```sh
# Run linters with configs in folder where script locates
# Now available ESLint
# {String} $1 - file list to lint
```

Example of usage:
```sh
. ./Linting/Linting.sh
linting $LIST_OF_CHANGED_FILES
```
For more examples see `Examples/Linting-*.sh` scripts.

## <a name="cpp-make"></a> Universal makefile for cpp
Compiles incrementally every `*.cpp` file into `*.o` into `Objects` directory. After that builds binary file into `Build` folder. To build test project enter `Build/Cpp` and type `make`.
