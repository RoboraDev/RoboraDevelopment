const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("RBR", function () {
  it("Should mint initial supply to owner", async function () {
    const RBRToken = await ethers.getContractFactory("RBR");
    const rbr = await RBR.deploy();
    const owner = await ethers.provider.getSigner(0);
    expect(await rbr.balanceOf(owner.address)).to.equal(100000000n * 10n**18n);
  });
});