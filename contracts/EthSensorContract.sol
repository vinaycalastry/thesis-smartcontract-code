pragma solidity 0.4.24;

contract SensorContract{

    //Contract created by
    address private createdBy;
    
    //struct to store the filehashes which store the actual sensor data
    struct SensorData{
        //filehash is the swarm handle containing the actual sensor readings
        string temperature;
        string humidity;
        string tempunits;
        string humiunits;
        string timestamp;
        string devicetype;
        string deviceid;
        string deviceip;
        string sensortype;
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
    

    //function to get the currentID
    function getCurrentID() public view returns(uint){
        return currentID;
    }
    

    //function to increment the ID used internally for managing filehashes
    function incrCurrentID() public{
        currentID++;
    }
    
    
        //Function to store the filehash from swarm
    function setSensorData(
        string temp, 
        string humi, 
        string tempunits, 
        string humiunits, 
        string timestamp, 
        string devicetype, 
        string deviceid,
        string deviceip, 
        string sensortype
        ) public {
        
        uint idToStore = getCurrentID();
        SensorData storage sensorReadings = sensorDataStore[idToStore];

        sensorReadings.temperature = temp;
        sensorReadings.humidity = humi;
        sensorReadings.tempunits = tempunits;
        sensorReadings.humiunits = humiunits;
        sensorReadings.timestamp = timestamp;
        sensorReadings.devicetype = devicetype;
        sensorReadings.deviceid = deviceid;
        sensorReadings.deviceip = deviceip;
        sensorReadings.sensortype = sensortype;
       
        incrCurrentID();
            
        emit setFileHashEvent(msg.sender, "FILE HASH TRANSACTION CALLED");
    }
    
    
    //Function to get the latest stored data
    function getSensorDataLatest() public view returns (string temp, 
        string humi, 
        string tempunits, 
        string humiunits, 
        string timestamp, 
        string devicetype, 
        string deviceid,
        string deviceip, 
        string sensortype){
        SensorData storage sensorReadings = sensorDataStore[getCurrentID()-1];

        return sensorReadings.temperature;
    }
    
    //Function to get the data stored under some ID
    function getSensorDataByID(uint ID) public view returns (
        string temp, 
        string humi, 
        string tempunits, 
        string humiunits, 
        string timestamp, 
        string devicetype, 
        string deviceid,
        string deviceip, 
        string sensortype){
            SensorData storage sensorReadings = sensorDataStore[ID];

            return sensorReadings.temperature;
    }
}