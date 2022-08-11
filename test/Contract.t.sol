// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";
import "forge-std/Test.sol";

import {OZAccessControl, SolmateAccessControl} from "../src/Contract.sol";

contract ContractTest is Test {
    function setUp() public {}

    function testOz() public {
        OZAccessControl ozAccessControl = new OZAccessControl(address(this));
        ozAccessControl.setupRole();
        ozAccessControl.accessControlledMethod();
    }

    function testSolmate() public {
        SolmateAccessControl solmateAccessControl = new SolmateAccessControl(address(this));
        solmateAccessControl.setupRole();
        solmateAccessControl.accessControlledMethod();
    }
}
