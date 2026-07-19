// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Fees} from "./Fees.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

abstract contract Admin is Fees, Pausable {
    constructor(address initialOwner, uint256 initialPlatformFeeBps, address initialFeeRecipient) 
        Fees(initialOwner, initialPlatformFeeBps, initialFeeRecipient) {}

    function pauseMarketplace() external onlyOwner { _pause(); }
    function unpauseMarketplace() external onlyOwner { _unpause(); }
}
