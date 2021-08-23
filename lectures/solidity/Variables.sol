pragma solidity ^0.5.13;

contract WorkingWithVariables {
    uint256 public myUint;
    bool public myBool;
    uint8 public myUint8;
    address public localAdress;
    string public myString ='Hello World!';
    
    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }
    
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
    
    function incrUint() public {
        myUint8++;
    }
    
    function decrUint() public {
        myUint8--;
    }

    function setAddress(address _address) public {
        localAdress = _address;
    }

    function getBalance() public view returns (uint){
        return localAdress.balance;
    }

    function setString(string memory _string) public {
        myString = _string;
    }

}
