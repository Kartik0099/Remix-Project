//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

contract HotelBooking {
    bool[5][5] booked;
    address owner;
    address[] visitors;

    event checkInOut(
        address _visitor,
        uint8 roomID,
        uint256 checkInOutTime,
        bool ischeckIn
    );

    constructor() {
        owner = msg.sender;
    }

    modifier Rights() {
        require(owner == msg.sender, "Owner can only check");
        _;
    }

    modifier MaxRooms(uint8 roomId) {
        require(roomId <= 25, "Room ID less than 25");
        _;
    }

    modifier Pay() {
        require(msg.value == 1 ether, "you can only pay 1 ether");
        _;
    }

    function getContactBalance() public Rights returns (uint256) {
        return address(this).balance;
    }

    function getOwnerBalance() public Rights returns (uint256) {
        return owner.balance;
    }

    function getRoomRowCol(uint8 roomId)
        internal
        returns (uint8 row, uint8 col)
    {
        row = (roomId / 10) -1;
        col = (roomId % 10) -1;
    }

    function isRoomAvailable(uint8 roomId)
        public
        MaxRooms(roomId)
        returns (bool)
    {
        (uint8 row, uint8 col) = getRoomRowCol(roomId);
        if (booked[row][col] == false) return true;
        else return false;
    }

    function makeBooking(uint8 roomID) public payable Pay {
        if (isRoomAvailable(roomID)) {
            address _visitor = msg.sender;
            visitors.push(_visitor);
            (uint8 row, uint8 col) = getRoomRowCol(roomID);
            booked[row][col] = true;
            emit checkInOut(_visitor, roomID, block.timestamp, true);
        } else {
            revert("Room is not available");
        }
    }

    function checkout(uint8 roomID) public {
        (uint8 row, uint8 col) = getRoomRowCol(roomID);
        booked[row][col] = false;
        uint256 len = visitors.length - 1;
        address _visitor = msg.sender;
        for (uint8 i = 0; i <= len; ++i) {
            if (visitors[i] == _visitor) {
                if (1 < i && i < len) {
                    visitors[i] = visitors[len];
                    visitors.pop();
                }
                break;
            }
        }
        payable(owner).transfer(1 ether);

        emit checkInOut(_visitor, roomID, block.timestamp, false);
    }
}
