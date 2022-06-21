// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/interfaces/IERC1155.sol";

contract EventOrganizer {
    uint256 public eventCount;
    mapping(uint256 => Event) internal Events;
    mapping(uint256 => Ticket) internal EventTickets;

    struct Event {
        string ID;
        string name;
        string websiteUrl;
        string posterUrl;
        string location;
        uint256 startDate;
        uint256 endDate;
    }

    struct Ticket {
        uint256 categoriesCount;
        mapping(uint256 => TicketCategory) categories;
        uint256 maxTicketsPerAccount;
    }

    struct TicketCategory {
        string name;
        string description;
        uint256 price;
        uint256 maxTicketsPerAccount;
        uint256 ticketType;
        uint256 startDate;
        uint256 endDate;
        bool[] discounts; // [2-1, 3-2, 4-3] => [true, false, false]
        mapping(string => uint256) ticketConfig;
    }

    function createEvent(
        string memory _ID,
        string memory _name,
        string memory _websiteUrl,
        string memory _posterUrl,
        string memory _location,
        uint256 _startDate,
        uint256 _endDate
    ) public {
        require(
            _endDate > _startDate,
            "End date cannot be earlier than start date."
        );

        eventCount++;
        Event storage newEvent = Events[eventCount];
        newEvent.ID = _ID;
        newEvent.name = _name;
        newEvent.websiteUrl = _websiteUrl;
        newEvent.posterUrl = _posterUrl;
        newEvent.location = _location;
        newEvent.startDate = _startDate;
        newEvent.endDate = _endDate;
    }

    function addTicketCategory(
        uint256 _eventNumber,
        string memory _name,
        string memory _description,
        uint256 _price,
        uint256 _maxTicketsPerAccount,
        uint256 _startDate,
        uint256 _endDate,
        uint256 _ticketType,
        uint256[] memory config,
        bool[] memory _discounts
    ) public {
        Ticket storage t = EventTickets[_eventNumber];
        TicketCategory storage cat = t.categories[++t.categoriesCount];
        cat.name = _name;
        cat.description = _description;
        cat.price = _price;
        cat.maxTicketsPerAccount = _maxTicketsPerAccount;
        cat.ticketType = _ticketType;
        cat.startDate = _startDate;
        cat.endDate = _endDate;
        cat.discounts = _discounts;
        if (_ticketType == 0) {
            // fungible ticket type
            cat.ticketConfig["maxTickets"] = config[0];
        } else {
            // non fungible ticket type
            cat.ticketConfig["startNumber"] = config[0];
            cat.ticketConfig["endNumber"] = config[1];
        }
    }
}
