# Robora Smart Contracts Architecture

## Overview
Robora's smart contracts enable tokenized royalties, decentralized compute, and governance for modular robotics.

- **RBR:** ERC-20 for payments/staking.
- **RoyaltyMarketplace:** Handles design sales and splits.
- **DePINCompute:** Manages compute jobs with escrows.
- **RoboraGovernor:** DAO voting using $RBR.

## Interactions
1. Deploy RBRToken first.
2. Pass RBR address to RoyaltyMarketplace and DePINCompute.
3. Use RoboraGovernor for proposals on upgrades.

Security: All contracts use OpenZeppelin; audit recommended.