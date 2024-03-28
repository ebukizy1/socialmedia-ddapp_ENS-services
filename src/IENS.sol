// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface  IENS {
    
    function registerUser(bytes32 username) external;

    function getUserAddressByUsername(bytes32 username) external view returns(address);

    function getUsernameByAddress(address _addr) external view returns(bytes32);
    
    function fetchAllUsernames() external view returns (bytes32[] memory);

}
