pragma solidity ^0.7.4;

contract OrganizationTypeContract {
    uint256 public version = 1;
    struct OrganizationType {
        bytes32 organizationTypeId;
        string name;
        bool isActive;
        string customJsonData;
    }
    mapping(bytes32 => OrganizationType) public dataMap;
    bytes32[] public dataList;

    event Created(bytes32 objId);
    event Updated(bytes32 objId);

    function create(string memory _name, string memory _customJsonData)
        public
        returns (bytes32 objId)
    {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        OrganizationType storage obj = dataMap[newId];
        obj.organizationTypeId = newId;
        obj.isActive = true;
        obj.name = _name;
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
        OrganizationType storage obj = dataMap[objId];
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
            string memory customJsonData
        )
    {
        OrganizationType storage obj = dataMap[objId];
        return (obj.organizationTypeId, obj.name, obj.customJsonData);
    }

    function getAll() public view returns (bytes32[] memory ids) {
        return (dataList);
    }
}
