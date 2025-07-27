// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract RoboraGovernor is Governor, GovernorSettings, GovernorCountingSimple {
    constructor(ERC20Votes _token)
        Governor("RoboraGovernor")
        GovernorSettings(1 /* 1 block */, 45818 /* 1 week */, 0)
    {}

    // Voting logic uses $RBR as voting weight via ERC20Votes
}