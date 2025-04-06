// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";

contract HelperConfig is Script {
    uint256 public constant LOCAL_ANVIL_CHAIN_ID = 31337;

    function getConfigByChainID() public {}
}
