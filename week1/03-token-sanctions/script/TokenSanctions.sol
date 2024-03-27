// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Imports
import {Script, console} from "forge-std/Script.sol";
import {TokenSanctions} from "../src/TokenSanctions.sol";

/// @title TokenSanctions deploy script
/// @author @codingwithmanny
/// @notice Basic erc20 token with blacklisting addreses from sending and receiving tokens
/// @dev An ERC20 token with additional blacklisting functionality
/// @dev An ERC20 token with additional blacklisting functionality
contract TokenSanctionsScript is Script {
    function setUp() public {
        // N/A
    }

    /**
     * @dev Main deployment script
     */
    function run() public {
        // Setup
        uint256 deployerPrivateKey = vm.envUint("WALLET_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Deploy
        new TokenSanctions();

        // Verify + End
        vm.broadcast();
    }
}
