// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Authority} from "solmate/auth/Auth.sol";
import "solmate/auth/authorities/RolesAuthority.sol";
import "openzeppelin-contracts/contracts/access/AccessControl.sol";

contract OZAccessControl is AccessControl {
  bytes32 public constant TEST_ROLE = keccak256("TEST_ROLE");

  event Foo();

  constructor(address _owner) {
    _setupRole(DEFAULT_ADMIN_ROLE, _owner);
  }

  function setupRole() public {
    // Should never allow this to be publicly callable in production
    _setupRole(TEST_ROLE, msg.sender);
  }


  function accessControlledMethod() public {
    require(hasRole(TEST_ROLE, msg.sender), "Access denied");
    emit Foo();
  }
}

contract SolmateAccessControl is RolesAuthority {
  uint8 public constant TEST_ROLE = 1;

  event Foo();

  constructor(address _owner) RolesAuthority(_owner, Authority(address(this))) {
    
  }

  function setupRole() public {
    // Should never allow this to be publicly callable in production
    setUserRole(msg.sender, TEST_ROLE, true);
    setRoleCapability(TEST_ROLE, address(this), bytes4(keccak256("accessControlledMethod()")), true);
  }

  function accessControlledMethod() public requiresAuth {
    emit Foo();
  }
}
