// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Owned {
    address owner;
    
    constructor() {
        owner = msg.sender;
    }
    
     modifier onlyOwner() {
        require (msg.sender == owner, "You are not the owner!");
        _;   // Content before "_;" is copied to referencing function
    }
    
}