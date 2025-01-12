// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "@decentraland/contracts/marketplace/MarketplaceV2.sol";
import "@decentraland/contracts/managers/RoyaltiesManager.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../src/Token.sol";

contract DecentralandScript is Script {
    function deployMarketplace() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        TestToken token = new TestToken("TestToken", "TT", 1e30);
        token.mint(address(this), 1000);

        IRoyaltiesManager royaltiesManager = new RoyaltiesManager();

        MarketplaceV2 marketplace = new MarketplaceV2(
            address(this),
            address(this),
            address(token),
            royaltiesManager,
            0,
            0
        );

        vm.stopBroadcast();

        console.log("Token:", address(token));
        console.log("Royalties Manager:", address(royaltiesManager));
        console.log("Marketplace:", address(marketplace));
    }

    function createOrder(address marketplace) public {
        MarketplaceV2 marketplaceInstance = MarketplaceV2(marketplace);

        vm.startBroadcast();

        TestNFT nft = new TestNFT("TestNFT", "TNFT");

        nft.mint(msg.sender, 1);
        nft.setApprovalForAll(marketplace, true);

        marketplaceInstance.createOrder(
            address(nft),
            1,
            1,
            block.timestamp + 2 minutes
        );

        vm.stopBroadcast();
    }
}

contract TestNFT is IERC721Verifiable, ERC721 {
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

    function verifyFingerprint(
        uint256,
        bytes memory
    ) external view override returns (bool) {
        return true;
    }

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}
