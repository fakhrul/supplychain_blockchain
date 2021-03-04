pragma solidity ^0.7.4;

contract SupplyChainEvents {
    event CategoryCreated(bytes32 objId);
    event CategoryUpdated(bytes32 objId);
    event ProductCreated(bytes32 objId);
    event ProductUpdated(bytes32 objId);
    event CertificationCreated(bytes32 objId);
    event CertificationUpdated(bytes32 objId);
    event TrackHistoryCreated(bytes32 objId);
    event TrackHistoryUpdated(bytes32 objId);

}
