// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

interface IMarketplace {
    struct Listing {
        address seller;
        uint8 status; // ListingStatus
        address nftAddress;
        uint256 tokenId;
        uint256 price;
    }

    struct Offer {
        address offerer;
        uint256 price;
        bool active;
    }

    event ItemListed(address indexed seller, address indexed nftAddress, uint256 indexed tokenId, uint256 listingId, uint256 price);
    event ItemSold(address indexed buyer, address indexed seller, address indexed nftAddress, uint256 tokenId, uint256 listingId, uint256 price, uint256 fee);
    event OfferMade(address indexed offerer, address indexed nftAddress, uint256 indexed tokenId, uint256 price);
    event OfferAccepted(address indexed seller, address indexed offerer, address indexed nftAddress, uint256 tokenId, uint256 price);

    function listNFT(address nftAddress, uint256 tokenId, uint256 price) external;
    function buyNFT(uint256 listingId) external payable;
    function makeOffer(address nftAddress, uint256 tokenId, uint256 price) external payable;
    function acceptOffer(address nftAddress, uint256 tokenId, address offerer) external;
    function cancelOffer(address nftAddress, uint256 tokenId) external;
    function withdraw() external;
    function getListing(uint256 listingId) external view returns (Listing memory);
}