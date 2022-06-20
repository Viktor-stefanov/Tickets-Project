import { ethers } from "ethers";

async function connectMetamask() {
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  return await provider.send("eth_requestAccounts", []);
}

function hasMetamask() {
  return window.ethereum !== undefined;
}

export { hasMetamask, connectMetamask };
