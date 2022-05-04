//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

interface IHostelBooking {
    // function getContactBalance() external returns(uint);

    // function getOwnerBalance() external returns(uint);

    function isRoomAvailable(uint32 roomId) external returns (bool);

    function checkout(uint32 roomID) external;

    function makeBooking(uint32 roomID) external payable;
}
