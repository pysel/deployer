// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/Token.sol";

contract TokensDeployer is Script {
    function run() public returns (address, address) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        TestToken token = new TestToken("TestToken", "TT", 1e30);
        TestToken token2 = new TestToken("TestToken2", "TT2", 1e30);
        vm.stopBroadcast();

        return (address(token), address(token2));
    }
}
