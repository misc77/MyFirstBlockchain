pragma solidity ^0.5.17;

contract ManageContractExample {
    address public owner;
    bool    public paused;
    
    constructor() public {
        // called during contract deployment once 
        owner = msg.sender;
    }
    

    function pause() public {
        require(msg.sender == owner, "You are not the owner!");
        paused = true;
    }
    
    function unpause() public {
        require(msg.sender == owner, "You are not the owner!");
        paused = false;
    }
    
    
    function sendMoney() public payable {
        
    }
    
    function withdrawAllMoney(address payable _receiver) public {
        require(msg.sender == owner, "You are not allowed to withdraw the funds!");
        require(!paused, "Contract is paused!");
        _receiver.transfer(address(this).balance);
    }
    
    function getBalance () public view returns (uint){
        return address(this).balance;
    }
    
    function destroyContract(address payable addr) public {
        require(msg.sender == owner, "You are not the owner!");
        selfdestruct(addr);
    }
}