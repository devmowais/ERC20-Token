// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract ERC20FixedSupplyToken01 {
address owner;


    string public constant name = "Mazikeen";      // Token name 
    string public constant TokenSymbol = "M";      // TokenSymbol ID
    uint public TotalAllowedSupply = 100000000000;        // TotalAllowedSupply
    uint256 public immutable decimals;

// ***  EVENT  ***
        event Withdrawl( address indexed recipient, address indexed to, uint amount );

// ***  MAPPING ***
        mapping (address => uint) private balances;

    
    constructor () {
        owner = msg.sender;
        balances[msg.sender] = TotalAllowedSupply;
        decimals = 10;
    }

// *** MODIFIER ***
        modifier onlyOwner() {
            require (msg.sender == owner, "ALERT, YOU ARE NOT THE OWNER!");
            _;
        }

// *** Balance check of user address ***
        function balanceOf(address user) public view returns(uint) {
            return balances[user];     // *** Returns the amount of token this user holds ***
        }

// *** Transfering Token to one user to another Function ***
        function transfer(address reciever, uint amount) public returns(bool) {
            require (balances[msg.sender] >= amount, "NOT ENOUGH TOKENS TO TRANSFER!");
            balances[msg.sender] -= amount;
            balances[reciever] += amount;

                // *** Triggering event ***
            emit Withdrawl(msg.sender, reciever, amount);        
            return true;
        }

}
