pragma solidity ^0.7.4;

contract CategoryContract {
    uint256 public version = 1;
    struct Category {
        bytes32 categoryId;
        string name;
        bool isActive;
        string customJsonData;
    }
    mapping(bytes32 => Category) public dataMap;
    bytes32[] public dataList;

    event Created(bytes32 objId);
    event Updated(bytes32 objId);

    function create(string memory _name, string memory _customJsonData)
        public
        returns (bytes32 objId)
    {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Category storage obj = dataMap[newId];
        obj.categoryId = newId;
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
        Category storage obj = dataMap[objId];
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
        Category storage obj = dataMap[objId];
        return (obj.categoryId, obj.name, obj.isActive, obj.customJsonData);
    }

    function getAll() public view returns (bytes32[] memory ids) {
        return (dataList);
    }
}
