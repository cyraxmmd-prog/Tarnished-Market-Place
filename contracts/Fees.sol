// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Events} from "./Events.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Modifiers} from "./Modifiers.sol";

abstract contract Fees is Events, Ownable, Modifiers {
    uint256 public platformFeeBps;
    address public feeRecipient;

    constructor(address initialOwner, uint256 initialPlatformFeeBps, address initialFeeRecipient) Ownable(initialOwner) {
        if (initialFeeRecipient == address(0)) revert InvalidAddress();
        if (initialPlatformFeeBps > MAX_FEE_BPS) revert FeeExceedsLimit();
        platformFeeBps = initialPlatformFeeBps;
        feeRecipient = initialFeeRecipient;
    }

    function updatePlatformFee(uint256 newPlatformFeeBps) external onlyOwner {
        if (newPlatformFeeBps > MAX_FEE_BPS) revert FeeExceedsLimit();
        uint256 oldFee = platformFeeBps;
        platformFeeBps = newPlatformFeeBps;
        emit FeeUpdated(oldFee, newPlatformFeeBps);
    }

    function updateFeeRecipient(address newFeeRecipient) external onlyOwner {
        if (newFeeRecipient == address(0)) revert InvalidAddress();
        feeRecipient = newFeeRecipient;
    }
}
