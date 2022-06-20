const fs = require("fs");

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const contract = await deploy("EventOrganizer", {
    from: deployer,
    log: true,
  });
  fs.writeFileSync(
    "./artifacts/contracts/EventOrganizer.sol/EventOrganizer.address.json",
    JSON.stringify(contract.address)
  );
};

module.exports.tags = ["EventOrganizer"];
