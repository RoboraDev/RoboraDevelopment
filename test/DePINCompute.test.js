const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DePINCompute", function () {
  let depin, rbr, owner, user;

  beforeEach(async function () {
    [owner, user] = await ethers.getSigners();
    const RBRToken = await ethers.getContractFactory("RBR");
    rbr = await RBRToken.deploy();
    const DePINCompute = await ethers.getContractFactory("DePINCompute");
    depin = await DePINCompute.deploy(await rbr.getAddress());
  });

  it("Should submit and complete a job", async function () {
    await rbr.transfer(user.address, 1000);
    await rbr.connect(user).approve(await depin.getAddress(), 1000);
    const jobId = await depin.connect(user).submitJob(1000);
    await expect(depin.completeJob(jobId, owner.address))
      .to.emit(depin, "JobCompleted").withArgs(jobId, owner.address, 950);
  });
});