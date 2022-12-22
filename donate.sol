//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.7;
contract Donation{
    address public owner;
    uint256 public totalBalance;


    constructor(){
        owner=msg.sender;
    }
    //If an incorrect transfer is received, it adds to the balance.
    receive()payable external{
        totalBalance+=msg.value;
    }
    function withdraw(uint256 amount,address payable destAddress) external  noOwner{
        //Returns an error if the total balance is less than the withdrawal request
        require(totalBalance>amount,"Balance not enough");
        //Returns an error if the withdrawal request is 0
        require(amount!=0,"No Zero Withdraw");
        totalBalance-=amount;
        //Transfers the specified amount to the specified address
        destAddress.transfer(amount);
    }
    //It is checked whether the person who made the pull request owns it. If not the owner, it returns the error Only Owner.
    modifier noOwner{
    require(msg.sender==owner,"Only owner");
    _;
    }
   
}
