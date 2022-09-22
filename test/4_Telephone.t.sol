pragma solidity ^0.8.10;

import {TelephoneFactory} from "../src/config/factories/4_TelephoneFactory.sol";
import {Telephone} from "../src/4_Telephone/Telephone.sol";
import {Ethernaut} from "../src/config/Ethernaut.sol";
import {Hack} from "../src/Hack.sol";
import "forge-std/Test.sol";

contract TelephoneTest is Test {
    Ethernaut ethernaut;
    Telephone ethernautTelephone;
    TelephoneFactory telephoneFactory;

    address levelAddress;

    function setUp() public {
        ethernaut = new Ethernaut();

        telephoneFactory = new TelephoneFactory();
        ethernaut.registerLevel(telephoneFactory);

        levelAddress = ethernaut.createLevelInstance(telephoneFactory);
        ethernautTelephone = Telephone(payable(levelAddress));
    }

    function testExploit() public {
        /** EXPLOIT END **/

        Hack hack = new Hack();
        hack.telephone(levelAddress); //call changeOwner() directly from contract

        /** EXPLOIT END **/
        validation();
    }

    function validation() internal {
        assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}