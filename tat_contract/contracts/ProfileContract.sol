pragma solidity ^0.7.4;

contract ProfileContract {
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

    mapping(bytes32 => Profile) public profileMap;
    bytes32[] public profileIds;

    event ProfileCreated(bytes32 objId);
    event ProfileUpdated(bytes32 objId);

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


}
