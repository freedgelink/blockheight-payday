pragma solidity ^0.4.25;


contract payroll{
    
    function deposit() payable public {
    redistribute();
    }
        
    address owner = msg.sender;
    
    uint Balance;
    uint AvailableBalance;
    uint ReservedBalance;
    uint GasReserve
    
    uint256 EmployeeCount;
    uint256 ID = 1;
    
    event broadcast(string);

    modifier Owned(){
        require (msg.sender == owner);
        _;
    }
    
    mapping (uint256 => string) _Name;
    mapping (uint256 => uint256) _IDnumber;
    mapping (uint256 => address) _Address;
    mapping (uint256 => uint256) _Balance;
    mapping (uint256 => bool) _Lock;
    
    mapping (address => uint256) IDbyAddress;

    modifier Owned(){
        require (msg.sender == owner);
        _;
    }
    
   

struct Employees{
        string name;
        address _address;
        uint balance;
        bool lock;
    }
    
     event broadcast(
        string
        );
        
   modifier Lockable(){
        require (lock == false);
        _;
    }
    
    modifier Owned(){
        require (msg.sender == owner);
        _;
    }
    
    function Shutoff(bool Lock) external Owned{
        lock = Lock;
    }
        function AddEmployee(string Name, address Address, bool Lock) external Owned{
        employee.push(Employees(Name, Address, 0, Lock));
    }
    
    function EditEmployee(uint index, address NewAddress) external Owned{
        employee[index]._address = NewAddress;
    }
    
   function DeleteUser(string Name) public{
        require(EmployeeCount > 0);
        require(_Lock[Name] == true);
        AvailableBalance = AvailableBalance + _Balance[Name];
        ReservedBalance = ReservedBalance - _Balance[Name];
        _Address[Name] = 0;
        _Balance[Name] = 0;
        _Lock[Name] = true;
        EmployeeCount--;
        }
    }
    
    event broadcast(string);

    }
    
    function redistribute() internal {
        Balance = address(this).balance;
        if(Balance > ReservedBalance + GasReserve){
        AvailableBalance = Balance - (ReservedBalance + GasReserve);
        }
    } 
    
    function Distribute() internal{
        require(EmployeeCount > 0);
        redistribute();
        require(AvailableBalance > 0);
        uint Payout = AvailableBalance / EmployeeCount;
        for(uint i=1; i <= ID -1; i++) {
            if(_IDnumber[i] >= 1 ){
            _Balance[i] += Payout ;
        }
       }
        ReservedBalance += AvailableBalance;
        AvailableBalance = 0;
    }
    
    /* Test Functions */
      
    function WhatsTheDay() public view returns(uint) {
        return block.number;
    }

    function TestDistribute() public Owned{
        Distribute();
    }
    
    function TestRedistribute() public Owned{
        redistribute();
    }
    
    function ContractBalanceWei() public view returns (uint){
        return address(this).balance;
    }
    
    function TestAvailable_balance() public view returns (uint){
        return(AvailableBalance);
    }

}

function onboard(string Name, address Address) public Owned {
        _Name[ID] = Name;
        _IDnumber[ID] = ID;
        _Address[ID] = Address;
        _Balance[ID] = 0;
        _Lock[ID] = false;
        IDbyAddress[Address] = ID;
        EmployeeCount++;
        ID++;
        
        GasReserve = EmployeeCount * 1e9 wei;

        emit broadcast(Name);
        
    }
    
    function getbyID(uint256 EmployeeID) public view Owned returns(string, address, uint256, bool){
        return(_Name[EmployeeID], _Address[EmployeeID], _Balance[EmployeeID], _Lock[EmployeeID]);
    }
    
    function EmployeeLock(uint256 EmployeeID, bool Toggle) public Owned {
        _Lock[EmployeeID] = Toggle;
    }
    
    function changeAddress(uint256 EmployeeID, address Address) public Owned{
        require(_Lock[EmployeeID] == true);
        _Address[EmployeeID] = Address;
    }
    
    function DeleteUser(uint256 EmployeeID) public Owned{
        require(EmployeeCount > 0);
        require(_Lock[EmployeeID] == true);
        AvailableBalance = AvailableBalance + _Balance[EmployeeID];
        ReservedBalance = ReservedBalance - _Balance[EmployeeID];
        IDbyAddress[_Address[EmployeeID]] = 0;
        _Name[EmployeeID] = '';
        _IDnumber[EmployeeID] = 0;
        _Address[EmployeeID] = 0;
        _Balance[EmployeeID] = 0;
        _Lock[EmployeeID] = true;
        EmployeeCount--;
        
        GasReserve = EmployeeCount * 1e9 wei;
    }
}


