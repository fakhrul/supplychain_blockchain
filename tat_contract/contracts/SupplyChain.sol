pragma solidity ^0.7.4;

import "./SupplyChainModels.sol";
import "./SupplyChainEvents.sol";

contract SupplyChain is SupplyChainModels, SupplyChainEvents {
    string private info;
    string public version = "1.0.0.1";

    /*
        Organization Type
    */
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

    /*
        Activity
    */
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

    /*
        Area
    */
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

   /*
        Category
    */
    function createCategory(
        string memory _name,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Category storage obj = categoryMap[newId];
        obj.categoryId = newId;
        obj.name = _name;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        categoryIds.push(newId);

        emit CategoryCreated(newId);
        return (newId);
    }

    function updateCategory(
        bytes32 objId,
        string memory _name,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Category storage obj = categoryMap[objId];
        obj.name = _name;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit CategoryUpdated(objId);
    }

    function getCategoryById(bytes32 objId)
        public
        view
        returns (
            bytes32 id,
            string memory name,
            bool isActive,
            string memory customJsonData
        )
    {
        Category storage obj = categoryMap[objId];
        return (
            obj.categoryId,
            obj.name,
            obj.isActive,
            obj.customJsonData
        );
    }

   /*
        Product
    */
    function createProduct(
        string memory _name,
        bytes32  _categoryId,
        string memory _description,
        bytes32[] memory  _certificationIdList,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Product storage obj = productMap[newId];
        obj.productId = newId;
        obj.name = _name;
        obj.description = _description;
        obj.categoryId = _categoryId;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        productIds.push(newId);

        emit ProductCreated(newId);
        return (newId);
    }

    function updateProduct(
        bytes32 objId,
        string memory _name,
        bytes32 _categoryId,
        string memory _description,
        bytes32[] memory  _certificationIdList,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Product storage obj = productMap[objId];
        obj.name = _name;
        obj.categoryId = _categoryId;
        obj.description = _description;
        obj.certicationIdList = _certificationIdList;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit ProductUpdated(objId);
    }

    function getProductById(bytes32 objId)
        public
        view
        returns (
            bytes32 id,
            bytes32  categoryId,
            string memory name,
            string memory description,
            bytes32[] memory certicationIdList,
            bool isActive,
            string memory customJsonData
        )
    {
        Product storage obj = productMap[objId];
        return (
            obj.categoryId,
            obj.categoryId,
            obj.name,
            obj.description,
            obj.certicationIdList,
            obj.isActive,
            obj.customJsonData
        );
    }
    /*
        Contract Information
    */
    function setInfo(string memory _info) public {
        info = _info;
    }

    function getInfo() public view returns (string memory) {
        return info;
    }
}
