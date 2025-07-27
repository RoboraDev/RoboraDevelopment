# Robora Smart Contracts

This repository contains the Ethereum smart contracts for Robora, a blockchain-powered platform for modular robotics and IoT.

## Contracts
- **RBR.sol:** Native ERC-20 token for payments and staking.
- **RoyaltyMarketplace.sol:** Manages design registrations and royalty splits.
- **DePINCompute.sol:** Handles decentralized compute jobs with escrows.
- **RoboraGovernor.sol:** Governance for community voting.

## Setup
1. Install dependencies: `npm install`
2. Compile: `npx hardhat compile`
3. Test: `npx hardhat test`
4. Deploy to Sepolia: Update hardhat.config.js, then `npx hardhat run scripts/deploy.js --network sepolia`

## Security
Contracts use OpenZeppelin. Audit recommended before mainnet.

## License
MIT