pragma solidity ^0.7.4;

contract ProfileContract {
    uint256 public version = 1;
    struct Profile {
        bytes32 profileId;
        string name;
        string email;
        string passwordHash;
        string phone;
        bytes32[] roleId;
        bytes32 organizationId;
        bool isActive;
        string customJsonData;
    }

    mapping(bytes32 => Profile) public dataMap;
    mapping(string => bytes32) public emailMap;

    bytes32[] public dataList;

    event Created(bytes32 objId);
    event Updated(bytes32 objId);

    function create(
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

        Profile storage obj = dataMap[newId];
        obj.profileId = newId;
        obj.name = _name;
        obj.email = _email;
        obj.passwordHash = _passwordHash;
        obj.phone = _phone;
        obj.roleId = _roleId;
        obj.organizationId = _organizationId;
        obj.isActive = true;
        obj.customJsonData = _customJsonData;

        emailMap[_email] = newId;
        dataList.push(newId);

        emit Created(newId);
        return (newId);
    }

    function update(
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
        Profile storage obj = dataMap[objId];
        obj.name = _name;
        obj.email = _email;
        obj.passwordHash = _passwordHash;
        obj.phone = _phone;
        obj.roleId = _roleId;
        obj.organizationId = _organizationId;
        obj.isActive = _isActive;
        obj.customJsonData = _customJsonData;

        emit Updated(objId);
    }

    function getById(bytes32 objId)
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
        Profile storage obj = dataMap[objId];
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

    function getAll() public view returns (bytes32[] memory ids) {
        return (dataList);
    }

    function activate(bytes32 objId, bool _isActive) public {
        dataMap[objId].isActive = _isActive;
        emit Updated(objId);
    }
}
