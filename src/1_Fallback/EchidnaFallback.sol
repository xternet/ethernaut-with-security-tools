pragma solidity ^0.8.10;

import "./Fallback.sol";

//$: ~/echidna-test ./src/1_Fallback/EchidnaFallback.sol --contract EchidnaFallback --config ./src/1_Fallback/echidna_config.yaml
contract EchidnaFallback is Fallback {
  constructor() Fallback() public payable {}

  function echidna_test_owner() public returns (bool) {
    return msg.sender==owner;
  }

  function echidna_test_balance() public returns (bool) {
    return address(this).balance >= 1000;
  }
}