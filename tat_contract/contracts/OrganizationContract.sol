pragma solidity ^0.7.4;

contract OrganizationContract {
    uint256 public version = 1;

    event Created(bytes32 objId);
    event Updated(bytes32 objId);

    struct Organization {
        bytes32 organizationId;
        string name;
        bytes32[] organizationTypeIdList;
        string organizationAddress;
        bool isActive;
        string customJsonData;
    }
    mapping(bytes32 => Organization) public dataMap;
    bytes32[] public dataList;

    /*
        Organization
    */
    function create(
        string memory _name,
        bytes32[] memory _organizationTypeIdList,
        string memory _organizationAddress,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Organization storage obj = dataMap[newId];
        obj.organizationId = newId;
        obj.organizationTypeIdList = _organizationTypeIdList;
        obj.isActive = true;
        obj.organizationAddress = _organizationAddress;
        obj.name = _name;
        obj.customJsonData = _customJsonData;

        dataList.push(newId);

        emit Created(newId);
        return (newId);
    }

    function update(
        bytes32 objId,
        string memory _name,
        bytes32[] memory _organizationTypeIdList,
        string memory _organizationAddress,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Organization storage obj = dataMap[objId];
        obj.organizationTypeIdList = _organizationTypeIdList;
        obj.organizationAddress = _organizationAddress;
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
            bytes32[] memory organizationTypeIdList,
            bool isActive,
            string memory customJsonData
        )
    {
        Organization storage obj = dataMap[objId];
        return (
            obj.organizationId,
            obj.name,
            obj.organizationTypeIdList,
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
