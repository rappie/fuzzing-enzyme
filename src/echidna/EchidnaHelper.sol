// SPDX-License-Identifier: MIT

import "./EchidnaSetup.sol";

contract EchidnaHelper is EchidnaSetup {

    function addToList(uint256 listId, address[] memory items) public {
        listId = listId % registry.getListCount();
        registry.addToList(listId, items);
    }

    function removeFromList(uint256 listId, address[] memory items) public {
        listId = listId % registry.getListCount();
        registry.removeFromList(listId, items);
    }

    function createList(
        address owner,
        uint8 _listType,
        address[] memory _initialData,
        bool startEmpty
    ) public {
        AddressListRegistry.UpdateType listType = _getListType(_listType % 4);
        address[] memory initialData = startEmpty
            ? new address[](0)
            : _initialData;

        createList(owner, listType, initialData);
    }

    function createList(
        address owner,
        AddressListRegistry.UpdateType listType,
        address[] memory initialData
    ) internal {
        require(registry.getListCount() < 10, "Too many lists");
        registry.createList(owner, listType, initialData);
    }

    function _getListType(uint8 _listType)
        internal
        pure
        returns (AddressListRegistry.UpdateType)
    {
        if (_listType == 0) return AddressListRegistry.UpdateType.None;
        if (_listType == 1) return AddressListRegistry.UpdateType.AddOnly;
        if (_listType == 2) return AddressListRegistry.UpdateType.RemoveOnly;
        if (_listType == 3) return AddressListRegistry.UpdateType.AddAndRemove;

        require(false, "Unknown list type");
    }
}
