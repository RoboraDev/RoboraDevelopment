# Robora Smart Contracts Architecture

# Infrastructure and Tech

## Blockchain
- **Chain**: Ethereum
- **Identity**: ERC-725 PKI tokens
- **Escrow**: Multi-signature smart contracts
- **Registries**: ERC-1155 for metadata
- **Scalability**: Rollup batching
- **RoyaltyMarketplace:** Handles design sales and splits.
- **DePINCompute:** Manages compute jobs with escrows.
- **RoboraGovernor:** DAO voting using $RBR.


## Decentralized Compute
- **Node Operators**: Staked $RBR holders with GPUs/TPUs
- **Reputation**: Chainlink oracles, 10-20% slashing
- **SLAs**: Smart contract enforcement (<50ms latency)

## Hardware-Firmware Compatibility
- **Standard**: ROS 2 REP-2008
- **API**: ROS-2 message types, DDS middleware
- **Future**: Ethereum-ROS bridge
  
