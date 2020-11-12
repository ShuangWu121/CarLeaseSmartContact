// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;


contract CarLease {
    address payable public BilBoyd;
    
    enum Plan {Plan1, Plan2}
    enum Termination {Terminate, BuyCar,Extend} 
    struct Customer { // Struct
        address payable CustomerAddress;
        uint Deposit;
        uint Experience;
        uint MileCap;
        uint Duration;
        uint CarValue;
        uint WeeklyPay;
        Plan ChoosenPlan;
        uint StartTime;
        uint Payments;
    }
    
    Customer public customer;
    
    
    
    enum State { Created, Active, Inactive }
    enum TerminationState {Extend,BuyCar,Terminate}
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
            msg.sender == customer.CustomerAddress,
            "Only car Customer can call this."
        );
        _;
    }
    
    constructor() payable {
        BilBoyd = msg.sender;
        state=State.Created;
    }
    
    
    // Customer register 
    /* 
          check Deposit
       1. register customer certificate
       2. choosePlan
       3. Duration
       4. StartDate
    */
    function Registeration(uint8 carValue, Plan plan, uint experience, uint mileCap, uint contractDuration) 
        public onlyBilBoyd payable {
    
        uint requredDeposit=(carValue+mileCap)*15/100; //Formula for deposit goes here
        
        require(msg.value>=requredDeposit, "Deposit not enough.");
        
        if(msg.value > requredDeposit)
            customer.CustomerAddress.transfer(msg.value - requredDeposit);
        customer.Payments += 1;
        
        customer.Experience = experience;
        customer.MileCap = mileCap;
        customer.Duration = contractDuration;
        customer.CarValue = carValue;
        customer.CustomerAddress = msg.sender;
        customer.Deposit = msg.value;
        customer.ChoosenPlan = plan;
        
        customer.WeeklyPay = (carValue + mileCap)/(contractDuration * experience * 7000);
        state = State.Active;
        customer.StartTime = block.timestamp;
        customer.Payments=0;
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
    
      return customer.ChoosenPlan;
    }
    
    function WeeklyPay() public onlyCustomer payable {
        require(msg.value >= customer.WeeklyPay,"Its not enough");
        
        if(msg.value > customer.WeeklyPay)
            customer.CustomerAddress.transfer(msg.value-customer.WeeklyPay);
        customer.Payments += 1;
    }
    
    function CheckWeeklyPay() public onlyBilBoyd {
        uint expectedPayments = (block.timestamp-customer.StartTime)/1 weeks; //Formula to get time since start of contract
        if(expectedPayments -customer.Payments > 4)
            customer.Payments += 1;//Remove. Only to fix compile error with if
           
            //TODO:
            //terminate contract if deposit is empty
        
    }
    
    function TerminateContract(TerminationState termination) public onlyBilBoyd {
        require(block.timestamp > customer.StartTime + customer.Duration);
        require(
            customer.Payments < (block.timestamp-customer.StartTime + 3)/1 weeks
        );
        selfdestruct(BilBoyd);

    }
    
    function TerminateChoice(TerminationState termination) public onlyCustomer returns(string memory) {
        require(block.timestamp > customer.StartTime + customer.Duration);
        if(termination==TerminationState.Extend){
            customer.Payments = (customer.CarValue + customer.MileCap)/(customer.Duration * customer.Experience * 7000 * 2); 
            return "Extend successfully"; 
            
        }   // Recalculated weekly payment with 2 as loyalty parameter
        else if(termination==TerminationState.BuyCar){
            customer.Payments = customer.CarValue - customer.Deposit; // payment should be eqaul to car value - paid deposit
            return 'Bought successfully'
        }
      //  else if(termination==TerminationState.Terminate)
         //   customer.Payments = selfdestruct(customer.CustomerAddress); //https://solidity-by-example.org/0.6/hacks/self-destruct/ example ıs here 
        
    }
