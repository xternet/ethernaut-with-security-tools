pragma solidity ^0.8.10;

//$: ~/echidna-test ./src/3_CoinFlip/EchidnaCoinFlip.sol --contract EchidnaCoinFlip
import "./CoinFlip.sol";

contract EchidnaCoinFlip is CoinFlip {
  function echidna_test_flip() public returns (bool) {
    return consecutiveWins < 10;
  }
}