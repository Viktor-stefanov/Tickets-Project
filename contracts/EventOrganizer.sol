// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/interfaces/IERC1155.sol";

contract EventOrganizer {
    uint256 public eventCount;
    mapping(uint256 => Event) public Events;

    struct Event {
        string ID;
        string name;
        string websiteUrl;
        string posterUrl;
        string location;
        uint256 startDate;
        uint256 endDate;
    }

    function createEvent(
        string memory _ID,
        string memory _name,
        string memory _websiteUrl,
        string memory _posterUrl,
        string memory _location,
        uint256 _startDate,
        uint256 _endDate
    ) external {
        require(
            _endDate > _startDate,
            "End date cannot be earlier than start date."
        );
        eventCount++;
        Events[eventCount] = Event(
            _ID,
            _name,
            _websiteUrl,
            _posterUrl,
            _location,
            _startDate,
            _endDate
        );
    }
}
