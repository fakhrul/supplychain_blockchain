pragma solidity ^0.7.4;

contract TrackHistoryContract {
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

    mapping(bytes32 => TrackHistory) public dataMap;
    bytes32[] public dataList;

    event Created(bytes32 objId);
    event Updated(bytes32 objId);

    function create(
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

        TrackHistory storage obj = dataMap[newId];
        obj.trackHistoryId = newId;
        obj.productId = _productId;
        obj.activityId = _activityId;
        obj.profileId = _profileId;
        obj.areaId = _areaId;
        obj.gps = _gps;
        obj.remarks = _remarks;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        dataList.push(newId);

        emit Created(newId);
        return (newId);
    }

    function update(
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
        TrackHistory storage obj = dataMap[objId];
        obj.productId = _productId;
        obj.activityId = _activityId;
        obj.profileId = _profileId;
        obj.productId = _productId;
        obj.areaId = _areaId;
        obj.gps = _gps;
        obj.remarks = _remarks;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit Updated(objId);
    }

    function getById(bytes32 objId)
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
        TrackHistory storage obj = dataMap[objId];
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

    function getAll() public view returns (bytes32[] memory ids) {
        return (dataList);
    }

    function activate(bytes32 objId, bool _isActive) public {
        dataMap[objId].isActive = _isActive;
        emit Updated(objId);
    }
}
