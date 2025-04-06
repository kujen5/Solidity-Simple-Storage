// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeploySimpleStorage} from "../script/DeploySimpleStorage.s.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";

contract SimpleStorageTest is Test {
    SimpleStorage public simpleStorage;

    function setUp() external {
        //Here, we have to deploy and instance of our contract

        DeploySimpleStorage deployer = new DeploySimpleStorage();
        simpleStorage = deployer.run();
    }

    function testStore() public {
        //Arrange
        uint256 expectedSecretNumber = 1337;
        //Act
        simpleStorage.store(expectedSecretNumber);
        //Assert
        assertEq(expectedSecretNumber, simpleStorage.getSecretNumber());
    }

    function testAddPerson() public {
        //Arrange
        string memory username = "0xkujen";
        uint256 secretNumber = 1337;
        //Act
        simpleStorage.addPerson(username, secretNumber);
        //Assert
        uint256 retrieveSecretNumber = simpleStorage.getSecretNumberFromPerson(
            username
        );
        assertEq(retrieveSecretNumber, secretNumber);
        string memory retrievedUsername = simpleStorage
            .getPersonFromSecretNumber(secretNumber);
        assertEq(retrievedUsername, username);
    }

    function testGetCurrentListOfPeople() public {
        //Arrange

        string memory username = "0xkujen";
        uint256 secretNumber = 1337;
        //Act
        simpleStorage.addPerson(username, secretNumber);

        //Assert
        SimpleStorage.Person[] memory listOfPeople = simpleStorage
            .getCurrentListOfPeople();
        SimpleStorage.Person memory firstPerson = listOfPeople[0];
        assertEq(
            keccak256(abi.encodePacked(firstPerson.username)),
            keccak256(abi.encodePacked(username))
        );
        assertEq(
            keccak256(abi.encodePacked(firstPerson.secretNumber)),
            keccak256(abi.encodePacked(secretNumber))
        );
    }
}
