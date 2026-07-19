// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

abstract contract Events {
    error InvalidPrice();
    error InvalidAddress();
    error ListingAlreadyExists(address nftAddress, uint256 tokenId);
    error OfferAlreadyExists();
    error OfferDoesNotExist();
    error ETHTransferFailed();
    error InsufficientFunds(uint256 available, uint256 required);
    error NotSeller(address sender);
    error ZeroFeesToWithdraw();
    error FeeExceedsLimit();

    event ItemListed(address indexed seller, address indexed nftAddress, uint256 indexed tokenId, uint256 listingId, uint256 price);
    event ListingCanceled(address indexed seller, address indexed nftAddress, uint256 indexed tokenId, uint256 listingId);
    event ListingPriceUpdated(address indexed seller, address indexed nftAddress, uint256 indexed tokenId, uint256 listingId, uint256 newPrice);
    event ItemSold(address indexed buyer, address indexed seller, address indexed nftAddress, uint256 tokenId, uint256 listingId, uint256 price, uint256 fee);
    event FeeUpdated(uint256 oldFee, uint256 newFee);
    event FeesWithdrawn(address indexed recipient, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
    event OfferMade(address indexed offerer, address indexed nftAddress, uint256 indexed tokenId, uint256 price);
    event OfferCancelled(address indexed offerer, address indexed nftAddress, uint256 indexed tokenId);
    event OfferAccepted(address indexed seller, address indexed offerer, address indexed nftAddress, uint256 tokenId, uint256 price);
}
