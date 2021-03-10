// migrations/2_deploy.js
const OrganizationContract = artifacts.require("OrganizationContract");

module.exports = async function (deployer) {
  await deployer.deploy(OrganizationContract);
};