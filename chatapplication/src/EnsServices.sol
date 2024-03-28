// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract EnsServices {
    mapping(bytes32 => address) public nameToAddress;
    mapping(address => bytes32) public addressToName;
    bytes32[] public usernameList;


    event registrationSuccessful(address indexed sender,bytes32 username);



    function registerUser(bytes32 username) external {
        require(nameToAddress[username] == address(0), "This name has already been registered");
        require(username != bytes32(0), "Username cannot be empty");

        nameToAddress[username] = msg.sender;
        addressToName[msg.sender] = username;
        usernameList.push(username);
        emit registrationSuccessful(msg.sender, username);

    }

    function getUserAddressByUsername(bytes32 username) external view returns(address) {
        return nameToAddress[username]; 
    }

    function getUsernameByAddress(address _addr) external view returns(bytes32) {
        return addressToName[_addr];
    }

    function fetchAllUsernames() external view returns (bytes32[] memory) {
        return usernameList;
    }
}
