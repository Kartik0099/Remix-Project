//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import {AddressType, CodinatesType} from "../AddressBook/addressbook.sol";

enum Gender {
    Male,
    Female,
    Other
}

struct PersonType {
    string name;
    uint8 age;
    uint256 contact_number;
    string countryCode;
    Gender gender;
    bool isVerified;
    AddressType[] homeAddress;
}

contract Person {
    address public authority;

    mapping(address => PersonType) public Persons;
    uint256 public noOfPerson;

    // constructor(address _owner) {
    //     authority = _owner;
    // }

    constructor() {
        authority = msg.sender;
    }

    modifier onlyRights() {
        require(msg.sender == authority, "not authorized");
        _;
    }

    function addPerson(
        string calldata name,
        uint8 age,
        uint256 contact_number,
        string calldata countryCode,
        Gender gender,
        address _personAddress
    ) public onlyRights {
        PersonType storage person = Persons[_personAddress];
        person.name = name;
        person.age = age;
        person.contact_number = contact_number;
        person.gender = gender;
        person.countryCode = countryCode;

        //there soubld be some logic for verify person here
        person.isVerified = true;
        noOfPerson++;

        Persons[_personAddress] = person;
    }

    function editPerson(
        string calldata name,
        uint8 age,
        uint256 contact_number,
        string calldata countryCode,
        Gender gender,
        address _personAddress
    ) public onlyRights {
        PersonType storage person = Persons[_personAddress];
        person.name = name;
        person.age = age;
        person.contact_number = contact_number;
        person.gender = gender;
        person.countryCode = countryCode;
        person.isVerified = true;

        Persons[_personAddress] = person;
    }

    //home address is not visible in remix ide
    function setAddress(
        address _personAddress,
        string calldata strest,
        string calldata city,
        string calldata state,
        string calldata country,
        uint256 zipcode
    ) public onlyRights {
        PersonType storage person = Persons[_personAddress];
        AddressType memory _homeAddress = AddressType(
            strest,
            city,
            state,
            country,
            zipcode
        );
        person.homeAddress.push(_homeAddress);
        Persons[_personAddress] = person;
    }

    function removePerson(address _personAddress) public onlyRights {
        delete Persons[_personAddress];
        noOfPerson--;
    }
}
