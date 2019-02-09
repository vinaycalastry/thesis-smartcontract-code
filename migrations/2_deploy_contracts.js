var SensorContract = artifacts.require("./SensorContract.sol");

module.exports = function(deployer){

    deployer.deploy(SensorContract);

};