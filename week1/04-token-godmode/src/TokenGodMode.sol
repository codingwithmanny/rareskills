// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Imports
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title TokenGodeMode token who the deployer can transfer tokens to any address
/// @author @codingwithmanny
/// @notice Basic erc20 token with godmode to transfer tokens to any address
/// @dev An ERC20 token with additional godmode functionality
contract TokenGodeMode is ERC20 {
    // Variables
    address public god;

    /**
     * Initiating constructor
     * @dev sets deployer ad admin and initial supply to 1000
     */
    constructor() ERC20("TokenGodeMode", "TGM") {
        god = msg.sender;
        _mint(msg.sender, 1000);
    }
}

