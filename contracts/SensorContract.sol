pragma solidity 0.4.24;

contract SensorContract{

    //Contract created by
    address private createdBy;
    
    //struct to store the filehashes which store the actual sensor data
    struct SensorData{
        //filehash is the swarm handle containing the actual sensor readings
        string filehash;
    }
    
    //map the struct to an id
    mapping(uint => SensorData) sensorDataStore;
    
    //CurrentID is the ID of the latest file handle created in Swarm
    uint private currentID;
    
    //store registered addresses in mapping
    mapping (address => bool) private trustedAddresses;
    
    //event after registration/de-registration
    event deviceEvent(
        address indexed _from,
        string _message
    );
    
    //event after registration/de-registration
    event setFileHashEvent(
        address indexed _from,
        string _message
    );

    //Constructor for the Smart Contract
    constructor() public {
        currentID = 1;
        createdBy = msg.sender;
    }
    
    //Modify some functions to be executed only by the Contract creator
    modifier ownerOnly {
        require(msg.sender == createdBy);
        _;
    }

    //function to get the currentID
    function getCurrentID() public view returns(uint){
        return currentID;
    }
    

    //function to increment the ID used internally for managing filehashes
    function incrCurrentID() public{
        currentID++;
    }
    
    //function to check if device is registered
    function devicePresent(address addressToAdd) public view returns (bool) {
            return trustedAddresses[addressToAdd];
    }
    
    //register IoT device
    function registerDevice(address addressToAdd) ownerOnly public {
        if(devicePresent(addressToAdd)) {
            emit deviceEvent(addressToAdd, "DEVICE ALREADY REGISTERED");
        }
            trustedAddresses[addressToAdd] = true;
            emit deviceEvent(addressToAdd, "SUCESSFULLY REGISTERED");
    }
    
    
    //deregister IoT device
    function deregisterDevice(address addressToRemove) ownerOnly public {
        if(!devicePresent(addressToRemove)) {
            emit deviceEvent(addressToRemove, "DEVICE NOT REGISTERED");
        }
            trustedAddresses[addressToRemove] = false;
            emit deviceEvent(addressToRemove, "SUCESSFULLY DEREGISTERED");
    }
    

    //Function to store the filehash from swarm
    function setSensorData(string _filehash) public {
        if(devicePresent(msg.sender)) {
            uint idToStore = getCurrentID();
            SensorData storage sensorReadings = sensorDataStore[idToStore];

            sensorReadings.filehash = _filehash;
       
            incrCurrentID();
            
            emit setFileHashEvent(msg.sender, "FILE HASH TRANSACTION CALLED");
        } else {
            emit setFileHashEvent(msg.sender, "DEVICE NOT REGISTERED");
        }
    }
    
    
    //Function to get the latest stored data
    function getSensorDataLatest() public view returns (string){
        if(devicePresent(msg.sender)) {
            SensorData storage sensorReadings = sensorDataStore[getCurrentID()-1];

            return sensorReadings.filehash;
        }
        return "DEVICE NOT REGISTERED";
    }
    
    //Function to get the data stored under some ID
    function getSensorDataByID(uint ID) public view returns (string){
        if(devicePresent(msg.sender)) {
            SensorData storage sensorReadings = sensorDataStore[ID];

            return sensorReadings.filehash;
        }
        return "DEVICE NOT REGISTERED";
    }
}