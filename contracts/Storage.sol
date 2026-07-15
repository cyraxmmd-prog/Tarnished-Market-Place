// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/**
 * @title Storage
 * @author Mohammad Hossein Ghiasvand
 * @notice Abstract contract that defines state variables, structs, enums, and custom errors.
 */
abstract contract Storage {

    ////////////////////////////////////////////////////////////////
    // CUSTOM ENUMS
    ////////////////////////////////////////////////////////////////

    enum ListingStatus {
        Void,      // 0
        Active,    // 1
        Sold,      // 2
        Canceled   // 3
    }

    ////////////////////////////////////////////////////////////////
    // CUSTOM STRUCTS
    ////////////////////////////////////////////////////////////////

    struct Listing {
        address seller;
        ListingStatus status;
        address nftAddress;
        uint256 tokenId;
        uint256 price;
    }

    ////////////////////////////////////////////////////////////////
    // STATE VARIABLES
    ////////////////////////////////////////////////////////////////

    uint256 public constant MAX_FEE_BPS = 1000;
    uint256 public constant BPS_DENOMINATOR = 10000;

    uint256 public nextListingId;
    uint256 public platformFeeBps;
    address public feeRecipient;
    uint256 public accumulatedFees;

    mapping(uint256 => Listing) public listings;

    ////////////////////////////////////////////////////////////////
    // CUSTOM ERRORS (Gas Optimized)
    ////////////////////////////////////////////////////////////////

    error InvalidPrice();
    error InvalidAddress();
    error FeeExceedsLimit();
    error ZeroFeesToWithdraw();

    error ListingNotActive(uint256 listingId);
    error ListingAlreadyExists(address nftAddress, uint256 tokenId);
    
    error NotSeller(address caller);
    error NotNFTOwner(address nftAddress, uint256 tokenId, address actualOwner);
    error MarketplaceNotApproved(address nftAddress, uint256 tokenId);

    error ETHTransferFailed();
    error InsufficientFunds(uint256 sent, uint256 required);
}