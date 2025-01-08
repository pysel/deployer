// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/Token.sol";
import "forge-std/console.sol";
import {IUniswapV2Router02 as IUniswapV2Router} from "../lib/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import {UniswapV2AddLiquidity} from "../src/UniswapV2AddLiquidity.sol";

contract V2Swap is Script {
    uint256 liquidityAmount = 1e18;

    function addLiquidityToPair(address token0, address token1, address router,address liquidityAdder) public returns (bool) {
        vm.startBroadcast(msg.sender);
        safeApprove(IERC20(token0), liquidityAdder, 1e20);
        safeApprove(IERC20(token1), liquidityAdder, 1e20);

        UniswapV2AddLiquidity(liquidityAdder).addLiquidity(token0, token1, liquidityAmount, liquidityAmount, router);
        vm.stopBroadcast();
    }

    function run(address token0, address token1, address router) public returns (bool) {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // IUniswapV2Router r = IUniswapV2Router(router);

        // address[] memory path = new address[](2);
        // path[0] = token0;
        // path[1] = token1;


        assert(IERC20(token0).balanceOf(msg.sender) >= liquidityAmount);
        assert(IERC20(token1).balanceOf(msg.sender) >= liquidityAmount);


        vm.startBroadcast(address(this));

        // Swap
        // r.swapExactTokensForTokens(amount, 0, path, address(this), block.timestamp);

        // vm.stopBroadcast();

        return true;
    }

    function safeApprove(IERC20 token, address spender, uint256 amount)
        internal
    {
        (bool success, bytes memory returnData) = address(token).call(
            abi.encodeCall(IERC20.approve, (spender, amount))
        );
        require(
            success
                && (returnData.length == 0 || abi.decode(returnData, (bool))),
            "Approve fail"
        );
    }
}
