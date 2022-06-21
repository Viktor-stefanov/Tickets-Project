import { ethers } from "ethers";
import contractAddress from "../../artifacts/contracts/EventOrganizer.sol/EventOrganizer.address.json";
import contractData from "../../artifacts/contracts/EventOrganizer.sol/EventOrganizer.json";

let eventOrganizer;
getContract().then((c) => {
  eventOrganizer = c;
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
    console.log(category);
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
      category.discounts
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

export { publishEvent, addTicketCategory, getContract };
