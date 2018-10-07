pragma solidity ^0.4.25;


contract payroll{
    
    function deposit() payable public {
    redistribute();
    }
        
    address owner = msg.sender;
    
    uint Balance;
    uint AvailableBalance;
    uint ReservedBalance;
    
    uint256 EmployeeCount;
    uint256 ID = 1;
    
    event broadcast(string);

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
    

    /* Mapping */
    
    mapping (uint256 => string) _Name;
    mapping (uint256 => uint256) _IDnumber;
    mapping (uint256 => address) _Address;
    mapping (uint256 => uint256) _Balance;
    mapping (uint256 => bool) _Lock;
    
    mapping (address => uint256) IDbyAddress;
    
     /* Modifiers */

    modifier Owned(){
        require (msg.sender == owner);
        _;
    }
    
    /* Event */
    event broadcast(string);

}

  
