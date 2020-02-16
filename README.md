# Infra
Everything for project infrastructure - scripts, configs, etc. for fast start.

## Available scripts
- git syntax checks (branches, commits msgs, etc.)
    - [Commit msg checking](#commit-msg)
    - [Branch name checking](#branch-name)


## <a name="commit-msg"></a> Commit msg checking
Script is in file `GitSyntax/Commit.sh`  

Bash function `checkCommitStyle`  
```sh
# Checks git commit naming style
# {String} $1 - commit message to check
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
# Checks current git branch naming style
# {Boolean} $1 - loaded in CI or not
```

Example of usage:
```sh
. ./GitSyntax/Branch.sh
checkBranchStyle $IS_IN_CI
```
For more examples see `Examples/Branch-*.sh` scripts.
