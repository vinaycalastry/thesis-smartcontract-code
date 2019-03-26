pragma solidity 0.4.24;

contract SensorContract{

    //Contract created by
    //address private createdBy;
    
    //struct to store the filehashes which store the actual sensor data
    struct SensorData{
        //filehash is the swarm handle containing the actual sensor readings
        string filehash;
    }
    
    //map the struct to an id
    mapping(uint => SensorData) sensorDataStore;
    
    //dynamic array of ids to store the readings 
    //uint[] private sensorIDStore;
    
    //CurrentID is the ID of the latest file handle created in Swarm
    uint private currentID;

    //Constructor for the Smart Contract
    constructor() public {
        currentID = 1;
    }

    //function to get the currentID
    function getCurrentID() public view returns(uint){
        return currentID;
    }

    //function to increment the ID used internally for managing filehashes
    function incrCurrentID() public{
        currentID++;
    }
    
    //Function to store the filehash from swarm
    function setSensorData(string _filehash) public {
        uint idToStore = getCurrentID();
        SensorData storage sensorReadings = sensorDataStore[idToStore];

        sensorReadings.filehash = _filehash;
       
        //sensorIDStore.push(currentID);
        incrCurrentID();
    }
    
    
    //Function to get the latest stored data
    function getSensorDataLatest() public view returns (string){
        SensorData storage sensorReadings = sensorDataStore[getCurrentID()-1];

        return sensorReadings.filehash;
    }
    
    //Function to get the data stored under some ID
    function getSensorDataByID(uint ID) public view returns (string){
        SensorData storage sensorReadings = sensorDataStore[ID];

        return sensorReadings.filehash;
    }
}