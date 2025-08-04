const Web3 = require('web3');
class RoboraSDK {
  constructor(rpcUrl) {
    this.web3 = new Web3(new Web3.providers.HttpProvider(rpcUrl));
    this.contract = new this.web3.eth.Contract(ABI, '0xYourContractAddress');
  }
  async getAIModule(moduleId) {
    return await this.contract.methods.getModule(moduleId).call();
  }
}
module.exports = RoboraSDK;
