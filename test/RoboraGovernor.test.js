const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("RoboraGovernor", function () {
  let governor, rbr;

  beforeEach(async function () {
    const RBR = await ethers.getContractFactory("RBR");
    rbr = await RBR.deploy();
    const RoboraGovernor = await ethers.getContractFactory("RoboraGovernor");
    governor = await RoboraGovernor.deploy(rbr);
  });

  it("Should initialize correctly", async function () {
    expect(await governor.name()).to.equal("RoboraGovernor");
  });
});