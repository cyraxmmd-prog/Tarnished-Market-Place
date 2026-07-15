// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/**
 * @title Events
 * @author Mohammad Hossein Ghiasvand
 * @notice Abstract contract containing all events for the Tarnished Marketplace.
 */
abstract contract Events {

    ////////////////////////////////////////////////////////////////
    // VERSION 1 EVENTS: CORE LISTINGS & FEE MANAGEMENT
    ////////////////////////////////////////////////////////////////

    event ItemListed(
        address indexed seller,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 listingId,
        uint256 price
    );

    event ItemSold(
        address indexed buyer,
        address indexed seller,
        address indexed nftAddress,
        uint256 tokenId,
        uint256 listingId,
        uint256 price,
        uint256 fee
    );

    event ListingCanceled(
        address indexed seller,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 listingId
    );

    event ListingPriceUpdated(
        address indexed seller,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 listingId,
        uint256 newPrice
    );

    event FeeUpdated(uint256 oldFee, uint256 newFee);

    event FeesWithdrawn(address indexed recipient, uint256 amount);

    ////////////////////////////////////////////////////////////////
    // VERSION 2 EVENTS: OFFERS SYSTEM
    ////////////////////////////////////////////////////////////////

    event OfferCreated(
        address indexed offeror,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 offerId,
        uint256 price,
        uint256 expiration
    );

    event OfferCanceled(
        address indexed offeror,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 offerId
    );

    event OfferAccepted(
        address indexed seller,
        address indexed offeror,
        address indexed nftAddress,
        uint256 tokenId,
        uint256 offerId,
        uint256 price,
        uint256 fee
    );

    event OfferRejected(
        address indexed seller,
        address indexed offeror,
        address indexed nftAddress,
        uint256 tokenId,
        uint256 offerId
    );

    ////////////////////////////////////////////////////////////////
    // VERSION 3 EVENTS: ENGLISH AUCTIONS
    ////////////////////////////////////////////////////////////////

    event AuctionCreated(
        address indexed seller,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 auctionId,
        uint256 minBid,
        uint256 startTime,
        uint256 endTime
    );

    event BidPlaced(address indexed bidder, uint256 indexed auctionId, uint256 amount);

    event BidRefunded(address indexed bidder, uint256 indexed auctionId, uint256 amount);

    event AuctionFinalized(
        address indexed winner,
        address indexed seller,
        address indexed nftAddress,
        uint256 tokenId,
        uint256 auctionId,
        uint256 winningBid,
        uint256 fee
    );

    event AuctionCanceled(address indexed seller, uint256 indexed auctionId);

    ////////////////////////////////////////////////////////////////
    // VERSION 4 EVENTS: NFT RENTALS
    ////////////////////////////////////////////////////////////////

    event NFTRented(
        address indexed renter,
        address indexed lessor,
        address indexed nftAddress,
        uint256 tokenId,
        uint256 rentalId,
        uint256 fee,
        uint256 expiresAt
    );

    event NFTReturned(
        address indexed renter,
        address indexed lessor,
        address indexed nftAddress,
        uint256 tokenId,
        uint256 rentalId
    );

    ////////////////////////////////////////////////////////////////
    // VERSION 5 EVENTS: BUNDLE LISTINGS
    ////////////////////////////////////////////////////////////////

    event BundleListed(
        address indexed seller,
        uint256 indexed bundleId,
        address[] nftAddresses,
        uint256[] tokenIds,
        uint256 price
    );

    event BundleSold(
        address indexed buyer,
        address indexed seller,
        uint256 indexed bundleId,
        uint256 price,
        uint256 fee
    );

    event BundleCanceled(address indexed seller, uint256 indexed bundleId);

    ////////////////////////////////////////////////////////////////
    // VERSION 6 EVENTS: COLLECTION VERIFICATION / REGISTRY
    ////////////////////////////////////////////////////////////////

    event CollectionStatusUpdated(address indexed nftAddress, bool indexed isApproved);
}