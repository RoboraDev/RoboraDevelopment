// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AIModuleRegistry is Ownable {
    // Reference to $RBR token for optional fees
    IERC20 public rbrToken;

    struct Module {
        address moduleAddress; // Contract or off-chain address for the AI module
        string version; // e.g., "v1.0"
        string ipfsHash; // IPFS CID for metadata (model details, weights)
        bool active; // Flag to enable/disable
    }

    mapping(string => Module) public modules; // Name (e.g., "YOLOv8") to Module struct

    event ModuleRegistered(string name, address moduleAddress, string version, string ipfsHash);
    event ModuleUpdated(string name, address newAddress, string newVersion, string newIpfsHash);
    event ModuleRemoved(string name);

    constructor(address _rbrAddress) Ownable(msg.sender) {
        rbrToken = IERC20(_rbrAddress);
    }

    /**
     * @dev Register a new AI module. Only owner can call. Optional fee in $RBR.
     * @param name Unique name for the module (e.g., "Gemini-lite")
     * @param moduleAddress Address of the module contract or handler
     * @param version Version string
     * @param ipfsHash IPFS hash for metadata
     * @param fee Amount of $RBR to charge (0 for free registration)
     */
    function registerModule(
        string memory name,
        address moduleAddress,
        string memory version,
        string memory ipfsHash,
        uint256 fee
    ) external onlyOwner {
        require(modules[name].moduleAddress == address(0), "Module already exists");
        if (fee > 0) {
            rbrToken.transferFrom(msg.sender, address(this), fee); // Fee to platform treasury
        }
        modules[name] = Module(moduleAddress, version, ipfsHash, true);
        emit ModuleRegistered(name, moduleAddress, version, ipfsHash);
    }

    /**
     * @dev Update an existing module's details. Only owner.
     */
    function updateModule(
        string memory name,
        address newAddress,
        string memory newVersion,
        string memory newIpfsHash
    ) external onlyOwner {
        require(modules[name].moduleAddress != address(0), "Module not found");
        modules[name].moduleAddress = newAddress;
        modules[name].version = newVersion;
        modules[name].ipfsHash = newIpfsHash;
        emit ModuleUpdated(name, newAddress, newVersion, newIpfsHash);
    }

    /**
     * @dev Remove a module (set inactive or delete). Only owner.
     */
    function removeModule(string memory name) external onlyOwner {
        require(modules[name].moduleAddress != address(0), "Module not found");
        delete modules[name]; // Or set active = false for soft delete
        emit ModuleRemoved(name);
    }

    /**
     * @dev Get module details by name. View function for anyone.
     */
    function getModule(string memory name) external view returns (address moduleAddress, string memory version, string memory ipfsHash, bool active) {
        Module memory mod = modules[name];
        require(mod.moduleAddress != address(0), "Module not found");
        return (mod.moduleAddress, mod.version, mod.ipfsHash, mod.active);
    }

    /**
     * @dev Check if a module exists.
     */
    function moduleExists(string memory name) external view returns (bool) {
        return modules[name].moduleAddress != address(0);
    }
}
