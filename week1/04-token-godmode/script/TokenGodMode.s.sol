// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Imports
import {Script, console} from "forge-std/Script.sol";
import {TokenGodMode} from "../src/TokenGodMode.sol";

/// @title TokenGodMode deploy script
/// @author @codingwithmanny
/// @notice Basic erc20 token with godmode to transfer tokens to any address
/// @dev An ERC20 token with additional godmode functionality
contract TokenGodModeScript is Script {
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
        new TokenGodMode();

        // Verify + End
        vm.broadcast();
    }
}
