// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Storage} from "./Storage.sol";

abstract contract Views is Storage {
    function getListing(uint256 listingId) external view returns (Listing memory) {
        return listings[listingId];
    }
}
