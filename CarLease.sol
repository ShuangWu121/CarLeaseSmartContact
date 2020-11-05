// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

contract CarLease {
    uint public value;
    address payable public BilBoyd;
    struct public Customer { // Struct
        uint Experience;
        uint MileCap;
        address payable public CustomerAccount;
        uint Duration;
    }
     
    
    modifier onlyBilBoyd() { // Modifier
        require(
            msg.sender == BilBoyd,
            "Only car company BilBoyd can call this."
        );
        _;
    }
    
     modifier onlyCustomer() { // Modifier
        require(
            msg.sender == Customer.CustomerAccount,
            "Only car Customer can call this."
        );
        _;
    }
    
    constructor() payable {
        BilBoyd = msg.sender;
        //value = msg.value / 2;
        //require((2 * value) == msg.value, "Value has to be even.");
    }
    
    function LeasePlan {
    
    }
    
    function WeeklyPay {
    }
}
