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
    enum State { Created, Locked, Release, Inactive }
    // The state variable has a default value of the first member, `State.created`
    State public state;
     
    
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
    
    function Registeration {
    
    }
    
    function Time() public {
        createTime = now;
    }
    
    function LeasePlan {
    
    }
    
    function WeeklyPay {
    }
}
