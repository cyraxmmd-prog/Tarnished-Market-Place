// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Fees} from "./Fees.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

/**
 * @title Admin
 * @author Mohammad Hossein Ghiasvand
 * @notice Abstract contract providing emergency pausing capabilities for the marketplace.
 * @dev Inherits Fees to complete the linear inheritance chain and integrates OZ Pausable.
 */
abstract contract Admin is Fees, Pausable {

    ////////////////////////////////////////////////////////////////
    // CONSTRUCTOR
    ////////////////////////////////////////////////////////////////

    /**
     * @dev Passes initialization parameters down to the Fees (and subsequently Ownable) constructor.
     */
    constructor(
        address initialOwner,
        uint256 initialPlatformFeeBps,
        address initialFeeRecipient
    ) Fees(initialOwner, initialPlatformFeeBps, initialFeeRecipient) {}

    ////////////////////////////////////////////////////////////////
    // EMERGENCY CONTROL FUNCTIONS
    ////////////////////////////////////////////////////////////////

    /**
     * @notice Triggers emergency stop, halting listings and purchasing functions.
     * @dev Restricted to the contract owner.
     */
    function pauseMarketplace() external onlyOwner {
        _pause();
    }

    /**
     * @notice Lifts emergency stop, resuming standard marketplace operations.
     * @dev Restricted to the contract owner.
     */
    function unpauseMarketplace() external onlyOwner {
        _unpause();
    }
}