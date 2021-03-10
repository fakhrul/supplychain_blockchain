// migrations/2_deploy.js
const ActivityContract = artifacts.require("ActivityContract");
const AreaContract = artifacts.require("AreaContract");
const CategoryContract = artifacts.require("CategoryContract");
const CertificationContract = artifacts.require("CertificationContract");
const OrganizationContract = artifacts.require("OrganizationContract");
const OrganizationTypeContract = artifacts.require("OrganizationTypeContract");
const ProductContract = artifacts.require("ProductContract");
const ProfileContract = artifacts.require("ProfileContract");
const RoleContract = artifacts.require("RoleContract");
const TrackHistoryContract = artifacts.require("TrackHistoryContract");

module.exports = async function (deployer) {
  await deployer.deploy(ActivityContract);
  await deployer.deploy(AreaContract);
  await deployer.deploy(OrganizationContract);
  await deployer.deploy(OrganizationTypeContract);
  await deployer.deploy(ProfileContract);
  await deployer.deploy(RoleContract);
  await deployer.deploy(CategoryContract);
  await deployer.deploy(CertificationContract);
  await deployer.deploy(ProductContract);
  await deployer.deploy(TrackHistoryContract);
};