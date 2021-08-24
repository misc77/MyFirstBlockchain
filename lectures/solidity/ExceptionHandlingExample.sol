pragma solidity ^0.5.13

contract ExceptionHandlingExample {

    mapping(address => uint64) public balanceReceived; // max Ethereum value = 18 ether. Rollback to 0 when exceeding 18 either.

    function receive() public payable {
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += uint64(msg.value);
    }

    function withdraw( address payable _to, uint64 _amount) public {
        require (_amount <= balanceReceived[msg.sender], "You don't have enough funds!");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}
