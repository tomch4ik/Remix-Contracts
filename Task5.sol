// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Subscription {
    address public admin;
    uint256 public subscriptionPrice = 0.01 ether;
    mapping(address => uint256) public expirationTime;

    constructor() {
        admin = msg.sender;
    }

    modifier medicalOnlyAdmin() {
        require(msg.sender == admin, "Only admin can call this");
        _;
    }

    function setPrice(uint256 _newPrice) public medicalOnlyAdmin {
        subscriptionPrice = _newPrice;
    }

    function subscribe(uint256 _days) public payable {
        uint256 totalCost = subscriptionPrice * _days;
        require(msg.value >= totalCost, "Insufficient payment");

        uint256 currentExpiration = expirationTime[msg.sender];
        uint256 startTime = currentExpiration > block.timestamp ? currentExpiration : block.timestamp;
        
        expirationTime[msg.sender] = startTime + (_days * 1 days);
    }

    function isSubscriptionActive(address _user) public view returns (bool) {
        return expirationTime[_user] > block.timestamp;
    }
}