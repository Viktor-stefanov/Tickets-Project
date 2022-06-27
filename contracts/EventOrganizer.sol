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
        bool selling;
        string name;
        string description;
        uint256 price;
        uint256 maxTicketsPerAccount;
        address[] buyers;
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
        cat.selling = false;
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

    // TODO: test if the tx will go through if mapping is not deleted
    function stopTicketCategory(uint256 eventNum, uint256 categoryNum)
        external
    {
        EventTickets[eventNum].categories[categoryNum].selling = false;
    }

    function sellCategoryTickets(uint256 eventNum, uint256 categoryNum)
        external
    {
        EventTickets[eventNum].categories[categoryNum].selling = true;
    }

    function deleteCategory(uint256 eventNum, uint256 categoryNum) external {
        delete EventTickets[eventNum].categories[categoryNum];
    }

    function refundTicket(address buyer, uint256 price) external {
        (bool success, ) = buyer.call{value: price}("");
        require(success, "alabala");
    }

    function getEvent(uint256 eventNum) external view returns (Event memory) {
        return Events[eventNum];
    }

    function getCategoryName(uint256 eventNum, uint256 categoryNum)
        external
        view
        returns (string memory)
    {
        return EventTickets[eventNum].categories[categoryNum].name;
    }

    function getCategoryCount(uint256 eventNum)
        external
        view
        returns (uint256)
    {
        return EventTickets[eventNum].categoriesCount;
    }

    function getSoldTickets(uint256 eventNumber, uint256 categoryNumber)
        external
        view
        returns (uint256)
    {
        return
            EventTickets[eventNumber].categories[categoryNumber].buyers.length;
    }

    function getCategoryBuyers(uint256 eventNumber, uint256 categoryNumber)
        external
        view
        returns (address[] memory)
    {
        return EventTickets[eventNumber].categories[categoryNumber].buyers;
    }
}
