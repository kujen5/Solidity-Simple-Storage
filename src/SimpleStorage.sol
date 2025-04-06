// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleStorage is Ownable {
    constructor() Ownable(msg.sender) {}

    uint256 secretNumber;
    struct Person {
        // New struct for the people data (usernaame, secretNumber)
        string username;
        uint256 secretNumber;
    }
    //mapping()
    Person[] listOfPeople; // Array of people of type Person

    /*
    [
    Person { username: "Alice", secretNumber: 42 },
    Person { username: "Bob", secretNumber: 24 }
    ]
    */
    mapping(string => uint256) public nameToSecretoNumber;
    mapping(uint256 => string) public secretNumberToNumber;

    function store(uint256 _secretNumber) public {
        secretNumber = _secretNumber;
    }

    function addPerson(string memory _username, uint256 _secretNumber) public {
        listOfPeople.push(Person(_username, _secretNumber));
        nameToSecretoNumber[_username] = _secretNumber;
        secretNumberToNumber[_secretNumber] = _username;
    }

    function getSecretNumber() public view returns (uint256) {
        return secretNumber;
    }

    function getCurrentListOfPeople() public view returns (Person[] memory) {
        return listOfPeople;
    }

    function getSecretNumberFromPerson(
        string memory _personName
    ) public view returns (uint256) {
        string memory newPersonName = _personName;
        uint256 secretNumberToDisplay = nameToSecretoNumber[newPersonName];
        return secretNumberToDisplay;
    }

    function getPersonFromSecretNumber(
        uint256 _secretNumber
    ) public view returns (string memory) {
        uint256 newSecretNumber = _secretNumber;
        string memory personNameToDisplay = secretNumberToNumber[
            newSecretNumber
        ];
        return personNameToDisplay;
    }
}
