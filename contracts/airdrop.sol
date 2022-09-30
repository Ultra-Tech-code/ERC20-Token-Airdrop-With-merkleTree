// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
//import "gen_files/merkleProof.json";

contract Airdrop {
    bytes32 public merkleRoot = 0x953ccfc66eded938902be7f24ea1485af6541b376648c7794fc2c1a0268b1dd4;
    address public contractADDr;
    constructor (address addr){
        contractADDr = addr;
    }
  
    mapping(address => bool) public whitelistClaimed;


    function Claim(bytes32[] calldata _merkleProof, uint256 _amount) external returns(bool) {
        require(!whitelistClaimed[msg.sender], "Address already claimed");

        // bytes32 leaf = msg.sender.leaf;

        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, _amount));
        if(!MerkleProof.verify(_merkleProof, merkleRoot, leaf)) {
            return false;
        }

        whitelistClaimed[msg.sender] = true;
    
        IERC20(contractADDr).transfer(msg.sender, _amount);
        return true;
    }

}