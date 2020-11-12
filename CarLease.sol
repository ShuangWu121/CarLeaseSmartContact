// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;


contract CarLease {
    address payable public BilBoyd;
    

    struct Customer { // Struct
        address payable CustomerAddress;
        uint Deposit;
        uint Experience;
        uint MileCap;
        uint Duration;
        uint CarValue;
        uint WeeklyPay;
        uint StartTime;
        uint Payments;
        uint Loyalty;
    }
    
    Customer public customer;
    
    struct Car {
        uint CarValue;
        uint MileCap;
    }
    
    Car[3] car;
    
    
 
    enum TerminationState {Extend,BuyCar,Terminate,NewSign}
    // The state variable has a default value of the first member, `State.created`
     
    
    modifier onlyBilBoyd() { // Modifier
        require(
            msg.sender == BilBoyd,
            "Only car company BilBoyd can call this."
        );
        _;
    }
    
     modifier onlyCustomer() { // Modifier
        require(
            msg.sender == customer.CustomerAddress,
            "Only car Customer can call this."
        );
        _;
    }
    
    constructor() payable {
        BilBoyd = msg.sender;
        car[0].CarValue=20000;
        car[0].MileCap=2000;
    
        car[1].CarValue=30000;
        car[1].MileCap=3000;
    
        car[2].CarValue=40000;
        car[2].MileCap=4000;
    }
    
    
    function BilBoydCustomerInfo(uint8 car_index, uint8 experience) public onlyBilBoyd {
        customer.CarValue = car[car_index].CarValue;
        customer.Experience = experience;
        customer.MileCap = car[car_index].MileCap; 
        customer.Loyalty=1;
    }
    
    
    // Customer register 
    /* 
          check Deposit
       1. register customer certificate
       2. choosePlan
       3. Duration
       4. StartDate
    */
    function Registeration(uint contractDuration) 
        public payable {
    
        uint requredDeposit=(customer.CarValue+customer.MileCap)*15/100; //Formula for deposit goes here
        
        require(msg.value>=requredDeposit, "Deposit not enough.");
        
       // if(msg.value > requredDeposit)
        //    customer.CustomerAddress.transfer(msg.value - requredDeposit);
    
        
        customer.Duration = contractDuration;
        customer.CustomerAddress = msg.sender;
        customer.Deposit = requredDeposit;

        
        customer.WeeklyPay = (customer.CarValue + customer.MileCap)/(contractDuration * customer.Experience * 7000 * customer.Loyalty);
        customer.StartTime = block.timestamp;
        customer.Payments=0;
        customer.Payments += 1;
    }
    

    
    
    function WeeklyPay() public onlyCustomer payable {
        require(msg.value >= customer.WeeklyPay,"Its not enough");
        
      //  if(msg.value > customer.WeeklyPay)
        //    customer.CustomerAddress.transfer(msg.value-customer.WeeklyPay);
        customer.Payments += 1;
        BilBoyd.transfer(customer.WeeklyPay);
    }
    
   
    
    function TerminateContract() public onlyBilBoyd {
        require(block.timestamp < customer.StartTime + customer.Duration);
        require(
            customer.Payments < (block.timestamp-customer.StartTime )/1 weeks +3
        );
        selfdestruct(BilBoyd);
    }
    
    function TerminateChoice(TerminationState termination, uint NewDuration, uint NewCar) public onlyCustomer payable returns(string memory) {
        
        //one week before original contract ends.
        require(block.timestamp > customer.StartTime + customer.Duration* 1 weeks-1 && block.timestamp <customer.StartTime + customer.Duration* 1 weeks);
        
        //Extend the contract
        if(termination==TerminationState.Extend){
            customer.Duration =(customer.Duration + 52 weeks); 
            customer.Loyalty+=1;
            return "Extend successfully"; 
            
            
        }  
        
        else if(termination==TerminationState.BuyCar){
            uint Car;
            Car=customer.CarValue - customer.Deposit;
            require(msg.value>Car,"Not enough to buy the car"); // payment should be eqaul to car value - paid deposit
            BilBoyd.transfer(Car);
            customer.Duration=block.timestamp-customer.StartTime;
           // if(msg.value > customer.CarValue - customer.Deposit)
           // customer.CustomerAddress.transfer(msg.value - customer.CarValue - customer.Deposit);
            return "The car is yours now";
        }
        
        else if(termination==TerminationState.NewSign)
            customer.StartTime=block.timestamp;
            customer.CarValue=car[NewCar].CarValue;
            customer.Duration=NewDuration;
            customer.MileCap=car[NewCar].MileCap;
            customer.Loyalty+=1;
            return "New Sign successfully"; 
    }
    
    function ExpireContract () public payable{
        if(block.timestamp > customer.StartTime + customer.Duration)
        selfdestruct(customer.CustomerAddress);
    }
    
    
}
