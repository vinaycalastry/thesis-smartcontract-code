pragma solidity 0.4.24;

contract SensorContract{

    //Contract created by
    address private creator;
    
    //struct to store the filehashes which store the actual sensor data
    struct SensorData{
        //filehash is the swarm handle containing the actual sensor readings
        string filehash;
    }
    
    //map the struct to an id
    mapping(uint => SensorData) sensorDataStore;
    
    //CurrentID is the ID of the latest file handle created in Swarm
    uint private currentID;
    
    mapping (address => bool) private trustedAddresses;

    //Constructor for the Smart Contract
    constructor() public {
        currentID = 1;
        creator = msg.sender;
    }
    
    modifier ownerOnly {
        require(msg.sender == creator);
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
    
    //register device
    function registerDevice(address addressToAdd) ownerOnly public returns (string) {
        if(devicePresent(addressToAdd)) {
            return "INFO:ALREADY_REGISTERED";
        }
            trustedAddresses[addressToAdd] = true;
            return "INFO:REGISTRATION_SUCCESSFUL";
    }
    
    
    //deregister device
    function deregisterDevice(address addressToRemove) ownerOnly public returns (string) {
        if(!devicePresent(addressToRemove)) {
            return "INFO:DEVICE_NOT_PRESENT";
        }
            trustedAddresses[addressToRemove] = false;
            return "INFO:DEREGISTRATION_SUCCESSFUL";
    }
    

    //Function to store the filehash from swarm
    function setSensorData(string _filehash) public returns (string) {
        if(devicePresent(msg.sender)) {
            uint idToStore = getCurrentID();
            SensorData storage sensorReadings = sensorDataStore[idToStore];

            sensorReadings.filehash = _filehash;
       
            incrCurrentID();
            
            return "SUCCESS";
        } else {
            return "ERROR";
        }
    }
    
    
    //Function to get the latest stored data
    function getSensorDataLatest() public view returns (string){
        if(devicePresent(msg.sender)) {
            SensorData storage sensorReadings = sensorDataStore[getCurrentID()-1];

            return sensorReadings.filehash;
        }
        return "ERROR";
    }
    
    //Function to get the data stored under some ID
    function getSensorDataByID(uint ID) public view returns (string){
        if(devicePresent(msg.sender)) {
            SensorData storage sensorReadings = sensorDataStore[ID];

            return sensorReadings.filehash;
        }
        return "ERROR";
    }
}