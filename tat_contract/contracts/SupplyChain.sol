pragma solidity ^0.7.4;

import "./SupplyChainModels.sol";
import "./SupplyChainEvents.sol";

contract SupplyChain is SupplyChainModels, SupplyChainEvents {
    uint8 public version = 1;


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

}
