import { ethers } from "hardhat";
const helpers = require("@nomicfoundation/hardhat-network-helpers");
const hre = require("hardhat");
const merkle = require("../gen_files/merkleProof.json");
const userDetails = require("../gen_files/claimlist.json")

async function main() {
//  const addr1 = "0xf9056af4cd1211dd9638e9979e99a43de830779e"
//  const addr2 = "0x99cb7f24da7f4bf494bb9740a3ff46d07bee1525"
//  const addr3= "0x9a3a60f5aee7aef1fb0d4da8534452a2e2a89d46"
//  const addr4 = "0xf5ab70ada82e7260a4e09d79b8e09bd2fc08970c"
//  const addr5 = "0xc9cd96ce406eeb5b7ccecf19415eb640953ff6a0"
//  const addr6 = "0xfd5671504514c0214dfb30b1d820d71a891af913"
//  const addr7 = "0x14fab7ffc93cecea209cd310a18eb1a760a904a0"
//  const addr8 = "0xe32971a6c76188ee8eb336e80b97fc079dcedbeb"
//  const addr9 = "0x3281e1230367bcdee7ff37331a1798b9f2af0c53"
//  const addr10 = "0xc8211f26bb21afc25bb784208a63d96deaae55cb"


const claimer =  Object.keys(userDetails)[1]

const amount = userDetails[claimer].amount
const proof = merkle[claimer].proof;
const merkleroot = userDetails["dropDetails"].merkleroot;

//console.log(claimer, amount, proof);


  await hre.network.provider.request({
      method: "hardhat_impersonateAccount",
      params: [claimer]
    });
    const signer = await ethers.getSigner(claimer)
    console.log("signer: ", signer.address)

    await helpers.setBalance(signer.address, 100n ** 18n);

  const TimidanToken = await ethers.getContractFactory("TimidanToken");
  const timidanToken = await TimidanToken.deploy();
  await timidanToken.deployed();
  console.log(`Lock deployed to ${timidanToken.address}`);

  const Airdrop = await ethers.getContractFactory("Airdrop");
  const airdrop = await Airdrop.deploy(timidanToken.address, merkleroot);
  await airdrop.deployed();
  console.log(`Airdrop deployed to ${airdrop.address}`);
  
  const tokenINteract = await ethers.getContractAt("TimidanToken", timidanToken.address);
  const amt = ethers.utils.parseUnits("2000")
  const transferToken = await tokenINteract.transferOut(airdrop.address, amt )
  console.log("result of address",transferToken )


  const airdropINteract = await ethers.getContractAt("Airdrop", airdrop.address);
  const claim = await airdropINteract.connect(signer).Claim(proof, amount);
  const claimTxn = await claim.wait();
  console.log("claimed :", claimTxn);

  const balance =  await tokenINteract.balanceOf(signer.address);
  console.log("balance of signer:", balance );

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
