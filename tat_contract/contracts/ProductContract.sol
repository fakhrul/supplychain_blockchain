pragma solidity ^0.7.4;

contract ProductContract {
    uint256 public version = 1;
    struct Product {
        bytes32 productId;
        bytes32 categoryId;
        string name;
        string description;
        bytes32[] certicationIdList;
        bool isActive;
        string customJsonData;
    }

    mapping(bytes32 => Product) public dataMap;
    bytes32[] public dataList;

    event Created(bytes32 objId);
    event Updated(bytes32 objId);

    function create(
        string memory _name,
        bytes32 _categoryId,
        string memory _description,
        bytes32[] memory _certificationIdList,
        string memory _customJsonData
    ) public returns (bytes32 objId) {
        bytes32 newId =
            keccak256(abi.encodePacked(block.timestamp, block.difficulty));

        Product storage obj = dataMap[newId];
        obj.productId = newId;
        obj.name = _name;
        obj.description = _description;
        obj.certicationIdList = _certificationIdList;
        obj.categoryId = _categoryId;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        dataList.push(newId);

        emit Created(newId);
        return (newId);
    }

    function update(
        bytes32 objId,
        string memory _name,
        bytes32 _categoryId,
        string memory _description,
        bytes32[] memory _certificationIdList,
        string memory _customJsonData,
        bool _isActive
    ) public {
        Product storage obj = dataMap[objId];
        obj.name = _name;
        obj.categoryId = _categoryId;
        obj.description = _description;
        obj.certicationIdList = _certificationIdList;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit Updated(objId);
    }

    function getById(bytes32 objId)
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
        Product storage obj = dataMap[objId];
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

    function getAll() public view returns (bytes32[] memory ids) {
        return (dataList);
    }
}
