import { ethers } from "ethers";
import contractAddress from "../../artifacts/contracts/EventOrganizer.sol/EventOrganizer.address.json";
import contractData from "../../artifacts/contracts/EventOrganizer.sol/EventOrganizer.json";

let eventOrganizer;
getContract().then((c) => {
  eventOrganizer = c;
  test();
});

async function publishEvent(event) {
  const eventCount = await eventOrganizer.eventCount();
  const eventID = eventCount.add(1).toString() + event.name;
  const location = [event.country, event.city, event.address].join(" ");
  try {
    await eventOrganizer.createEvent(
      eventID,
      event.name,
      event.websiteUrl,
      event.posterUrl,
      location,
      event.startDate,
      event.endDate
    );
    return true;
  } catch (err) {
    console.log("Error on publishing event:", err);
  }
}

async function addTicketCategory(category, eventNum) {
  try {
    await eventOrganizer.addTicketCategory(
      eventNum,
      category.name,
      category.description,
      category.price,
      category.maxTickets,
      category.startDate,
      category.endDate,
      category.ticketType,
      category.ticketConfig,
      category.ticketDiscounts
    );
    return true;
  } catch (err) {
    console.log("Error on adding a ticket category:", err);
  }
}

async function getContract() {
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
  const contract = new ethers.Contract(
    contractAddress,
    contractData.abi,
    signer
  );
  return contract;
}

async function getCategories(eventNumber) {
  let categories = [];
  const categoryCount = await eventOrganizer.getCategoryCount(eventNumber);
  for (let i = 1; i < categoryCount.add(1); i++) {
    const categoryName = await eventOrganizer.getCategoryName(eventNumber, i);

    categories.push({ name: categoryName, id: i });
  }

  return categories;
}

async function stopCategory(eventNumber, categoryID) {
  try {
    //console.log(await eventOrganizer.getCategoryName(eventNumber, categoryID));
    await eventOrganizer.stopTicketCategory(eventNumber, categoryID);
  } catch (err) {
    console.log("Error on stopping ticket category:", err);
  }
}

async function stopTickets(eventNumber) {
  try {
    const categoryCount = await eventOrganizer.getCategoryCount();
    for (let i = 1; i < categoryCount.add(1); i++) {
      await eventOrganizer.stopTicketCategory(eventNumber, i);
    }
  } catch (err) {
    console.log("Error on stoping all tickets:", err);
  }
}

async function sellCategoryTickets(eventNumber, categoryNumber) {
  await eventOrganizer.sellCategoryTickets(eventNumber, categoryNumber);
}

async function sellTickets(eventNum) {
  const categoryCount = await eventOrganizer.getCategoryCount(eventNum);
  for (let categoryNum = 1; categoryNum < categoryCount.add(1); categoryNum++) {
    await eventOrganizer.sellCategoryTickets(eventNum, categoryNum);
  }
}

async function getCategorySoldTickets(eventNumber, categoryNumber) {
  return await eventOrganizer.getSoldTickets(eventNumber, categoryNumber);
}

async function deleteTickets(eventNumber, categoryNumber) {
  const soldTickets = getCategorySoldTickets(eventNumber, categoryNumber);
  if (soldTickets === 0) {
    await eventOrganizer.deleteCategory(eventNumber, categoryNumber);
  } else {
    const buyers = await eventOrganizer.getTicketBuyers(
      eventNumber,
      categoryNumber
    );
    for (let buyer of buyers) {
      await eventOrganizer.refundTicket(buyer);
    }
    await eventOrganizer.deleteCategory(eventNumber, categoryNumber);
  }
}

async function getEvents(upcomingEvents, passedEvents) {
  let events = [];
  const eventCount = await eventOrganizer.eventCount();
  for (let i = 1; i < eventCount.add(1); i++) {
    let event = { ...(await eventOrganizer.getEvent(i)) };
    if (upcomingEvents && event.startDate > new Date().getTime())
      events.push(event);
    if (passedEvents && event.startDate <= new Date().getTime())
      events.push(event);
  }

  return events;
}

async function test() {
  // console.log(await eventOrganizer.getTicket(1));
}

export {
  publishEvent,
  addTicketCategory,
  getCategories,
  stopCategory,
  getContract,
  stopTickets,
  sellCategoryTickets,
  sellTickets,
  getCategorySoldTickets,
  deleteTickets,
  getEvents,
};
