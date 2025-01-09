// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "ens-contracts/ethregistrar/ETHRegistrarController.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";

contract ENSScript is Script, IERC1155Receiver {
    function commit(address ethRegistrar, uint256 start, uint256 end) public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        ETHRegistrarController er = ETHRegistrarController(ethRegistrar);

        vm.startBroadcast(deployerPrivateKey);

        for (uint256 i = start; i < end; i++) {
            bytes32 commitment = er.makeCommitment(
                string(abi.encodePacked("pysel", i)),
                address(this),
                365 days,
                bytes32(0),
                address(0),
                new bytes[](0),
                false,
                0
            );

            er.commit(commitment);
        }

        vm.stopBroadcast();
    }

    function register(address ethRegistrar, uint256 start, uint256 end) public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        ETHRegistrarController er = ETHRegistrarController(ethRegistrar);

        vm.startBroadcast(deployerPrivateKey);

        for (uint256 i = start; i < end; i++) {
            er.register{value: 0.01 ether}(
                string(abi.encodePacked("pysel", i)),
                address(this),
                365 days,
                bytes32(0),
                address(0),
                new bytes[](0),
                false,
                0
            );
        }

        vm.stopBroadcast();
    }

    function supportsInterface(
        bytes4 interfaceId
    ) external view override returns (bool) {}

    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }
}
