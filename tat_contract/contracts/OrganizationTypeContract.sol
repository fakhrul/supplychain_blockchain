pragma solidity ^0.7.4;

contract OrganizationTypeContract {

    struct OrganizationType {
        bytes32 organizationTypeId;
        string name;
        bool isActive;
        string customJsonData;
    }
    mapping(bytes32 => OrganizationType) public organizationTypeMap;

    event OrganizationTypeCreated(bytes32 objId);
    event OrganizationTypeUpdated(bytes32 objId);

    bytes32[] public organizationTypeIds;

        function createOrganizationType(
        string memory _name,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        OrganizationType storage obj = organizationTypeMap[newId];
        obj.organizationTypeId = newId;
        obj.isActive = true;
        obj.name = _name;
        obj.customJsonData = _customJsonData;

        organizationTypeIds.push(newId);

        emit OrganizationTypeCreated(newId);
        return (newId);
    }

    function updateOrganizationType(
        bytes32 objId,
        string memory _name,
        string memory _customJsonData,
        bool _isActive
    ) public {
        OrganizationType storage obj = organizationTypeMap[objId];
        obj.name = _name;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit OrganizationTypeUpdated(objId);
    }

    function getOrganizationTypeById(bytes32 objId)
        public
        view
        returns (
            bytes32 id,
            string memory name,
            string memory customJsonData
        )
    {
        OrganizationType storage obj = organizationTypeMap[objId];
        return (obj.organizationTypeId, obj.name, obj.customJsonData);
    }

}
