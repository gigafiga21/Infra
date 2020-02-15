# Infra
Everything for project infrastructure - scripts, configs, etc. for fast start.

## Available scripts
- git syntax checks (branches, commits msgs, etc.)
    - [Commit msg checking](#commit-msg)


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
