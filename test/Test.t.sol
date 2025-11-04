// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address public ALICE = makeAddr("alice");
    address public BOB = makeAddr("bob");

    uint256 public constant INITIAL_SUPPLY = 1100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();
    }

    // ---  Basic Tests ---

    function testNameAndSymbol() public view {
        assertEq(ourToken.name(), "OurToken");
        assertEq(ourToken.symbol(), "OT");
    }

    function testInitialSupplyBelongsToMsgSender() public view {
        // In this case msg.sender
        assertEq(ourToken.balanceOf(msg.sender), INITIAL_SUPPLY);
        assertEq(ourToken.totalSupply(), INITIAL_SUPPLY);
    }

    // ---  Transfer Tests ---

    function testTransferFromMsgSenderToAlice() public {
        uint256 transferAmount = 10 ether;

        // msg.sender is the test contract, which owns all tokens
        vm.prank(msg.sender);
        ourToken.transfer(ALICE, transferAmount);

        assertEq(ourToken.balanceOf(ALICE), transferAmount);
        assertEq(ourToken.balanceOf(msg.sender), INITIAL_SUPPLY - transferAmount);
    }

    function testTransferFailsIfNotEnoughBalance() public {
        uint256 transferAmount = 1 ether;

        // ALICE has no tokens
        vm.prank(ALICE);
        vm.expectRevert();
        ourToken.transfer(BOB, transferAmount);
    }

    // ---  Allowance Tests ---

    function testApproveAndAllowance() public {
        uint256 allowanceAmount = 5 ether;

        vm.prank(msg.sender);
        ourToken.approve(ALICE, allowanceAmount);

        assertEq(ourToken.allowance(msg.sender, ALICE), allowanceAmount);
    }

    function testTransferFromWorksWithAllowance() public {
        uint256 allowanceAmount = 5 ether;
        uint256 spendAmount = 2 ether;

        // msg.sender approves ALICE to spend
        vm.prank(msg.sender);
        ourToken.approve(ALICE, allowanceAmount);

        // ALICE uses transferFrom to spend
        vm.prank(ALICE);
        ourToken.transferFrom(msg.sender, BOB, spendAmount);

        assertEq(ourToken.balanceOf(BOB), spendAmount);
        assertEq(ourToken.allowance(msg.sender, ALICE), allowanceAmount - spendAmount);
    }

    function testTransferFromFailsWithoutEnoughAllowance() public {
        uint256 allowanceAmount = 1 ether;
        uint256 spendAmount = 2 ether;

        vm.prank(msg.sender);
        ourToken.approve(ALICE, allowanceAmount);

        vm.startPrank(ALICE);
        vm.expectRevert(); // should fail because not enough allowance
        ourToken.transferFrom(msg.sender, BOB, spendAmount);
        vm.stopPrank();
    }

    // ---  Utility Tests ---

    function testBalancesLogged() public {
        console.log("Sender:", msg.sender);
        console.log("Sender balance:", ourToken.balanceOf(msg.sender));
        console.log("Alice balance:", ourToken.balanceOf(ALICE));
        console.log("Bob balance:", ourToken.balanceOf(BOB));
    }

    function testTotalSupplyRemainsConstantAfterTransfers() public {
        vm.prank(msg.sender);
        ourToken.transfer(ALICE, 10 ether);

        vm.prank(msg.sender);
        ourToken.transfer(BOB, 5 ether);

        assertEq(ourToken.totalSupply(), INITIAL_SUPPLY);
    }
}
