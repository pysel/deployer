// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "@0xPolygonHermez/contracts/PolygonZkEVMBridge.sol";

contract BridgeScript is Script {
    function bridge(address zkEvmBridge) public {
        PolygonZkEVMBridge bridge = PolygonZkEVMBridge(zkEvmBridge);

        vm.startBroadcast();

        bridge.bridgeAsset{value: 1 ether}(
            1337,
            msg.sender,
            1e18,
            address(0),
            true,
            ""
        );

        vm.stopBroadcast();
    }
}
