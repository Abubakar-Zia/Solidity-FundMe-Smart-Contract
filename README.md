# FundMe Smart Contract

## Overview

This repository contains Solidity smart contracts that form a simple, yet powerful, decentralized crowdfunding platform. The primary contract, `FundMe`, allows users to contribute funds (in Ether) while ensuring that the contribution meets a minimum USD threshold. The contract owner has the exclusive right to withdraw the accumulated funds. This project demonstrates the integration of Chainlink oracles for price feeds, making it a great learning tool for blockchain developers.

## Contents

### 1. `FundMe.sol`

**Description**:  
The `FundMe` contract allows users to fund the contract with Ether. It ensures that the Ether sent by users meets a minimum value in USD, utilizing the `PriceConvertor` library for currency conversion. 

**Key Features**:

- **Owner Control**: 
  - The contract has an owner, designated as the deployer of the contract. The owner can withdraw all funds from the contract.
  
- **Funding**:
  - Users can contribute Ether to the contract by calling the `fund()` function or by sending Ether directly to the contract address, which triggers the `receive()` or `fallback()` functions.
  - Each funding transaction is recorded, and the total contribution of each user is tracked.
  
- **Withdrawal**:
  - Only the contract owner can withdraw all funds. When the withdrawal is executed, all user balances are reset, and the entire balance of the contract is transferred to the owner.

- **Modifiers**:
  - `onlyOwner`: Restricts certain functions to the contract owner. 

- **Fallback & Receive**:
  - `receive()`: Triggered when Ether is sent to the contract without any data. It calls the `fund()` function.
  - `fallback()`: Triggered when a function that does not exist is called or when Ether is sent without any data. It also calls the `fund()` function.

**Functions**:

- `fund()`: Allows users to fund the contract, provided the amount meets the minimum USD requirement.
- `withdraw()`: Allows the owner to withdraw all Ether from the contract, resetting the balances of all funders.
- `receive()`: Receives Ether and calls `fund()`.
- `fallback()`: Fallback function that also calls `fund()`.

**Constants and Variables**:

- `MINIMUM_USD`: The minimum amount of USD (in Wei) required for funding (set to 5 USD in the contract).
- `i_owner`: Immutable variable storing the owner’s address.
- `funders`: Array of addresses that have funded the contract.
- `addressesToFunded`: Mapping of funder addresses to the amount they have funded.

### 2. `PriceConvertor.sol`

**Description**:  
The `PriceConvertor` library provides utility functions to convert Ether amounts to their equivalent USD value. It uses Chainlink’s price feeds to fetch real-time Ether prices in USD.

**Key Features**:

- **Chainlink Price Feeds**:
  - Integrates with Chainlink’s `AggregatorV3Interface` to fetch the latest price of Ether in USD.
  
- **Conversion Utility**:
  - Provides a function to convert Ether amounts (in Wei) to their equivalent USD value (also in Wei).

**Functions**:

- `getPrice()`: Retrieves the latest price of 1 Ether in USD. Returns the price scaled to Wei.
- `getConversionRate(uint256 ethAmount)`: Converts a given Ether amount (in Wei) to USD (in Wei) using the latest price.
- `getVerson()`: Returns the version of the Chainlink price feed being used.

## Installation and Setup

### Prerequisites

- **Solidity Compiler**: Version 0.8.18 or later.
- **Node.js**: For running scripts and managing dependencies.
- **Hardhat or Truffle**: Development framework for deploying and testing the smart contracts.
- **Chainlink Oracles**: Access to Chainlink price feeds for real-time Ether pricing.

### Setup Steps

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/your-username/fundme-smart-contract.git
   cd fundme-smart-contract
   ```

2. **Install Dependencies** (if using Hardhat or Truffle):
   ```sh
   npm install
   ```

3. **Compile the Contracts**:
   ```sh
   npx hardhat compile
   ```

4. **Deploy the Contracts**:
   Deploy the `FundMe` contract to your preferred Ethereum network.
   ```sh
   npx hardhat run scripts/deploy.js --network your-network
   ```
   Make sure to set up the network configuration in the `hardhat.config.js` file.

### Environment Variables

To interact with the Ethereum network, you may need to configure environment variables such as:

- `ALCHEMY_API_KEY`: Your Alchemy API key for Ethereum access.
- `PRIVATE_KEY`: Your private key for deploying the contract.
- `CHAINLINK_ETH_USD_ADDRESS`: The address of the Chainlink price feed contract on your network.

Example `.env` file:

```env
ALCHEMY_API_KEY=your-alchemy-api-key
PRIVATE_KEY=your-private-key
CHAINLINK_ETH_USD_ADDRESS=0x694AA1769357215DE4FAC081bf1f309aDC325306
```

## Usage

### Funding the Contract

1. **Via the `fund()` Function**:
   - Users can call the `fund()` function and send Ether along with the transaction. The amount of Ether must be equivalent to or exceed the `MINIMUM_USD` requirement.

2. **Via Direct Ether Transfer**:
   - Users can send Ether directly to the contract’s address. This will automatically invoke the `fund()` function via the `receive()` or `fallback()` function.

### Withdrawing Funds

- Only the contract owner can withdraw the entire balance by calling the `withdraw()` function. All funds will be transferred to the owner’s address, and all user balances will be reset.

## Testing

You can write unit tests for the contracts using Hardhat or Truffle. Here’s a basic example using Hardhat:

```sh
npx hardhat test
```

This will run all the test cases defined in the `test` directory.

## Contributing

Contributions are welcome! Please fork this repository, create a new branch for your feature or bugfix, and submit a pull request. Make sure to include tests for any new functionality.

## Contact

For further inquiries or feedback, you can reach out:

**Email**: abu.bakar.zia146@proton.me