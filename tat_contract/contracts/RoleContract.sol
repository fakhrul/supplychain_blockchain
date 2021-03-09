pragma solidity ^0.7.4;

contract RoleContract {
    uint256 public version = 1;
    struct Role {
        bytes32 roleId;
        string name;
        bool isActive;
        string customJsonData;
    }

    mapping(bytes32 => Role) public dataMap;
    bytes32[] public dataList;

    event Created(bytes32 objId);
    event Updated(bytes32 objId);

    /*
        Role
    */
    function create(string memory _name, string memory _customJsonData)
        public
        returns (bytes32 objId)
    {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Role storage obj = dataMap[newId];
        obj.roleId = newId;
        obj.name = _name;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        dataList.push(newId);

        emit Created(newId);
        return (newId);
    }

    function update(
        bytes32 objId,
        string memory _name,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Role storage obj = dataMap[objId];
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
            bool isActive,
            string memory customJsonData
        )
    {
        Role storage obj = dataMap[objId];
        return (obj.roleId, obj.name, obj.isActive, obj.customJsonData);
    }

    function getAll() public view returns (bytes32[] memory ids) {
        return (dataList);
    }

    function activate(bytes32 objId, bool _isActive) public {
        dataMap[objId].isActive = _isActive;
        emit Updated(objId);
    }
}
