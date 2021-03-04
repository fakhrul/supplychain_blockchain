pragma solidity ^0.7.4;

contract SupplyChainModels {
    struct Category {
        bytes32 categoryId;
        string name;
        bool isActive;
        string customJsonData;
    }

    struct Product {
        bytes32 productId;
        bytes32 categoryId;
        string name;
        string description;
        bytes32[] certicationIdList;
        bool isActive;
        string customJsonData;
    }

    struct Certification {
        bytes32 certificationId;
        string name;
        string certificateUrl;
        bool isActive;
        string customJsonData;
    }

    struct TrackHistory {
        bytes32 trackHistoryId;
        bytes32 productId;
        bytes32 activityId;
        bytes32 profileId;
        bytes32 areaId;
        string gps;
        string remarks;
        bool isActive;
        string customJsonData;
    }

    mapping(bytes32 => Category) public categoryMap;
    mapping(bytes32 => Product) public productMap;
    mapping(bytes32 => Certification) public certificationMap;
    mapping(bytes32 => TrackHistory) public trackHistoryMap;

    bytes32[] public categoryIds;
    bytes32[] public productIds;
    bytes32[] public certificationIds;
    bytes32[] public trackHistoryIds;
}
