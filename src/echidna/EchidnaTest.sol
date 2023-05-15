// SPDX-License-Identifier: MIT

import "./EchidnaSetup.sol";
import "./EchidnaHelper.sol";
import "./EchidnaDebug.sol";
import "./Debugger.sol";
import "./Tools.sol";

contract EchidnaTest is EchidnaSetup, EchidnaHelper, EchidnaDebug {
    function testCreateList(
        address owner,
        uint8 _listType,
        address[] memory _initialData,
        bool startEmpty
    ) public {
        uint listId = registry.getListCount();

        uint256 listCountBefore = registry.getListCount();
        createList(owner, _listType, _initialData, startEmpty);
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
}
