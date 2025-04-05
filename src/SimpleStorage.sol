// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleStorage is Ownable {
    constructor() Ownable(msg.sender) {}

    struct Person {
        uint256 secretNumber;
        string username;
    }

    function store() public {}

    function retrieve() public {}

    function addPerson() public {}
}
