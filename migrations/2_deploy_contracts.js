var SensorContract = artifacts.require("./SensorContract.sol");
var EthSensorContract = artifacts.require("./EthSensorContract.sol");

module.exports = function(deployer){

    deployer.deploy(SensorContract);
    deployer.deploy(EthSensorContract);
};