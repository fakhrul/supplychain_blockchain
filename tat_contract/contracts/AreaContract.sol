pragma solidity ^0.7.4;

contract AreaContract {
    uint256 public version = 1;

    struct Area {
        bytes32 areaId;
        string name;
        bytes32 organizationId;
        bool isActive;
        string customJsonData;
    }

    mapping(bytes32 => Area) public dataMap;
    bytes32[] public dataList;

    event Created(bytes32 objId);
    event Updated(bytes32 objId);

    function create(
        string memory _name,
        bytes32 _organizationId,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Area storage obj = dataMap[newId];
        obj.areaId = newId;
        obj.name = _name;
        obj.organizationId = _organizationId;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        dataList.push(newId);

        emit Created(newId);
        return (newId);
    }

    function update(
        bytes32 objId,
        string memory _name,
        bytes32 _organizationId,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Area storage obj = dataMap[objId];
        obj.organizationId = _organizationId;
        obj.name = _name;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit Updated(objId);
    }

    function getById(bytes32 objId)
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
        Area storage obj = dataMap[objId];
        return (
            obj.areaId,
            obj.name,
            obj.organizationId,
            obj.isActive,
            obj.customJsonData
        );
    }

        function getAll() public view returns (bytes32[] memory ids) {
        return (dataList);
    }

}
