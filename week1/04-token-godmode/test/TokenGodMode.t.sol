// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// Imports
import {Test, console} from "forge-std/Test.sol";
import {TokenGodMode} from "../src/TokenGodMode.sol";

/// @title Tests for TokenGodMode
/// @author @codingwithmanny
/// @notice Basic erc20 token with godmode to transfer tokens to any address
/// @dev An ERC20 token with additional godmode functionality
contract TokenSanctionsTest is Test {
    // Variables
    TokenGodMode public token;
    address deployerGodAddress = makeAddr("ImGodOverAll");
    address randomSenderAddress = makeAddr("SendMeTokens");
    address randomReceiverAddress = makeAddr("GiveMeTokens"); 

    // Setup
    // ========================================================
    /**
     * @dev Initial contract setup
     */
    function setUp() public {
        vm.prank(deployerGodAddress);
        token = new TokenGodMode();
    }

    // Check initial deployed values
    /**
     * @dev Check initial supply for deploy contract
     */
    function test_checkSupply() public view {
        // Tests
        assertEq(token.totalSupply(), 1000);
        assertEq(token.balanceOf(deployerGodAddress), 1000);
        assertEq(token.balanceOf(randomSenderAddress), 0);
        assertEq(token.balanceOf(randomReceiverAddress), 0);
    }

    /**
     * @dev Checks to ensure the correct god address is set
     */
    function test_godAddress() public view {
        // Tests
        assertEq(token.god(), deployerGodAddress);
    }

    // Checks transfer functionality
    /**
     * @dev Checks to that transfers work as expected
     */
    function test_initialTokenTransfer() public {
        // Setup
        vm.prank(deployerGodAddress);
        token.transfer(randomSenderAddress, 100);
        vm.prank(randomSenderAddress);
        token.transfer(randomReceiverAddress, 30);

        // Tests
        assertEq(token.balanceOf(deployerGodAddress), 900);
        assertEq(token.balanceOf(randomSenderAddress), 70);
        assertEq(token.balanceOf(randomReceiverAddress), 30);
    }

    /**
     * @dev Checks that a transfer from a non-god account can't transfer
     */
    function test_setGodTransferFails() public {
        // Setup
        vm.expectRevert(
            abi.encodeWithSignature(
                "ERC20InsufficientAllowance(address,uint256,uint256)",
                randomSenderAddress,
                0,
                30
            )
        );
        vm.prank(randomSenderAddress);
        token.transferFrom(deployerGodAddress, randomReceiverAddress, 30);

        // Tests
        assertEq(token.balanceOf(deployerGodAddress), 1000);
        assertEq(token.balanceOf(randomReceiverAddress), 0);
    }

    /**
     * @dev Checks that a god account can make transfers for anyone
     */
    function test_setGodTransferSucceeds() public {
        // Setup
        vm.prank(deployerGodAddress);
        token.transfer(randomSenderAddress, 100);
        vm.prank(deployerGodAddress);
        token.transferFrom(randomSenderAddress, randomReceiverAddress, 30);

        // Tests
        assertEq(token.balanceOf(deployerGodAddress), 900);
        assertEq(token.balanceOf(randomSenderAddress), 70);
        assertEq(token.balanceOf(randomReceiverAddress), 30);
    }
}
