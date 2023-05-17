// SPDX-License-Identifier: MIT

import "./EchidnaSetup.sol";
import "./EchidnaHelper.sol";
import "./EchidnaDebug.sol";
import "./Debugger.sol";
import "./Tools.sol";

contract EchidnaTest is EchidnaSetup, EchidnaHelper, EchidnaDebug {
    function testAddToList(uint256 listId, address[] memory items) public {
        uint256 listCountBefore = registry.getListCount();
        addToList(listId, items);
        uint256 listCountAfter = registry.getListCount();

        if (items.length == 0) {
            assert(listCountAfter == listCountBefore);
        } else if (registry.areAllInList(listId, items)) {
            assert(listCountAfter == listCountBefore);
        } else {
            assert(listCountAfter > listCountBefore);
        }
    }

    function testRemoveFromList(uint256 listId, address[] memory items) public {
        uint256 listCountBefore = registry.getListCount();
        removeFromList(listId, items);
        uint256 listCountAfter = registry.getListCount();

        if (items.length == 0) {
            assert(listCountAfter == listCountBefore);
        } else if (registry.areAllNotInList(listId, items)) {
            assert(listCountAfter == listCountBefore);
        } else {
            assert(listCountAfter < listCountBefore);
        }
    }

    function testCreateList(
        uint8 _listType,
        address[] memory _initialData,
        bool startEmpty
    ) public {
        uint256 listId = registry.getListCount();

        uint256 listCountBefore = registry.getListCount();
        createList(_listType, _initialData, startEmpty);
        uint256 listCountAfter = registry.getListCount();

        assert(listCountAfter == listCountBefore + 1);
        assert(_getListType(_listType) == registry.getListUpdateType(listId));

        if (!startEmpty) {
            for (uint256 i = 0; i < _initialData.length; i++) {
                assert(registry.isInList(listId, _initialData[i]));
            }
            assert(registry.areAllInList(listId, _initialData));
        }
    }

    function testCreateListShouldNotRevert(
        uint8 _listType,
        address[] memory _initialData,
        bool startEmpty
    ) public {
        require(registry.getListCount() < 10, "Too many lists");

        AddressListRegistry.UpdateType listType = _getListType(_listType % 4);
        address[] memory initialData = startEmpty
            ? new address[](0)
            : _initialData;

        try registry.createList(address(this), listType, initialData) {
            assert(true);
        } catch {
            assert(false);
        }
    }

    function testViewFunctions(uint256 listId, address[] memory items) public {
        uint256[] memory listIds = new uint256[](1);
        listIds[0] = listId;

        if (registry.areAllInList(listId, items)) {
            for (uint256 i = 0; i < items.length; i++) {
                assert(registry.isInAllLists(listIds, items[i]));
            }

            assert(registry.areAllInAllLists(listIds, items));
            assert(registry.areAllInSomeOfLists(listIds, items));
        } else if (registry.areAllInSomeOfLists(listIds, items)) {
            for (uint256 i = 0; i < items.length; i++) {
                assert(registry.isInSomeOfLists(listIds, items[i]));
            }
        } else {
            registry.areAllNotInList(listId, items);
            registry.areAllNotInAnyOfLists(listIds, items);
        }
    }
}
