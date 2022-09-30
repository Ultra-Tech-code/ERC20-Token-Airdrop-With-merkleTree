// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TimidanToken is ERC20("TimidanToken", "TKN"){
    address public owner;
    uint8 public  _decimals;
    uint256 public  _totalSupply;
    constructor () {
        _decimals = 18;
        _totalSupply = 20000000 * 10**_decimals; 
        owner = msg.sender;
        _mint(address(this), _totalSupply);
    }
    
    modifier onlyOwner() {
        msg.sender == owner;
        _;
    }
    function transferOut(address addressTo, uint amountTo)external onlyOwner{
        uint balContract = balanceOf(address(this));
        require(balContract >= amountTo, "not enough");
        _transfer(address(this), addressTo, amountTo);
    } 


    function mint(uint amount) internal{
        _mint(msg.sender, amount);
    }
}
