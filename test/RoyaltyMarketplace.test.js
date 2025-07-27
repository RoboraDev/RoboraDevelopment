const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("RoyaltyMarketplace", function () {
  let marketplace, rbr, owner, designer;

  beforeEach(async function () {
    [owner, designer] = await ethers.getSigners();
    const RBRToken = await ethers.getContractFactory("RBR");
    rbr = await RBR.deploy();
    const RoyaltyMarketplace = await ethers.getContractFactory("RoyaltyMarketplace");
    marketplace = await RoyaltyMarketplace.deploy(await rbr.getAddress());
    await marketplace.grantRole(await marketplace.DESIGNER_ROLE(), designer.address);
  });

  it("Should register and buy a design", async function () {
    await marketplace.connect(designer).registerDesign(1000, 7000);
    await rbr.transfer(owner.address, 1000);
    await rbr.approve(await marketplace.getAddress(), 1000);
    await expect(marketplace.buyDesign(0))
      .to.emit(marketplace, "DesignSold").withArgs(0, owner.address, 1000);
  });
});