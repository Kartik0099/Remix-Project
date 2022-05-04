//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;


struct AddressType{
    string street;
    string admitistative_level1;  // city
    string admitistative_level2;  // state
    string admitistative_level3;  // country
    uint zipcode;
    // CodinatesType codinate;
}

struct CodinatesType{
    uint latitude; // first two always real number after floating points so by length you need to calculate
    uint longitude;
}



