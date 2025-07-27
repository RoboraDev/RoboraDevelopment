// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract RoyaltyMarketplace is AccessControl {
    bytes32 public constant DESIGNER_ROLE = keccak256("DESIGNER_ROLE");
    IERC20 public rbrToken;

    struct Design {
        uint256 id;
        address designer;
        uint256 price;
        uint256 royaltyRate; // e.g., 7000 for 70%
    }

    mapping(uint256 => Design) public designs;
    uint256 public nextId;

    event DesignSold(uint256 id, address buyer, uint256 amount);

    constructor(address _rbrAddress) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        rbrToken = IERC20(_rbrAddress);
    }

    function registerDesign(uint256 price, uint256 royaltyRate) external onlyRole(DESIGNER_ROLE) {
        designs[nextId] = Design(nextId, msg.sender, price, royaltyRate);
        nextId++;
    }

    function buyDesign(uint256 id) external {
        Design storage design = designs[id];
        require(design.id == id, "Design not found");

        uint256 amount = design.price;
        rbrToken.transferFrom(msg.sender, address(this), amount);

        // Distribute royalties: 70% designer, 20% platform, 10% pool
        uint256 designerShare = (amount * design.royaltyRate) / 10000;
        uint256 platformShare = (amount * 2000) / 10000;
        uint256 poolShare = amount - designerShare - platformShare;

        rbrToken.transfer(design.designer, designerShare);
        rbrToken.transfer(owner(), platformShare); // Platform wallet
        // Pool logic: e.g., transfer to a rewards contract

        emit DesignSold(id, msg.sender, amount);
    }
}