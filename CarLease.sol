// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

contract CarLease {
    address payable public BilBoyd;
    
    
    
    
    
    struct Customer { // Struct
        address payable  CustomerAddress;
        uint Deposit;
        uint Experience;
        uint MileCap;
        uint Duration;
        uint CarValue;
    }
    
    Customer public customer;
    
    enum Plan {Plan1, Plan2}
    Plan public Plan4;
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
            msg.sender == customer.customerAddress,
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
    /* 
          check Deposit
       1. register customer certificate
       2. choosePlan
       3. Duration
       4. StartDate
    */
    function Registeration(uint8 carValue, Plan plan, uint experience, uint mileCap, uint duration) public payable {
    
        uint requredDeposit=2; //Formula for deposit goes here
        
        require(msg.value==requredDeposit, "Deposit not enough.");
        
        customer.Experience = experience;
        customer.MileCap = mileCap;
        customer.Duration = duration;
        customer.CarValue = carValue;
        customer.CustomerAddress = msg.sender;
        customer.Deposit = msg.value;
        
        Plan4 = plan;
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
      return Plan4;
    }
    
    function WeeklyPay() public {
    }
}
