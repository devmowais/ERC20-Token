// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

contract ERC20MintableSupplyToken02 {
address owner;


string public constant name = "Arthur Shelby";      // Token name 
string public constant TokenSymbol = "AS";      // TokenSymbol ID
uint public TotalAllowedSupply = 100000000;        // TotalAllowedSupply
uint256 public immutable decimals;

// ***  EVENT  ***
        event Withdrawl( address indexed recipient, address indexed to, uint amount );

// ***  MAPPING ***
        mapping (address => uint) private balances;

    
    constructor () {
        owner = msg.sender;
        balances[msg.sender] = TotalAllowedSupply;
        decimals = 8;
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

// *** NOW MINTING FUNCTION ***
        function Minting(uint quantity) public onlyOwner returns(uint) {
            TotalAllowedSupply += quantity;
            balances[msg.sender] += quantity;
            return TotalAllowedSupply;
        }
        
                // *** NOW BURNING FUNCTION *** //
             //This function burns the entered amount from the totalSupply except 1mn tokens
      function burn(address user, uint amount) public onlyOwner returns(uint) {
        require(balances[user] >= amount,"You haven't enough tokens to burn"); //check
        balances[user] -= amount; // balances[user] = balances[user] - amount
        TotalAllowedSupply -= amount; //totalSupply = totalSupply - amount
        require(TotalAllowedSupply >= 1000000, "You can't burn more tokens");
        return TotalAllowedSupply;
    }
}
