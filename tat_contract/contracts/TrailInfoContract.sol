pragma solidity ^0.7.4;

contract TrailInfoContract {
    struct TrailInfo {
        bytes32 trackHistoryId;
        bytes32 productId;
        bytes32 activityId;
        bytes32 profileId;
        bytes32 areaId;
        string gps;
        string remarks;
        bool isActive;
        string customJsonData;
        uint createdDate;
    }
    
    struct ProductTrail {
        bytes32 productId;
        mapping(bytes32 => TrailInfo)  trailInfoMap;
        bytes32[] trailInfoList;
    }

    mapping(bytes32 => ProductTrail)  productTrailMap;
    bytes32[] public productTrailList;

    event Created(bytes32 objId);
    event Updated(bytes32 objId);

    function isProductExist(bytes32 productId)
        private returns(bool result)
    {
        for(uint i = 0; i < productTrailList.length; i++) {
            bytes32 product = productTrailList[i];
            if(product == productId){
                return true;
            }
        }
        return false;
    }

    function addProductTrail(
        bytes32 _productId,
        bytes32 _activityId,
        bytes32 _profileId,
        bytes32 _areaId,
        string memory _gps,
        string memory _remarks,
        string memory _customJsonData
        
    ) public returns (bytes32 objId) {
        
        ProductTrail storage productTrail = productTrailMap[_productId];
        productTrail.productId = _productId;
        
        if(isProductExist(_productId) == false){
            productTrailList.push(_productId);
        }
        
        bytes32 trailId = keccak256(abi.encodePacked(block.timestamp, block.difficulty));
        TrailInfo storage trailInfo = productTrailMap[_productId].trailInfoMap[trailId];
        trailInfo.trackHistoryId = trailId;
        trailInfo.productId = _productId;
        trailInfo.activityId = _activityId;
        trailInfo.profileId = _profileId;
        trailInfo.areaId = _areaId;
        trailInfo.gps = _gps;
        trailInfo.remarks = _remarks;
        trailInfo.isActive = true;
        trailInfo.customJsonData = _customJsonData;
        trailInfo.createdDate = block.timestamp;
        
        productTrailMap[_productId].trailInfoList.push(trailId);

        emit Created(trailId);
        return trailId;
    }

    function getProductList() public view returns (bytes32[] memory productList)
    {
        return (productTrailList);
    }

    function getProductTrailList(bytes32  _productId)
        public
        view
        returns (bytes32[] memory productTrailList)
    {
        return (productTrailMap[_productId].trailInfoList);
    }

    function getProductTrail(bytes32  _productId, bytes32  _trailId)
        public
        view
        returns (bytes32 productId,
                bytes32 activityId,
                bytes32 profileId,
                bytes32 areaId,
                string memory gps,
                string memory remarks,
                bool  isActive,
                string memory customJsonData,
                uint createdDate)
    {
        TrailInfo storage obj = productTrailMap[_productId].trailInfoMap[_trailId];
        return (
            obj.productId,
            obj.activityId,
            obj.profileId,
            obj.areaId,
            obj.gps,
            obj.remarks,
            obj.isActive,
            obj.customJsonData,
            obj.createdDate
            );
    }

}
