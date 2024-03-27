// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Imports
import {Test, console} from "forge-std/Test.sol";
import {TokenSanctions} from "../src/TokenSanctions.sol";

/// @title Tests for TokenSanctions
/// @author @codingwithmanny
/// @notice Basic tests for erc20 token with blacklisting addreses from sending and receiving tokens
/// @dev Testing ERC20 token with additional blacklisting functionality
contract TokenSanctionsTest is Test {
    // Variables
    TokenSanctions public token;
    address deployerAdminAddress = makeAddr("ImAdminOverAll"); // 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496
    address blacklistMeAddress = makeAddr("GiveMeTokens"); // 0x187A660c372Fa04D09C1A71f2927911e62e98a89

    // Setup
    // ========================================================
    /**
     * @dev Initial contract setup
     */
    function setUp() public {
        vm.prank(deployerAdminAddress);
        token = new TokenSanctions();
    }

    // Check initial deployed values
    /**
     * @dev Check initial supply for deploy contract
     */
    function test_checkSupply() public view {
        // Tests
        assertEq(token.totalSupply(), 1000);
        assertEq(token.balanceOf(deployerAdminAddress), 1000);
        assertEq(token.balanceOf(blacklistMeAddress), 0);
    }

    /**
     * @dev Checks to ensure that initial blacklisting values have been set
     */
    function test_initialBlacklisted() public view {
        // Tests
        assertEq(token._isBlacklisted(deployerAdminAddress), false);
        assertEq(token._isBlacklisted(blacklistMeAddress), false);
    }

    // Checks transfer functionality
    /**
     * @dev Checks to that transfers are allowed
     */
    function test_initialTokenTransfer() public {
        // Setup
        vm.prank(deployerAdminAddress);
        token.transfer(blacklistMeAddress, 100);

        // Tests
        assertEq(token.balanceOf(deployerAdminAddress), 900);
        assertEq(token.balanceOf(blacklistMeAddress), 100);
    }

    /**
     * @dev Checks that blacklisting can only be performed by the admin
     */
    function test_setBlacklistingFails() public {
        // Setup
        vm.expectRevert("Admin only allowed to blacklist.");
        vm.prank(blacklistMeAddress);
        token.blacklist(deployerAdminAddress, true);

        // Tests
        assertEq(token._isBlacklisted(deployerAdminAddress), false);
        assertEq(token._isBlacklisted(blacklistMeAddress), false);
    }

    /**
     * @dev Checks that blacklisting successfully blacklists a user
     */
    function test_setBlacklistingSucceeds() public {
        // Setup
        vm.prank(deployerAdminAddress);
        token.blacklist(blacklistMeAddress, true);

        // Tests
        assertEq(token._isBlacklisted(deployerAdminAddress), false);
        assertEq(token._isBlacklisted(blacklistMeAddress), true);
    }

    /**
     * @dev Checks that a blacklisted user cannot transfer tokens
     */
    function test_transferFails() public {
        // Setup
        vm.startPrank(deployerAdminAddress);
        token.transfer(blacklistMeAddress, 100);
        token.blacklist(blacklistMeAddress, true);
        vm.stopPrank();

        // Tests
        vm.expectRevert("Address is blacklisted!");
        vm.prank(blacklistMeAddress);
        token.transfer(deployerAdminAddress, 100);
        
        assertEq(token.balanceOf(deployerAdminAddress), 900);
        assertEq(token.balanceOf(blacklistMeAddress), 100);
    }
}
