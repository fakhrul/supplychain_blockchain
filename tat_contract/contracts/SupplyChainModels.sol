pragma solidity ^0.7.4;

contract SupplyChainModels {
    // Struct definition
    struct OrganizationType {
        bytes32 organizationTypeId;
        string name;
        bool isActive;
        string customJsonData;
    }
    struct Organization {
        bytes32 organizationId;
        string name;
        bytes32[] organizationTypeIdList;
        string organizationAddress;
        bool isActive;
        string customJsonData;
    }

    struct Activity {
        bytes32 activityId;
        string name;
        bytes32 organizationTypeId;
        bool isActive;
        string customJsonData;
    }

    struct Area {
        bytes32 areaId;
        string name;
        bytes32 organizationId;
        bool isActive;
        string customJsonData;
    }

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

    struct Role {
        bytes32 roleId;
        string name;
    }

    struct Profile {
        bytes32 profieId;
        string name;
        string email;
        string passwordHash;
        string phone;
        bytes32[] roleId;
        bytes32 organizationId;
    }

    struct Certification {
        bytes32 certificationId;
        string name;
        string certificateUrl;
    }

    struct TrackHistory {
        bytes32 trackHistoryId;
        bytes32 productId;
        bytes32 activityid;
        bytes32 profileId;
        bytes32 areaId;
        string gps;
        string remarks;
    }

    mapping(bytes32 => Organization) public organizationMap;
    mapping(bytes32 => OrganizationType) public organizationTypeMap;
    mapping(bytes32 => Activity) public activityMap;
    mapping(bytes32 => Area) public areaMap;
    mapping(bytes32 => Category) public categoryMap;
    mapping(bytes32 => Product) public productMap;
    mapping(bytes32 => Role) public roleMap;
    mapping(bytes32 => Profile) public profileMap;
    mapping(bytes32 => Certification) public certificationMap;
    mapping(bytes32 => TrackHistory) public trackHistoryMap;

    bytes32[] public organizationIds;
    bytes32[] public organizationTypeIds;
    bytes32[] public activityIds;
    bytes32[] public areaIds;
    bytes32[] public categoryIds;
    bytes32[] public productIds;
    bytes32[] public roleIds;
    bytes32[] public certificationIds;
    bytes32[] public trackHistoryIds;
}
