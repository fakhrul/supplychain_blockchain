// migrations/2_deploy.js
const TrailInfoContract = artifacts.require("TrailInfoContract");

module.exports = async function (deployer) {
  await deployer.deploy(TrailInfoContract);
};