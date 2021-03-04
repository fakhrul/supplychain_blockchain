pragma solidity ^0.7.4;

contract AreaContract {
    struct Area {
        bytes32 areaId;
        string name;
        bytes32 organizationId;
        bool isActive;
        string customJsonData;
    }

    mapping(bytes32 => Area) public areaMap;
    bytes32[] public areaIds;

        event AreaCreated(bytes32 objId);
    event AreaUpdated(bytes32 objId);

    function createArea(
        string memory _name,
        bytes32 _organizationId,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Area storage obj = areaMap[newId];
        obj.areaId = newId;
        obj.name = _name;
        obj.organizationId = _organizationId;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        areaIds.push(newId);

        emit AreaCreated(newId);
        return (newId);
    }

    function updateArea(
        bytes32 objId,
        string memory _name,
        bytes32 _organizationId,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Area storage obj = areaMap[objId];
        obj.organizationId = _organizationId;
        obj.name = _name;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit AreaUpdated(objId);
    }

    function getAreaById(bytes32 objId)
        public
        view
        returns (
            bytes32 id,
            string memory name,
            bytes32 organizationId,
            bool isActive,
            string memory customJsonData
        )
    {
        Area storage obj = areaMap[objId];
        return (
            obj.areaId,
            obj.name,
            obj.organizationId,
            obj.isActive,
            obj.customJsonData
        );
    }

}
