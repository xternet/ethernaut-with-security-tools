# Playing Ethernaut manually and with security tools.

## Links:
- [Ethernaut](https://ethernaut.openzeppelin.com/) (The CTF)
- [Foundry](https://github.com/foundry-rs/foundry) (To install for project framework & manual exploits)
- [Slither](https://github.com/crytic/slither) (To install for static analyse/detecting vulnerabilities)
- [Echidna](https://github.com/crytic/echidna) (To install for fuzzing/finding bugs by doing property testing)
- [Manticore](https://github.com/trailofbits/manticore) (To install for symbolically executing contract states and finding sequences of actions leading to exploit)

## Commands:
- <i>(Foundry) </i><b>Run all manual exploits</b>:
```
forge test
```
- <i>(Foundry) </i><b>Run single manual exploit</b>:
```
forge test --match-contract Fallback
```
- <i>(Foundry) </i><b>Run single manual exploit</b>:
```
slither src/1_Fallback/Fallback.sol
```
- <i>(Echidna) </i><b>Find bug </b>(assuming Echidna binaries located at <i>home</i>):
```
~/echidna-test ./src/1_Fallback/EchidnaFallback.sol --config ./src/1_Fallback/echidna_config.yaml
```
- <i>(Manticore) </i><b>Log list of exploit TX series</b> (attacker took ownership and executed withdraw) <b>from pre-computed results</b>:
```
grep withdraw src/1_Fallback/mcore_cli_result/*.tx
```
- <i>(Manticore)</i><b> log details from single exploit TX set</b>:
```
cat src/1_Fallback/mcore_cli_result/user_00000008.tx
```
