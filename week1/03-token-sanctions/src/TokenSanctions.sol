// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Imports
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title TokenSanctions token that has admin rights to blacklist addresses
/// @author @codingwithmanny
/// @notice Basic erc20 token with blacklisting addreses from sending and receiving tokens
/// @dev An ERC20 token with additional blacklisting functionality
contract TokenSanctions is ERC20 {
    // Variables
    mapping(address => bool) public _isBlacklisted;
    address public admin;

    /**
     * Initiating constructor
     * @dev sets deployer ad admin and initial supply to 1000
     */
    constructor() ERC20("TokenSanctions", "TKS") {
        admin = msg.sender;
        _mint(msg.sender, 1000);
    }

    // Functions
    // ========================================================
    /**
     * @dev Allows admin to blacklist specific addresses
     */
    function blacklist(address blackListedAddress, bool isBlacklisted) public {
        require(msg.sender == admin, "Admin only allowed to blacklist.");
        _isBlacklisted[blackListedAddress] = isBlacklisted;
    }

    // Overrides
    // ========================================================
    /**
     * @dev hooks into existing `_update` function add blacklisting check
     */
    function _update(
        address from,
        address to,
        uint256 value
    ) internal virtual override {
        require(
            _isBlacklisted[from] == false && _isBlacklisted[to] == false,
            "Address is blacklisted!"
        );
        ERC20._update(from, to, value);
    }
}
