# Solidity Simple Storage

``Solidity Simple Storage`` is a project that aims to familiarize you with Solidity and Smart Contract concepts. It consists of basic features allowing the user to store a number and retrieve it, to be able to add a user through its' username and secret number and retrieve that struct. Moreover, it aims at showcasing how we can create a Deployer script for our smart contract to automatically deploy it on-chain with the help of a HelperConfig for automatic configuration setup.
## Getting Started

### Requirements

- [foundry](https://getfoundry.sh/)
    - You will know your installation is successful if you can run ``forge --version``.

### Setup

Clone this repository:
```
git clone https://github.com/kujen5/Solidity-Simple-Storage
```

## Usage
1. Setup your ``anvil`` chain by running this command in your terminal:
```bash
anvil
```

You will find an RPC URL (``http://127.0.0.1:8545`` by default) and multiple accounts associated with their corresponding private keys. Choose a private key to work with. (The first account private key is hardcoded in the ``HelperConfig.s.sol`` file).


2. Compile your code:
Run:

```bash
forge compile
```

3. Deploying the contract to the Anvil local chain:

Run

```bash
forge script script/DeploySimpleStorage.s.sol --rpc-url http://127.0.0.1:8545  --broadcast
```

You can now interact with your contract on chain!

## Interacting with the Smart Contract

### Adding a secretNumber

Run:
```bash
$ cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "store(uint256)" 1337 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

blockHash               0x398d35cf5f29e1dc90722911aefe69bdcbe7295f4715db06e1e0c5531205dee0
blockNumber             2
contractAddress
cumulativeGasUsed       43549
effectiveGasPrice       880898743
from                    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
gasUsed                 43549
logs                    []
logsBloom               0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
root
status                  1 (success)
transactionHash         0xdee5b2c3d664f44dd94d1c8d9a8adc2c0ba14485b4d2a903b280a0358d76fbcf
transactionIndex        0
type                    2
blobGasPrice            1
blobGasUsed
authorizationList
to                      0x5FbDB2315678afecb367f032d93F642f64180aa3
```

### Retrieving the stored secretNumber

Run:

```bash
$ cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "getSecretNumber()" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
0x0000000000000000000000000000000000000000000000000000000000000539
```

We can validate the value of the stored number like this:

```bash
$ cast --to-base 0x0000000000000000000000000000000000000000000000000000000000000539 decimal
1337
```

### Adding a Person (username, secretNumber)

Run:

```bash
$ cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "getCurrentListOfPeople()" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
0x00000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000539000000000000000000000000000000000000000000000000000000000000000730786b756a656e00000000000000000000000000000000000000000000000000
```

We can verify the value with [this cyberchef recipe](https://cyberchef.io/#recipe=From_Hex('Auto')&input=MHgwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDIwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDUzOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDczMDc4NmI3NTZhNjU2ZTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw) since the hex is too long for the ``cast`` command.

### Retrieving a person from their secretNumber (Yeah this is not secure but for the sake of learning lol)

Run:

```bash
$ cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "getPersonFromSecretNumber(uint256)" 1337 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000730786b756a656e00000000000000000000000000000000000000000000000000
```

### Retrieving a secretNumber from the person name

Run:

```bash
$ cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "getSecretNumberFromPerson(string)" "0xkujen" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
0x0000000000000000000000000000000000000000000000000000000000000539
```

And we can verify it with cast:

```bash
$ cast --to-base 0x0000000000000000000000000000000000000000000000000000000000000539 decimal
1337
```

## Test Coverage

The current test coverage is at 100% with unit tests:

```
╭----------------------------------+-----------------+-----------------+---------------+---------------╮
| File                             | % Lines         | % Statements    | % Branches    | % Funcs       |
+======================================================================================================+
| script/DeploySimpleStorage.s.sol | 100.00% (7/7)   | 100.00% (9/9)   | 100.00% (0/0) | 100.00% (1/1) |
|----------------------------------+-----------------+-----------------+---------------+---------------|
| script/HelperConfig.s.sol        | 100.00% (5/5)   | 100.00% (3/3)   | 100.00% (1/1) | 100.00% (2/2) |
|----------------------------------+-----------------+-----------------+---------------+---------------|
| src/SimpleStorage.sol            | 100.00% (22/22) | 100.00% (16/16) | 100.00% (0/0) | 100.00% (6/6) |
|----------------------------------+-----------------+-----------------+---------------+---------------|
| Total                            | 100.00% (34/34) | 100.00% (28/28) | 100.00% (1/1) | 100.00% (9/9) |
╰----------------------------------+-----------------+-----------------+---------------+---------------╯
```



## To-Do

- Implement more tests (Fuzz Tests / Intergration Tests / Mutations Tests) to better test our code. 100% apparent coverage is not enough.
- Implement Network Configurations for ZkSync Sepolia, Arbitrum Sepolia, and other networks.
- Add more features.

## Thank you!

This project has been made with love as a learning experience. The best is yet to come.
Please give the project a star if you like it!