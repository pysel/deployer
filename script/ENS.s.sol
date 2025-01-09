// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "ens-contracts/ethregistrar/ETHRegistrarController.sol";

contract ENSScript is Script {
    function run(address ethRegistrar) public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        ETHRegistrarController er = ETHRegistrarController(ethRegistrar);

        vm.startBroadcast(deployerPrivateKey);
        

        vm.stopBroadcast();
    }
}
