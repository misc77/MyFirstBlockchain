// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./Allowance.sol";

contract SimpleWallet is Allowance {
    
    event MoneyWithdrawn(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _sender, uint _amount);
    
    function withdrawMoney (address payable _to, uint _amount) public payable ownerOrAllowed (_amount) {
        require(_amount <= address(this).balance, "Withdrawal not possible due to insufficient funds!");
        if (owner() != msg.sender) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneyWithdrawn(_to, _amount);
        _to.transfer(_amount);
    }
    
    function getBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }
    
    
    function renounceOwnership() public {
        revert("Can't renounce ownership");
    }
        
    //fallback function
    fallback() external payable {

    }
    
    receive() external payable{
        emit MoneyReceived(msg.sender, msg.value);
    }
}