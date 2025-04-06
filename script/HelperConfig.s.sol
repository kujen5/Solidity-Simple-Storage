// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";

abstract contract CodeConstants {
    uint256 public constant LOCAL_ANVIL_CHAIN_ID = 31337;
    uint256 public constant ETHEREUM_SEPOLIA_CHAIN_ID = 11155111;
    uint256 public constant DEFAULT_ANVIL_PRIVATE_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
}

contract HelperConfig is Script, CodeConstants {
    NetworkConfig public activeNetworkConfig;
    struct NetworkConfig {
        uint256 deployerKey;
        string chainName;
        uint256 chainID;
    }

    constructor() {
        if (block.chainid == 31337) {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getOrCreateAnvilEthConfig()
        public
        pure
        returns (NetworkConfig memory anvilNetworkConfig)
    {
        //First, we shoukd check to see if we already have an active network config. But for now since we only have anvil we won't implement it
        //To-Do in the future
        /*
        if (activeNetworkConfig.differentConfig != address(0)) {
            return activeNetworkConfig;
        }
        */

        anvilNetworkConfig = NetworkConfig({
            deployerKey: DEFAULT_ANVIL_PRIVATE_KEY,
            chainName: "Anvil",
            chainID: 31337
        });
    }
}
