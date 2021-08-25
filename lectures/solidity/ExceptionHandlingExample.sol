// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;


contract ExceptionHandlingExample {
    
    mapping(address => uint64) public balanceReceived;
    
    address payable owner;
    
    constructor() {
        owner = payable(msg.sender);
    }
    
    function getOwner() public view returns (address) {
        return owner;
    }
    
    function convertWeiToEther( uint _amount) public pure returns (uint) {
        return _amount / 1 ether;
    }
    
    function destroyContract() public {
        require(msg.sender == owner, "You are not the owner!");
        selfdestruct(owner);
    }
    
    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += uint64(msg.value);
    }
    
    function withdrawMoney( address payable _to, uint64 _amount) public {
        require (_amount <= balanceReceived[msg.sender], "You don't have enough funds!"); 
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    
    }
    
    //fallback function
    fallback() external payable {
        receiveMoney();
    }
    
    receive() external payable {
        receiveMoney();
    }
}
