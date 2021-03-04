pragma solidity ^0.7.4;

contract ActivityContract {
    struct Activity {
        bytes32 activityId;
        string name;
        bytes32 organizationTypeId;
        bool isActive;
        string customJsonData;
    }

    mapping(bytes32 => Activity) public activityMap;
    bytes32[] public activityIds;

        event ActivityCreated(bytes32 objId);
    event ActivityUpdated(bytes32 objId);

    function createActivity(
        string memory _name,
        bytes32 _organizationTypeId,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Activity storage obj = activityMap[newId];
        obj.activityId = newId;
        obj.name = _name;
        obj.organizationTypeId = _organizationTypeId;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        activityIds.push(newId);

        emit ActivityCreated(newId);
        return (newId);
    }

    function updateActivity(
        bytes32 objId,
        string memory _name,
        bytes32 _organizationTypeId,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Activity storage obj = activityMap[objId];
        obj.organizationTypeId = _organizationTypeId;
        obj.name = _name;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit ActivityUpdated(objId);
    }

    function getActivityById(bytes32 objId)
        public
        view
        returns (
            bytes32 id,
            string memory name,
            bytes32 organizationTypeId,
            bool isActive,
            string memory customJsonData
        )
    {
        Activity storage obj = activityMap[objId];
        return (
            obj.activityId,
            obj.name,
            obj.organizationTypeId,
            obj.isActive,
            obj.customJsonData
        );
    }

}
