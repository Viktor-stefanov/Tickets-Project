import { generateEventID } from "./events";
import { ethers } from "ethers";
import contractAddress from "../../artifacts/contracts/EventOrganizer.sol/EventOrganizer.address.json";
import contractData from "../../artifacts/contracts/EventOrganizer.sol/EventOrganizer.json";

let eventOrganizer;
getContract().then((c) => {
  eventOrganizer = c;
});

async function createEvent(event) {
  console.log(await eventOrganizer.eventCount());
  console.log(await generateEventID(event));
  //await eventOrganizer.createEvent();
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

export { createEvent, getContract };
