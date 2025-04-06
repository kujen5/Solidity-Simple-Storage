// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {console} from "forge-std/Test.sol";

contract SimpleStorage is Ownable {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/
    error SimpleStorage__UserDoesNotExist();

    /*//////////////////////////////////////////////////////////////
                                 TYPES
    //////////////////////////////////////////////////////////////*/

    Person[] listOfPeople; // Array of people of type Person

    /*
    [
    Person { username: "Alice", secretNumber: 42 },
    Person { username: "Bob", secretNumber: 24 }
    ]
    */

    struct Person {
        // New struct for the people data (usernaame, secretNumber)
        string username;
        uint256 secretNumber;
    }
    //mapping()
    /*//////////////////////////////////////////////////////////////
                            STATE VARIABLES
    //////////////////////////////////////////////////////////////*/

    uint256 secretNumber;

    /*//////////////////////////////////////////////////////////////
                                MAPPINGS
    //////////////////////////////////////////////////////////////*/

    mapping(string => uint256) public nameToSecretoNumber;
    mapping(uint256 => string) public secretNumberToNumber;

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/
    event UserAdded(string username, uint256 secretNumber);

    /*//////////////////////////////////////////////////////////////
                               MODIFIERS
    //////////////////////////////////////////////////////////////*/

    //We have none implemented for the moment.

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    constructor() Ownable(msg.sender) {}

    function store(uint256 _secretNumber) public {
        secretNumber = _secretNumber;
    }

    function getSecretNumber() public view returns (uint256) {
        console.log("This is the secret number stored temproarily: ");
        return secretNumber;
    }

    function addPerson(string memory _username, uint256 _secretNumber) public {
        listOfPeople.push(Person(_username, _secretNumber));
        nameToSecretoNumber[_username] = _secretNumber;
        secretNumberToNumber[_secretNumber] = _username;
        console.log("The username: %s and the secret number: %s have been stored.", _username, _secretNumber);
        emit UserAdded(_username, _secretNumber);
    }

    function getCurrentListOfPeople() public view returns (Person[] memory) {
        console.log("This is the list of people in HEX format: ");
        return listOfPeople;
    }

    function getSecretNumberFromPerson(string memory _personName) public view returns (uint256) {
        string memory newPersonName = _personName;
        uint256 secretNumberToDisplay = nameToSecretoNumber[newPersonName];
        return secretNumberToDisplay;
    }

    function getPersonFromSecretNumber(uint256 _secretNumber) public view returns (string memory) {
        uint256 newSecretNumber = _secretNumber;
        string memory personNameToDisplay = secretNumberToNumber[newSecretNumber];
        return personNameToDisplay;
    }
}
