// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import {IENS} from "./IENS.sol";

contract ChatApplication {

    address ensAddr;
    mapping(bytes32 => string)  userUrls; // Mapping to store URLs by 
    mapping(bytes32 => Chat[]) chats;
    mapping(bytes32 => mapping(bytes32 => Chat[])) userChat;

uint256 lastChatId;
    
// 0x6562756b697a7931000000000000000000000000000000000000000000000000
// 0x6562756b697a7931320000000000000000000000000000000000000000000000
    struct Chat{
        uint id;
        string message;
    
    }

    constructor (address _ensAddr) {
        ensAddr = _ensAddr;
    }

    event registrationSuccessful(address indexed sender,bytes32 indexed username,string imageUrl);
    event MessageSuccessFul(bytes32 indexed senderUsername,bytes32 indexed _receiverUsername, string _message);



    function userRegistration(bytes32 username, string memory imageUrl) external {
        IENS(ensAddr).registerUser(username);
        userUrls[username] = imageUrl; // Store URL associated with the username
        emit registrationSuccessful(msg.sender, username, imageUrl);
    }


    function getUserUrl(bytes32 username) external view returns (string memory) {
        return userUrls[username]; // Retrieve URL associated with the username
    }
    // Function to send a message to a specific receiver


function sendMessage(bytes32 _receiverUsername, string memory _message) external {
    require(bytes(_message).length > 0, "Message cannot be empty");
    bytes32 senderUsername = getUsernameByAdd(msg.sender); // Assuming getUsernameByAddress is a separate function

    // Increment the lastChatId and use it as the ID for the new message
    lastChatId++;

    // Add the message to sender's chat history with the receiver
    userChat[senderUsername][_receiverUsername].push(Chat(lastChatId, _message));

    // Emit event for successful message sending
    emit MessageSuccessFul(senderUsername, _receiverUsername, _message);
}


// Function to get chat history between two users
function getChatHistory(bytes32 _senderUsername, bytes32 _receiverUsername) external view returns (Chat[] memory) {
    return userChat[_senderUsername][_receiverUsername];
}


    function getUsernameByAdd(address _addr) private  view returns(bytes32){
        return  IENS(ensAddr).getUsernameByAddress(_addr);
    }

    


    function getChatHistory(bytes32 username) external view returns (Chat[] memory) {
        return chats[username];
    }

    function fetchAllUserNames() external view returns (bytes32 [] memory){
        bytes32 [] memory usernameList = IENS(ensAddr).fetchAllUsernames();
        return usernameList;
    }  

    function getUsernameByAddress(address _addr) external view returns(bytes32 ){
        return IENS(ensAddr).getUsernameByAddress(_addr);
    }

      function getUserAddressByUsername(bytes32 _username) external view returns(address){
        return IENS(ensAddr).getUserAddressByUsername(_username);
    }



    
}
