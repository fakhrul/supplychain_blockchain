// migrations/2_deploy.js
const ProfileContract = artifacts.require("ProfileContract");

module.exports = async function (deployer) {
  await deployer.deploy(ProfileContract);
};