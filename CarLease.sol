// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

contract CarLease {
    uint public value;
    address payable public BilBoyd;
    address payable public Customer;
    
    
    
    struct CustomerCer { // Struct
        uint Experience;
        uint MileCap;
    }
    
    enum Plan {Plan1, Plan2}
    Plan public Plan1;
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
            msg.sender == Customer,
            "Only car Customer can call this."
        );
        _;
    }
    
    constructor() payable {
        BilBoyd = msg.sender;
        //value = msg.value / 2;
        //require((2 * value) == msg.value, "Value has to be even.");
    }
    
    
    // Customer register 
    /* 1. register customer certificate
       2. choosePlan
       3. Duration
       4. StartDate
    */
    function Registeration() public {
    
    }
    
    function Time() public {
       // createTime = now;
    }
    
    function ViewLeasePlan() public view returns(string memory,string memory) {
        string memory Plan1="Plan 1 : WeeklyPay CarValue* 0.001";
        string memory Plan2="Plan 2 : WeeklyPay CarValue*0.0001+Mile*30";
      return (Plan1,Plan2);
    }
    
    function ChoosePlan(uint8 n) public returns(Plan) {
      return Plan1;
    }
    
    function WeeklyPay() public {
    }
}
