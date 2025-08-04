# Inside DePINNode class
def submit_job(self, stake_amount):
    contract_address = '0xYourContractAddress'
    abi = [your ABI here]  # From DePINCompute.sol
    contract = self.w3.eth.contract(address=contract_address, abi=abi)
    tx_hash = contract.functions.submitJob(stake_amount).transact({'from': '0xYourWallet'})
    self.get_logger().info(f'Job submitted on-chain: {tx_hash.hex()}')
