// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DePINCompute is Ownable {
    IERC20 public rbrToken;
    mapping(uint256 => uint256) public jobEscrows; // Job ID to staked amount
    uint256 public nextJobId;

    event JobCompleted(uint256 jobId, address node, uint256 reward);

    constructor(address _rbrAddress) Ownable(msg.sender) {
        rbrToken = IERC20(_rbrAddress);
    }

    function submitJob(uint256 stakeAmount) external returns (uint256) {
        rbrToken.transferFrom(msg.sender, address(this), stakeAmount);
        uint256 jobId = nextJobId++;
        jobEscrows[jobId] = stakeAmount;
        return jobId;
    }

    function completeJob(uint256 jobId, address node) external onlyOwner { // Oracle or verifier calls this
        uint256 amount = jobEscrows[jobId];
        require(amount > 0, "Job not found");

        // Distribute: 95% to node, 5% to platform
        uint256 nodeShare = (amount * 95) / 100;
        uint256 platformShare = amount - nodeShare;

        rbrToken.transfer(node, nodeShare);
        rbrToken.transfer(owner(), platformShare); // Or burn for deflation

        delete jobEscrows[jobId];
        emit JobCompleted(jobId, node, nodeShare);
    }
}