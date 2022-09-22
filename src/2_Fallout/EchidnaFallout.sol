pragma solidity ^0.8.10;

import "./Fallout.sol";

//$: ~/echidna-test ./src/2_Fallout/EchidnaFallout.sol --contract EchidnaFallout --config ./src/2_Fallout/echidna_config.yaml
contract EchidnaFallout is Fallout {

  constructor() Fallout() public payable {
    Fal1out();
  }

  function echidna_test_owner() public returns (bool) {
    return msg.sender == owner;
  }
}