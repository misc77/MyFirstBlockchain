// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable {
    event AllowanceChanged(address indexed _forWho, address indexed _fromWhom, uint _oldAmount, uint _newAmount);
    
    mapping (address => uint) public allowance;
    
    using SafeMath for uint;
    
    modifier ownerOrAllowed(uint _amount) {
        require ( owner() == msg.sender || allowance[msg.sender] >= _amount, "You are not allowed!");
        _;
    }
    
    function reduceAllowance (address _who, uint _amount) public {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }
    
    function addAllowance(address _who, uint _amount) public onlyOwner  {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }
}