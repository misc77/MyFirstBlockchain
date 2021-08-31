// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import "./Owned.sol";

contract MyWallet is Owned{
    
    using SafeMath for uint;
    
    struct Account {
        uint totalBalance;
        mapping(address => uint) allowance;
    }
    
    mapping (address => Account) public accounts;
    
    constructor() {
        accounts[msg.sender].totalBalance = 1 ether;
    }
    
    function getBalance() public view onlyOwner returns (uint){
        return accounts[msg.sender].totalBalance;
    }
    
    function depositFunds(uint _amount) public payable onlyOwner returns (bool){
        accounts[msg.sender].totalBalance += _amount;
        return true;
    }
    
    function withdrawFunds(address _from, address payable _to, uint _amount) public returns (bool) {
        require ((_from != msg.sender) && (accounts[_from].allowance[msg.sender] >= _amount), "Amount exceeds allowance!");
        require (accounts[_from].totalBalance >= _amount, "Withdrawal aborted, insufficient Funds!");
        accounts[_from].totalBalance -= _amount;
        accounts[_to].totalBalance += _amount;
        
        return true;
    }
    
    function setAllowance(address grantee, uint _amount) public onlyOwner returns(bool) {
        accounts[msg.sender].allowance[grantee] = _amount;
        return true;
    }
    
    function removeAllowance(address grantee) public onlyOwner returns (bool) {
        accounts[msg.sender].allowance[grantee] = 0;
        return true;
    }
    
    function getAllowance(address grantee) public view onlyOwner returns (uint) {
        return accounts[msg.sender].allowance[grantee];
    }
    
}