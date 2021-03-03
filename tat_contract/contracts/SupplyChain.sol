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
    function createCategory(string memory _name, string memory _customJsonData)
        public
        returns (bytes32 objId)
    {
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
        return (obj.categoryId, obj.name, obj.isActive, obj.customJsonData);
    }

    /*
        Product
    */
    function createProduct(
        string memory _name,
        bytes32 _categoryId,
        string memory _description,
        bytes32[] memory _certificationIdList,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Product storage obj = productMap[newId];
        obj.productId = newId;
        obj.name = _name;
        obj.description = _description;
        obj.certicationIdList = _certificationIdList;
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
        bytes32[] memory _certificationIdList,
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
            bytes32 categoryId,
            string memory name,
            string memory description,
            bytes32[] memory certicationIdList,
            bool isActive,
            string memory customJsonData
        )
    {
        Product storage obj = productMap[objId];
        return (
            obj.productId,
            obj.categoryId,
            obj.name,
            obj.description,
            obj.certicationIdList,
            obj.isActive,
            obj.customJsonData
        );
    }

    /*
        Role
    */
    function createRole(string memory _name, string memory _customJsonData)
        public
        returns (bytes32 objId)
    {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Role storage obj = roleMap[newId];
        obj.roleId = newId;
        obj.name = _name;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        roleIds.push(newId);

        emit RoleCreated(newId);
        return (newId);
    }

    function updateRole(
        bytes32 objId,
        string memory _name,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Role storage obj = roleMap[objId];
        obj.name = _name;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit RoleUpdated(objId);
    }

    function getRoleById(bytes32 objId)
        public
        view
        returns (
            bytes32 id,
            string memory name,
            bool isActive,
            string memory customJsonData
        )
    {
        Role storage obj = roleMap[objId];
        return (obj.roleId, obj.name, obj.isActive, obj.customJsonData);
    }

    /*
        Profile
    */
    function createProfile(
        string memory _name,
        string memory _email,
        string memory _passwordHash,
        string memory _phone,
        bytes32[] memory _roleId,
        bytes32 _organizationId,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Profile storage obj = profileMap[newId];
        obj.profileId = newId;
        obj.name = _name;
        obj.email = _email;
        obj.passwordHash = _passwordHash;
        obj.phone = _phone;
        obj.roleId = _roleId;
        obj.organizationId = _organizationId;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        profileIds.push(newId);

        emit ProfileCreated(newId);
        return (newId);
    }

    function updateProfile(
        bytes32 objId,
        string memory _name,
        string memory _email,
        string memory _passwordHash,
        string memory _phone,
        bytes32[] memory _roleId,
        bytes32 _organizationId,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Profile storage obj = profileMap[objId];
        obj.name = _name;
        obj.email = _email;
        obj.passwordHash = _passwordHash;
        obj.phone = _phone;
        obj.roleId = _roleId;
        obj.organizationId = _organizationId;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit ProfileUpdated(objId);
    }

    function getProfileById(bytes32 objId)
        public
        view
        returns (
            bytes32 id,
            string memory name,
            string memory email,
            string memory passwordHash,
            string memory phone,
            bytes32[] memory roleId,
            bytes32 organizationId,
            bool isActive,
            string memory customJsonData
        )
    {
        Profile storage obj = profileMap[objId];
        return (
            obj.profileId,
            obj.name,
            obj.email,
            obj.passwordHash,
            obj.phone,
            obj.roleId,
            obj.organizationId,
            obj.isActive,
            obj.customJsonData
        );
    }

    /*
        Certification
    */
    function createCertification(
        string memory _name,
        string memory _certificationUrl,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Certification storage obj = certificationMap[newId];
        obj.certificationId = newId;
        obj.name = _name;
        obj.certificateUrl = _certificationUrl;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        certificationIds.push(newId);

        emit CertificationCreated(newId);
        return (newId);
    }

    function updateCertification(
        bytes32 objId,
        string memory _name,
        string memory _certificationUrl,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Certification storage obj = certificationMap[objId];
        obj.name = _name;
        obj.certificateUrl = _certificationUrl;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit CertificationUpdated(objId);
    }

    function getCertificationById(bytes32 objId)
        public
        view
        returns (
            bytes32 id,
            string memory name,
            string memory certificateUrl,
            bool isActive,
            string memory customJsonData
        )
    {
        Certification storage obj = certificationMap[objId];
        return (
            obj.certificationId,
            obj.name,
            obj.certificateUrl,
            obj.isActive,
            obj.customJsonData
        );
    }

    /*
        Track History
    */
    function createTrackHistory(
        bytes32 _trackHistoryId,
        bytes32 _productId,
        bytes32 _activityId,
        bytes32 _profileId,
        bytes32 _areaId,
        string memory _gps,
        string memory _remarks,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        TrackHistory storage obj = trackHistoryMap[newId];
        obj.trackHistoryId = newId;
        obj.productId = _productId;
        obj.activityId = _activityId;
        obj.profileId = _profileId;
        obj.areaId = _areaId;
        obj.gps = _gps;
        obj.remarks = _remarks;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        trackHistoryIds.push(newId);

        emit TrackHistoryCreated(newId);
        return (newId);
    }

    function updateTrackHistory(
        bytes32 objId,
        bytes32 _productId,
        bytes32 _activityId,
        bytes32 _profileId,
        bytes32 _areaId,
        string memory _gps,
        string memory _remarks,
        string memory _customJsonData,
        bool _isActive
    ) public {
        TrackHistory storage obj = trackHistoryMap[objId];
        obj.productId = _productId;
        obj.activityId = _activityId;
        obj.profileId = _profileId;
        obj.productId = _productId;
        obj.areaId = _areaId;
        obj.gps = _gps;
        obj.remarks = _remarks;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit TrackHistoryUpdated(objId);
    }

    function getTrackHistoryById(bytes32 objId)
        public
        view
        returns (
            bytes32 id,
            bytes32 productId,
            bytes32 activityId,
            bytes32 profileId,
            bytes32 areaId,
            string memory gps,
            string memory remarks,
            bool isActive,
            string memory customJsonData
        )
    {
        TrackHistory storage obj = trackHistoryMap[objId];
        return (
            obj.trackHistoryId,
            obj.productId,
            obj.activityId,
            obj.profileId,
            obj.areaId,
            obj.gps,
            obj.remarks,
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
