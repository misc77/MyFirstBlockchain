pragma solidity ^0.8.7;

contract SimpleMappingExample {

    mapping ( uint => bool ) public myMapping;   // comparable to Arrays uint = indextype and bool = value
    
    mapping (address => bool) public addrMapping; 
    
    
    function setAdressToTrue() public {
        addrMapping[msg.sender] = true;
    }
    
    function setValue(uint _index) public {
        myMapping[_index] = true;
    }
}
