// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Modifiers} from "./Modifiers.sol";
import {Events} from "./Events.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Fees
 * @author Mohammad Hossein Ghiasvand
 * @notice Abstract contract managing platform fees, fee recipients, and secure withdrawals.
 * @dev Inherits Modifiers and Events, and integrates OpenZeppelin's Ownable for governance.
 */
abstract contract Fees is Modifiers, Events, Ownable {

    ////////////////////////////////////////////////////////////////
    // CONSTRUCTOR
    ////////////////////////////////////////////////////////////////

    /**
     * @param initialOwner The address designated as the contract owner.
     * @param initialPlatformFeeBps The initial marketplace fee in basis points (e.g., 250 for 2.5%).
     * @param initialFeeRecipient The wallet authorized to collect and withdraw platform revenue.
     */
    constructor(
        address initialOwner,
        uint256 initialPlatformFeeBps,
        address initialFeeRecipient
    ) Ownable(initialOwner) {
        if (initialFeeRecipient == address(0)) revert InvalidAddress();
        if (initialPlatformFeeBps > MAX_FEE_BPS) revert FeeExceedsLimit();

        platformFeeBps = initialPlatformFeeBps;
        feeRecipient = initialFeeRecipient;
    }

    ////////////////////////////////////////////////////////////////
    // ADMIN FINANCIAL FUNCTIONS
    ////////////////////////////////////////////////////////////////

    /**
     * @notice Updates the platform fee percentage.
     * @dev Restricted to the contract owner. Fee cannot exceed 10% (MAX_FEE_BPS).
     * @param newPlatformFeeBps The new fee in basis points.
     */
    function updatePlatformFee(uint256 newPlatformFeeBps) external onlyOwner {
        if (newPlatformFeeBps > MAX_FEE_BPS) revert FeeExceedsLimit();
        
        uint256 oldFee = platformFeeBps;
        platformFeeBps = newPlatformFeeBps;

        emit FeeUpdated(oldFee, newPlatformFeeBps);
    }

    /**
     * @notice Updates the destination address for collected platform fees.
     * @dev Restricted to the contract owner.
     * @param newFeeRecipient The new address to receive platform revenue.
     */
    function updateFeeRecipient(address newFeeRecipient) external onlyOwner {
        if (newFeeRecipient == address(0)) revert InvalidAddress();
        feeRecipient = newFeeRecipient;
    }

    /**
     * @notice Safely withdraws all accumulated platform fees to the designated recipient.
     * @dev Can be triggered by the owner or the recipient. Prevents reentrancy implicitly.
     */
    function withdrawAccumulatedFees() external {
        if (msg.sender != owner() && msg.sender != feeRecipient) {
            revert NotSeller(msg.sender); // Reusing gas-optimized auth errors
        }

        uint256 balanceToWithdraw = accumulatedFees;
        if (balanceToWithdraw == 0) revert ZeroFeesToWithdraw();

        // State update before external transfer (Checks-Effects-Interactions)
        accumulatedFees = 0;

        (bool success, ) = payable(feeRecipient).call{value: balanceToWithdraw}("");
        if (!success) revert ETHTransferFailed();

        emit FeesWithdrawn(feeRecipient, balanceToWithdraw);
    }
}