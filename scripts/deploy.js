const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying from:", deployer.address);

  const RBRToken = await ethers.getContractFactory("RBR");
  const rbr = await RBRToken.deploy();
  await rbr.waitForDeployment();
  console.log("RBR:", await rbr.getAddress());

  const RoyaltyMarketplace = await ethers.getContractFactory("RoyaltyMarketplace");
  const marketplace = await RoyaltyMarketplace.deploy(await rbr.getAddress());
  await marketplace.waitForDeployment();
  console.log("RoyaltyMarketplace:", await marketplace.getAddress());

  const DePINCompute = await ethers.getContractFactory("DePINCompute");
  const depin = await DePINCompute.deploy(await rbr.getAddress());
  await depin.waitForDeployment();
  console.log("DePINCompute:", await depin.getAddress());

  const RoboraGovernor = await ethers.getContractFactory("RoboraGovernor");
  const governor = await RoboraGovernor.deploy(rbr);
  await governor.waitForDeployment();
  console.log("RoboraGovernor:", await governor.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});