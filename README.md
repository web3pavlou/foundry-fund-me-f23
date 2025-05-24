

# Foundry-Fund-Me-F23


![Build Status](https://github.com/web3pavlou/foundry-fund-me-f23/actions/workflows/ci.yml/badge.svg) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE) ![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg) ![Issues](https://img.shields.io/github/issues/web3pavlou/foundry-fund-me-f23)




***A minimal, production-style crowdfunding smart contract system built with **Foundry**, **Chainlink Data Feeds**, and modern **Solidity** patterns.***

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [zkSync Compatibility](#zksync-compatibility)
- [Getting Started](#getting-started)
- [Development Environment](#development-environment)
- [Installation](#installation)
- [Makefile Support](#makefile-support)
- [Configuration & Usage](#configuration--usage)
- [Wallet Import via Foundry (cast)](#wallet-import-via-foundry-cast)
- [Compile and Run Tests](#compile-and-run-tests)
- [Deploy to Sepolia](#deploy-to-sepolia-or-another-supported-network)
- [Start a Local Anvil Node](#start-a-local-anvil-node)
- [Deploy Locally](#deploy-locally)
- [Unit Tests](#unit-tests)
- [Integration Tests](#integration-tests)
- [Contributing](#contributing)
- [Scripts Overview](#scripts-overview)
- [Dependencies](#dependencies)
- [Security](#security)
- [License](#license)
- [Acknowledgments](#acknowledgments)


---

## Overview

***The FundMe contract is a crowdfunding smart contract that:***

- Accepts ETH payments with a minimum USD threshold  

- Uses Chainlink Price Feeds for ETH/USD conversion  

- Maintains a record of funders and their contributions  

- Includes withdrawal functionality restricted to the contract owner  

- Supports both local and testnet deployments

- Compatible with zkSync via Foundry's zkSync toolchain integration



---

## Features

- **FundMe.sol**: Accepts ETH contributions, tracks funders, and allows only the owner to withdraw.
- **Chainlink Price Feeds**: Enforces a minimum USD-denominated funding amount.
- **Mock Aggregator**: Supports local testing using Anvil.
- **Automated Scripts**: Deploy, fund, and withdraw using Foundry scripts.
- **Comprehensive Tests**: Includes both unit and integration tests with Foundry’s native test framework.

---


## zkSync Compatibility

This project can be optionally used with [zkSync Era](https://zksync.io) for testing and deployment.

To install the Foundry toolchain with zkSync support:

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup --zksync
```


##  Getting Started

###  Prerequisites

- [Foundry](https://book.getfoundry.sh/)
- Node.js (optional, for npm-based dependencies)
- Git
- [foundry-devops](https://github.com/Cyfrin/foundry-devops)
- [forge-std](https://github.com/foundry-rs/forge-std)
- [chainlink-brownie-contracts](https://github.com/smartcontractkit/chainlink-brownie-contracts)

---

## Development Environment

This project was primarily developed and tested inside **Windows Subsystem for Linux (WSL)** on Windows 10/11.


If using WSL:
- Use a supported Linux distro (e.g., Ubuntu 20.04 or later).
- Install Foundry and dependencies within WSL (not native Windows).
- Be aware of potential filesystem and networking differences between Windows and WSL.


Linux and macOS users can follow the standard instructions without modification.

---

##  Installation

Clone the repo and install dependencies:

```bash
git clone https://github.com/web3pavlou/foundry-fund-me-f23.git
cd foundry-fund-me-f23
forge install
```

---

### Makefile Support
This project includes a Makefile to streamline common tasks like building, deploying, and testing — including zkSync compatibility.

Make sure you have GNU make installed (default on Linux/macOS; Windows users can use it via WSL or Git Bash).

***Common Commands:***
```bash
make build         # Compile contracts with Forge
make test          # Run tests
make anvil         # Start local Anvil node with tracing and block time
make deploy        # Deploy to local Anvil using default test private key
make deploy-sepolia # Deploy to Sepolia with verification
make update        # Update Forge dependencies
make zktest        # Run zkSync-compatible tests using foundryup-zksync
make interact      # Interact with deployed contracts locally
```

---

##  Configuration & Usage

###### Copy the `.env.example` file and fill in your RPC URLs and private key:  


```bash  
cp .env.example .env # Then edit .env with your actual values
```

---

## Wallet Import via Foundry (cast)
A much more safer way is importing a wallet (private key) into Foundry’s keystore using the new cast wallet import feature.This way the user can encrypt his password locally without saving it in a ` .env ` file :
```bash
cast wallet import my_wallet_name --private-key $PRIVATE_KEY
```

>📌 Available since Foundry PR [#5551](https://github.com/foundry-rs/foundry/pull/5551). Make sure you're using a recent version of Foundry (foundryup) to access this feature.

---

## Compile and run tests
```bash  
forge build
forge test
```



## Deploy to Sepolia (or another supported network)
```bash  
forge script script/DeployFundMe.s.sol:DeployFundMe \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --verify \
  --etherscan-api-key $ETHERSCAN_API_KEY \
  -vvvv
  ```



## Start a local Anvil node
```bash  
anvil
```


## Deploy locally
```bash  
forge script script/DeployFundMe.s.sol:DeployFundMe \
  --broadcast \
  --rpc-url <RPC_URL> \
  --private-key <PRIVATE_KEY>
  ```

---


## Unit tests
```bash  
forge test
```

## Integration tests

```bash
forge test --match-path test/integration/*
```

---

## Contributing 
PRs are welcome!

```bash
git clone https://github.com/web3pavlou/foundry-fund-me-f23.git
cd foundry-fund-me-f23
make

```

---

## Scripts Overview

**DeployFundMe.s.sol**: Deploys the FundMe contract.

**HelperConfig.s.sol**: Handles network configuration and mock deployments.

**Interactions.s.sol**: Fund and withdraw ETH from FundMe via script.

---

## Dependencies

- Chainlink Contracts

- forge-std

- foundry-devops

---

## Security

- The contract includes access control mechanisms

- Owner-only withdrawal functionality

- Secure fund management

- Comprehensive test coverage

---

## License

This project is licensed under the [MIT License](LICENSE).


---

 ## Acknowledgments

- **Chainlink** – for providing reliable price feed oracles  
- **Foundry** – for the fast and modern smart contract development framework

---
