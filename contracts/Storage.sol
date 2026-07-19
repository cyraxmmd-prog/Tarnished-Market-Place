// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

abstract contract Storage {
    enum ListingStatus { Active, Sold, Canceled }

    struct Listing {
        address seller;
        ListingStatus status;
        address nftAddress;
        uint256 tokenId;
        uint256 price;
    }

    uint256 public nextListingId;
    mapping(uint256 => Listing) public listings;
    uint256 constant BPS_DENOMINATOR = 10000;
}
