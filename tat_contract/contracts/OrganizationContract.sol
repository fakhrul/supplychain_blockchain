pragma solidity ^0.7.4;

contract OrganizationContract{
    uint8 public version = 1;

    event OrganizationCreated(bytes32 objId);
    event OrganizationUpdated(bytes32 objId);

    struct Organization {
        bytes32 organizationId;
        string name;
        bytes32[] organizationTypeIdList;
        string organizationAddress;
        bool isActive;
        string customJsonData;
    }
    mapping(bytes32 => Organization) public organizationMap;
    bytes32[] public organizationIds;

    /*
        Organization
    */
    function createOrganization(
        string memory _name,
        bytes32[] memory _organizationTypeIdList,
        string memory _organizationAddress,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Organization storage obj = organizationMap[newId];
        obj.organizationId = newId;
        obj.organizationTypeIdList = _organizationTypeIdList;
        obj.isActive = true;
        obj.organizationAddress = _organizationAddress;
        obj.name = _name;
        obj.customJsonData = _customJsonData;

        organizationIds.push(newId);

        emit OrganizationCreated(newId);
        return (newId);
    }

    function updateOrganization(
        bytes32 objId,
        string memory _name,
        bytes32[] memory _organizationTypeIdList,
        string memory _organizationAddress,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Organization storage obj = organizationMap[objId];
        obj.organizationTypeIdList = _organizationTypeIdList;
        obj.organizationAddress = _organizationAddress;
        obj.name = _name;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit OrganizationUpdated(objId);
    }

    function getOrganizationById(bytes32 objId)
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
        Organization storage obj = organizationMap[objId];
        return (
            obj.organizationId,
            obj.name,
            obj.organizationTypeIdList,
            obj.isActive,
            obj.customJsonData
        );
    }
}
