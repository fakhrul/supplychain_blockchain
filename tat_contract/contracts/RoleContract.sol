pragma solidity ^0.7.4;

contract RoleContract {
    struct Role {
        bytes32 roleId;
        string name;
        bool isActive;
        string customJsonData;
    }

    mapping(bytes32 => Role) public roleMap;
    bytes32[] public roleIds;

    event RoleCreated(bytes32 objId);
    event RoleUpdated(bytes32 objId);

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

}
