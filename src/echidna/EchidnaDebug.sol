// SPDX-License-Identifier: MIT

import "./EchidnaHelper.sol";
import "./Debugger.sol";

contract EchidnaDebug is EchidnaHelper {
    bool debug = true;

    // bool debug = false;

    function debugCreateList() public {
        registry.createList(
            address(this),
            AddressListRegistry.UpdateType.AddOnly,
            new address[](0)
        );

        Debugger.log("done");
        assert(false);
    }

    // function debugEchidna() public {
    //     require(debug);
    //     assert(false);
    // }
}
