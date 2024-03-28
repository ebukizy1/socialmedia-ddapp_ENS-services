// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
// import {Counter} from "../src/Counter.sol";
import "../src/ChatApplication.sol";
import "../src/IENS.sol";
import "../src/EnsServices.sol";

contract ChatAppilcationTest is Test {
    ChatApplication chatApp;
    // IENS iEns;
    bytes32 ebukizy1 = 0x6562756b697a7931000000000000000000000000000000000000000000000000;
    EnsServices ensServices;

        address A = address(0xa);
        address B = address(0xb);
        address C = address(0xc);


    function setUp() public {
        ensServices = new EnsServices();
       chatApp = new ChatApplication(address(ensServices));
         A = mkaddr("user1 a");
        B = mkaddr("user2 b");
    }


    function testEnsServices() public {
        switchSigner(A);
        ensServices.registerUser(ebukizy1);
    address _userAddr =  ensServices.getUserAddressByUsername(ebukizy1);
    assertEq(_userAddr, A);
    
    }

    function testENSGetUsernameByAddress() public {
        switchSigner(A);
        ensServices.registerUser(ebukizy1);
        bytes32  _userAddr =  ensServices.getUsernameByAddress(A);
    assertEq(_userAddr, ebukizy1);
    
    }

    function testRevertDuplicateUsername() public{
        switchSigner(A);
        ensServices.registerUser(ebukizy1);

        
        ensServices.registerUser(ebukizy1);


    }




    function test_userRegistration() public {
        switchSigner(A);
                // ensServices.registerUser(ebukizy1);


        chatApp.userRegistration(ebukizy1, "image___url");
        bytes32 registerName = chatApp.getUsernameByAddress(address(A));
        assertEq(registerName, ebukizy1);
    }


    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }

    function switchSigner(address _newSigner) public {
        address foundrySigner = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;
        if (msg.sender == foundrySigner) {
            vm.startPrank(_newSigner);
        } else {
            vm.stopPrank();
            vm.startPrank(_newSigner);
        }
    }

 
}
