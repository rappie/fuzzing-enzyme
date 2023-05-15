// SPDX-License-Identifier: MIT

contract EchidnaConfig {
    address internal constant ADDRESS_DISPATCHER = address(0x10000);
        

    // function getAccount(uint256 id) internal pure returns (address) {
    //     if (id == 0) return ADDRESS_DEPLOYER;
    //     if (id == 1) return ADDRESS_ATTACKER0;
    //     if (id == 2) return ADDRESS_ATTACKER1;
    //     if (id == 3) return ADDRESS_VICTIM;

    //     require(false, "Unknown account ID");
    // }

    // function getAccountFromUint8(uint8 rawId) internal pure returns (address) {
    //     uint256 id = uint256(rawId) / 64;
    //     return getAccount(id);
    // }
}
