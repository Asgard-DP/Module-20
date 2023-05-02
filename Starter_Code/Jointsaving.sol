// SPDX-License-Identifier: MIT
pragma solidity  ^0.5.17;

contract JointSavings {
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdraw;
    uint public contractBalance;

    mapping(address => uint) balances;

    //function named withdraw that accepts two arguments
    function withdraw( uint amount, address payable recipient) public {
        require(recipient == accountTwo || recipient ==  accountOne, "You don't own this account!");
        require(address(this).balance >= amount, "Insufficient funds!");

        //if statement to check if lastToWithdraw is not equal to (!=) recipient. If it isn’t equal, set it to the current value of recipient
        if (lastToWithdraw != recipient){
            lastToWithdraw = recipient;
        }

        recipient.transfer(amount);
        lastToWithdraw = amount;
        contractBalance = address(this).balances;
    }
    // Deposit function
    function deposit() payable public {
         contractBalance = address(this).balance;

    }
    // set account funciton
    function setAccounts(address payable account1, address payable account2) public {
        accountOne = account1;
        accountTwo = account2;

    }
    // Fallback function to store ether sent from outside the deposit function
    receive () external  payable  {
        balances[msg.sender] += msg.value;
    }

}
