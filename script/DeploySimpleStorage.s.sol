// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract DeploySimpleStorage is Script {
    function run() external returns (SimpleStorage) {
        vm.startBroadcast(); // Creates a Transaction that can be signed and sent on chain => Deploy a contract inside of the script
        SimpleStorage simpleStorage = new SimpleStorage(); // Create the instance of SimpleStorage contract that will be deployed on chain
        vm.stopBroadcast();
        return simpleStorage;
    }
}
