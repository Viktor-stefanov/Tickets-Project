import { ethers } from "ethers";
import { getContract } from "./contracts";

async function generateEventID(event) {
  const eventOrganizer = await getContract();
  console.log(eventOrganizer);
  const eventNumber = await eventOrganizer.eventCount();
  console.log(typeof eventNumber);
  return eventNumber + event.name;
}

export { generateEventID };
