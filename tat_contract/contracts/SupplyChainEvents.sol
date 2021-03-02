pragma solidity ^0.7.4;

contract SupplyChainEvents {
    event OrganizationCreated(bytes32 objId);
    event OrganizationUpdated(bytes32 objId);
    event OrganizationTypeCreated(bytes32 objId);
    event OrganizationTypeUpdated(bytes32 objId);
    event ActivityCreated(bytes32 objId);
    event ActivityUpdated(bytes32 objId);
    event AreaCreated(bytes32 objId);
    event AreaUpdated(bytes32 objId);
    event CategoryCreated(bytes32 objId);
    event CategoryUpdated(bytes32 objId);
    event ProductCreated(bytes32 objId);
    event ProductUpdated(bytes32 objId);
}
