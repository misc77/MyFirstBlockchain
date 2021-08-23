pragma solidity ^0.5.17;

contract SendMoneyExample {
    
    uint public balanceReceived;
    uint public balanceWithdrawn;
    
    
    function receiveMoney() public payable {
        balanceReceived += msg.value;
    }
    
    function withdrawMoney() public {
        address payable to = msg.sender;
        balanceWithdrawn += this.getBalance();
        to.transfer(this.getBalance());
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function withdrawMoneyTo (address payable _to) public {
         balanceWithdrawn += this.getBalance();
        _to.transfer(this.getBalance());
    }
    
}