pragma solidity 0.4.24;

contract SensorContract{
    
    //struct to store the temperature, humidity and time when reading occurred
    struct SensorData{
        uint64 temperature;
        uint64 humidity;
        string dataStorageTime;
    }
    
    //map the struct to an id
    mapping(uint => SensorData) sensorDataStore;
    
    //dynamic array of ids to store the readings 
    uint[] public sensorIDStore;
    
    //var to keep track of latest reading.
    uint public currentID;

    constructor() public {
        currentID = 0;
    }

    //function to get the currentID
    function getCurrentID() public view returns(uint){
        return currentID-1;
    }

    function incrCurrentID() public returns(uint){
        return currentID++;
    }
    
    //Function to store the data coming from IOT DHT11 sensor
    function setSensorData(uint64 _temperature, uint64 _humidity, string _dataStorageTime) public {
        SensorData storage sensorReadings = sensorDataStore[currentID];

        sensorReadings.temperature = _temperature;
        sensorReadings.humidity = _humidity;
        sensorReadings.dataStorageTime = _dataStorageTime;
        
        sensorIDStore.push(currentID)-1;
        incrCurrentID();
    }
    
    
    //Function to get the latest stored data
    function getSensorDataLatest() public view returns (uint64, uint64, string){
        SensorData storage sensorReadings = sensorDataStore[getCurrentID()];

        return (sensorReadings.temperature, sensorReadings.humidity, sensorReadings.dataStorageTime);
    }
    
    //Function to get the data stored under some ID
    function getSensorDataByID(uint ID) public view returns (uint64, uint64, string){
        SensorData storage sensorReadings = sensorDataStore[ID];

        return (sensorReadings.temperature, sensorReadings.humidity, sensorReadings.dataStorageTime);
    }    
}