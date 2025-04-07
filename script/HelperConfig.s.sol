// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";

abstract contract CodeConstants {
    uint256 public constant LOCAL_ANVIL_CHAIN_ID = 31337;
    uint256 public constant ETHEREUM_SEPOLIA_CHAIN_ID = 11155111;
}

contract HelperConfig is Script, CodeConstants {
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        uint256 deployerKey;
        string chainName;
        uint256 chainID;
    }

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getEthSepoliaConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getOrCreateAnvilEthConfig() public view returns (NetworkConfig memory anvilNetworkConfig) {
        if (activeNetworkConfig.chainID == 11155111) {
            return activeNetworkConfig;
        }

        anvilNetworkConfig = NetworkConfig({
            deployerKey: vm.envUint("DEFAULT_ANVIL_PRIVATE_KEY"),
            chainName: "Anvil",
            chainID: LOCAL_ANVIL_CHAIN_ID
        });
    }

    function getEthSepoliaConfig() public view returns (NetworkConfig memory ethSepoliaNetworkConfig) {
        ethSepoliaNetworkConfig = NetworkConfig({
            deployerKey: vm.envUint("ETHEREUM_SEPOLIA_PRIVATE_KEY"),
            chainName: "Ethereum Sepolia",
            chainID: ETHEREUM_SEPOLIA_CHAIN_ID
        });
    }
}
