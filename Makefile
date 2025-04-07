-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil 

help:
	@echo "Usage: "
	@echo "make deploy [ARGS=...]\n		example: make deploy ARGS=\"--network ethsepolia\""
	@echo ""
	@echo "make install"
	@echo ""
	@echo "make coverage"
	@echo ""
	@echo "make all"
	@echo ""

all: clean remove install update build

# Clean the repository
clean :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

# Install necessary libraries
install :; forge install foundry-rs/forge-std@3b20d60d14b343ee4f908cb8079495c07f5e8981 --no-commit && forge install OpenZeppelin/openzeppelin-contracts@acd4ff74de833399287ed6b31b4debf6b2b35527 --no-commit

# Update Dependencies
update :; forge update

# Build the contract
build:; forge build

# Run tests against the contract
test :; forge test 

# Generate a coverage report for the contract
coverage :; forge coverage --report debug > coverage-report.txt

snapshot :; forge snapshot

format :; forge fmt

compile :; forge compile

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_PRIVATE_KEY) --broadcast

ifeq ($(findstring --network ethsepolia,$(ARGS)),--network ethsepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(ETHEREUM_SEPOLIA_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy:
	@forge script script/DeploySimpleStorage.s.sol:DeploySimpleStorage $(NETWORK_ARGS)
