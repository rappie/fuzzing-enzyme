// SPDX-License-Identifier: MIT

import "./EchidnaHelper.sol";
import "./Debugger.sol";

contract EchidnaDebug is EchidnaHelper {
    // bool debug = true;
    bool debug = false;

    function testListCount() public {
        require(debug);
        Debugger.log("list count", registry.getListCount());
        assert(registry.getListCount() < 5);
    }

}
