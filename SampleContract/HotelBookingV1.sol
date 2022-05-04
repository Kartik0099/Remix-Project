//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "./IHotelBooking.sol";

contract HotelBooking {
    address public owner;

    mapping(uint32 => address) roomUsers;
    uint32 public noOfRoomUsers;

    event checkInOut(
        address _visitor,
        uint32 roomID,
        uint256 checkInOutTime,
        bool ischeckIn
    );

    constructor() {
        owner = msg.sender;
    }

    modifier Rights() {
        require(owner == msg.sender, "you don't have permission");
        _;
    }

    // modifier pay() {
    //     require(msg.value == 1 ether, "you must have to pay 1 ether");
    //     _;
    // }

    function getContactBalance() public Rights returns (uint256) {
        return address(this).balance;
    }

    function getOwnerBalance() public Rights returns (uint256) {
        return owner.balance;
    }

    function isRoomAvailable(uint32 roomId) public returns (bool) {
        if(roomUsers[roomId] == address(0)) return true;
        else return false;
    }

    function makeBooking(uint32 roomId) public payable {
        require(isRoomAvailable(roomId),"Room is booked");
        require(msg.value == 1 ether, "you must have to pay 1 ether");
        roomUsers[roomId] = msg.sender;
        noOfRoomUsers++;
        emit checkInOut(msg.sender, roomId,block.timestamp,true);

    }

    function checkout(uint32 roomId) public {
        require(roomUsers[roomId]== msg.sender || roomUsers[roomId]== owner, "you must have to be a sme room user");
        roomUsers[roomId] = address(0);
        payable(owner).transfer(1 ether);
        noOfRoomUsers--;
        emit checkInOut(msg.sender, roomId, block.timestamp, false);
    }
}
