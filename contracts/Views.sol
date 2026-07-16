// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Admin} from "./Admin.sol";

/**
 * @title Views
 * @author Mohammad Hossein Ghiasvand
 * @notice Abstract contract that centralizes all read-only (view) functions for the marketplace.
 * @dev Inherits Admin to complete the linear inheritance chain and access the database.
 */
abstract contract Views is Admin {

    ////////////////////////////////////////////////////////////////
    // VIEW FUNCTIONS (Version 1 Core)
    ////////////////////////////////////////////////////////////////

    /**
     * @notice Retrieves the full details of a specific listing.
     * @param listingId The unique identifier of the listing.
     * @return Listing struct containing seller, status, nftAddress, tokenId, and price.
     */
    function getListing(uint256 listingId) external view returns (Listing memory) {
        return listings[listingId];
    }

    /**
     * @notice Checks if a listing is currently active and available for purchase.
     * @param listingId The unique identifier of the listing.
     * @return True if the listing status is Active, false otherwise.
     */
    function isListingActiveState(uint256 listingId) external view returns (bool) {
        return listings[listingId].status == ListingStatus.Active;
    }

    /**
     * @notice Returns the current marketplace fee in basis points.
     * @return The platform fee percentage (e.g., 250 represents 2.5%).
     */
    function getPlatformFeeBps() external view returns (uint256) {
        return platformFeeBps;
    }

    /**
     * @notice Returns the address designated to receive marketplace fees.
     * @return The address of the fee recipient.
     */
    function getFeeRecipient() external view returns (address) {
        return feeRecipient;
    }

    /**
     * @notice Returns the total accumulated native fees currently pending withdrawal.
     * @return The accumulated fees in Wei.
     */
    function getAccumulatedFees() external view returns (uint256) {
        return accumulatedFees;
    }

    ////////////////////////////////////////////////////////////////
    // ADVANCED BATCHING VIEWS (Optimized for Frontend Integration)
    ////////////////////////////////////////////////////////////////

    /**
     * @notice Fetches multiple listings in a single RPC call to optimize frontend rendering.
     * @dev Designed to avoid multiple sequential contract calls from Ethers.js / Web3.js.
     * @param listingIds An array of unique listing identifiers to query.
     * @return An array of Listing structs matching the queried IDs.
     */
    function getListingBatch(uint256[] calldata listingIds) external view returns (Listing[] memory) {
        uint256 length = listingIds.length;
        Listing[] memory batchListings = new Listing[](length);

        for (uint256 i = 0; i < length; ) {
            batchListings[i] = listings[listingIds[i]];
            
            // Unchecked block for gas-efficient array iteration (safe from overflow)
            unchecked {
                ++i;
            }
        }
        
        return batchListings;
    }
}