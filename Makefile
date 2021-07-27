# Path to the folder with external projects used here
INFRA_PATH=Externals
# Path to folder with tests for GitSyntax package, overload to run custom test suit
TESTSUITS_GITSYNTAX=Tests/GitSyntax

.PHONY: clear

##
# Helpers section
# Resets state of the repo to default (right after cloning, before `make install`)
clear:
	rm -rf $(INFRA_PATH)/*

##
# Installation section
# Installs everything possible
install: clear install-bats

# Installs BatsCore Bash testing framework
install-bats:
	mkdir -p $(INFRA_PATH)/BatsCore/
	git clone https://github.com/bats-core/bats-core.git $(INFRA_PATH)/BatsCore/bats
	git clone https://github.com/bats-core/bats-support.git $(INFRA_PATH)/BatsCore/test_helper/bats-support
	git clone https://github.com/bats-core/bats-assert.git $(INFRA_PATH)/BatsCore/test_helper/bats-assert

##
# Testing section
# Runs all tests possible
test: test-git-syntax

# Runs BatsCore Bash testsuits
test-git-syntax:
	$(INFRA_PATH)/BatsCore/bats/bin/bats $(TESTSUITS_GITSYNTAX)
