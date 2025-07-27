require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();  // Loads .env variables

module.exports = {
  solidity: "0.8.20",
  networks: {
    hardhat: {},
    sepolia: {  // Keep for testing
      url: `https://sepolia.infura.io/v3/${process.env.INFURA_KEY}`,
      accounts: [process.env.PRIVATE_KEY]
    },
    mainnet: {  // Added for Ethereum mainnet
      url: `https://mainnet.infura.io/v3/${process.env.INFURA_KEY}`,  // Or Alchemy: https://eth-mainnet.g.alchemy.com/v2/${process.env.ALCHEMY_KEY}
      accounts: [process.env.PRIVATE_KEY],
      gasPrice: "auto",  // Auto-estimate, or set e.g., 20000000000 (20 gwei)
      chainId: 1
    }
  }
};