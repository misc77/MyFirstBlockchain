pragma solidity ^0.8.7;

contract MappingsStructExample {
    
    struct Payment {
        uint amount;
        uint timestamp;
    }
    
    struct Balance {
        uint totalBalance;
        uint countPayments;
        mapping (uint => Payment) payments;
    }
    
    mapping ( address => Balance) public balanceReceived;
    
    
    function depositMoney() public payable {
        balanceReceived[msg.sender].totalBalance += msg.value;
        
        Payment memory payment = Payment(msg.value, block.timestamp);
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].countPayments] = payment;
        balanceReceived[msg.sender].countPayments++;
    }
    
    function withdrawMoney(address payable _receiver, uint _amount) public payable{
        require(balanceReceived[msg.sender].totalBalance >= _amount, "Not enough funds!");
        balanceReceived[msg.sender].totalBalance -= _amount;
        Payment memory payment = Payment(_amount, block.timestamp);
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].countPayments] = payment;
        balanceReceived[msg.sender].countPayments++;
        _receiver.transfer(_amount);
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
   
}