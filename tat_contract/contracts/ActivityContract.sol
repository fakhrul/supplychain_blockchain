pragma solidity ^0.7.4;

contract ActivityContract {
    uint256 public version = 1;

    struct Activity {
        bytes32 activityId;
        string name;
        bytes32 organizationTypeId;
        bool isActive;
        string customJsonData;
    }

    mapping(bytes32 => Activity) public dataMap;
    bytes32[] public dataList;

    event Created(bytes32 objId);
    event Updated(bytes32 objId);

    function create(
        string memory _name,
        bytes32 _organizationTypeId,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Activity storage obj = dataMap[newId];
        obj.activityId = newId;
        obj.name = _name;
        obj.organizationTypeId = _organizationTypeId;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        dataList.push(newId);

        emit Created(newId);
        return (newId);
    }

    function update(
        bytes32 objId,
        string memory _name,
        bytes32 _organizationTypeId,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Activity storage obj = dataMap[objId];
        obj.organizationTypeId = _organizationTypeId;
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
            bytes32 organizationTypeId,
            bool isActive,
            string memory customJsonData
        )
    {
        Activity storage obj = dataMap[objId];
        return (
            obj.activityId,
            obj.name,
            obj.organizationTypeId,
            obj.isActive,
            obj.customJsonData
        );
    }

    function getAll() public view returns (bytes32[] memory ids) {
        return (dataList);
    }

    function activate(bytes32 objId, bool _isActive) public {
        dataMap[objId].isActive = _isActive;
        emit Updated(objId);
    }
}
