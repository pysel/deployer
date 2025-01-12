// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "@decentraland/contracts/marketplace/MarketplaceV2.sol";
import "@decentraland/contracts/managers/RoyaltiesManager.sol";
import "../src/Token.sol";

contract DecentralandScript is Script {
    address public i_token;
    address public i_royaltiesManager;
    address public i_marketplace;

    function deployMarketplace() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        TestToken token = new TestToken("TestToken", "TT", 1e30);

        IRoyaltiesManager royaltiesManager = new RoyaltiesManager();

        MarketplaceV2 marketplace = new MarketplaceV2(
            address(this),
            address(this),
            address(token),
            royaltiesManager,
            0,
            0
        );

        i_token = address(token);
        i_royaltiesManager = address(royaltiesManager);
        i_marketplace = address(marketplace);

        vm.stopBroadcast();

        console.log("Token:", i_token);
        console.log("Royalties Manager:", i_royaltiesManager);
        console.log("Marketplace:", i_marketplace);
    }
}
