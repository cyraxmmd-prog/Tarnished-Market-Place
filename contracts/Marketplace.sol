// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Views} from "./Views.sol";
import {Admin} from "./Admin.sol";
import {MarketplaceOffers} from "./MarketplaceOffers.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC2981} from "@openzeppelin/contracts/interfaces/IERC2981.sol";
import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

contract Marketplace is Views, ReentrancyGuard, Admin, MarketplaceOffers {
    mapping(address => mapping(uint256 => uint256)) private _activeListings;
    mapping(address => uint256) public pendingWithdrawals;

    constructor(address initialOwner, uint256 initialPlatformFeeBps, address initialFeeRecipient) 
        Admin(initialOwner, initialPlatformFeeBps, initialFeeRecipient) {}

    function listNFT(address nftAddress, uint256 tokenId, uint256 price) external whenNotPaused onlyNFTOwner(nftAddress, tokenId) isMarketplaceApproved(nftAddress, tokenId) {
        if (price == 0) revert InvalidPrice();
        uint256 listingId = ++nextListingId;
        listings[listingId] = Listing(msg.sender, ListingStatus.Active, nftAddress, tokenId, price);
        _activeListings[nftAddress][tokenId] = listingId;
        emit ItemListed(msg.sender, nftAddress, tokenId, listingId, price);
    }

    function buyNFT(uint256 listingId) external payable nonReentrant whenNotPaused isListingActive(listingId) {
        Listing storage listing = listings[listingId];
        if (msg.value < listing.price) revert InsufficientFunds(msg.value, listing.price);
        
        listing.status = ListingStatus.Sold;
        _activeListings[listing.nftAddress][listing.tokenId] = 0;

        uint256 fee = (listing.price * platformFeeBps) / BPS_DENOMINATOR;
        uint256 sellerProceeds = listing.price - fee;
        
        pendingWithdrawals[feeRecipient] += fee;
        pendingWithdrawals[listing.seller] += sellerProceeds;

        if (msg.value > listing.price) {
            (bool s, ) = payable(msg.sender).call{value: msg.value - listing.price}("");
            if (!s) revert ETHTransferFailed();
        }
        IERC721(listing.nftAddress).safeTransferFrom(listing.seller, msg.sender, listing.tokenId);
        emit ItemSold(msg.sender, listing.seller, listing.nftAddress, listing.tokenId, listingId, listing.price, fee);
    }

    function acceptOffer(address nftAddress, uint256 tokenId, address offerer) external nonReentrant whenNotPaused onlyNFTOwner(nftAddress, tokenId) isMarketplaceApproved(nftAddress, tokenId) {
        Offer storage offer = offers[nftAddress][tokenId][offerer];
        if (!offer.active) revert OfferDoesNotExist();
        offer.active = false;
        
        pendingWithdrawals[msg.sender] += offer.price;
        
        IERC721(nftAddress).safeTransferFrom(msg.sender, offerer, tokenId);
        emit OfferAccepted(msg.sender, offerer, nftAddress, tokenId, offer.price);
    }

    function withdraw() external nonReentrant {
        uint256 amount = pendingWithdrawals[msg.sender];
        if (amount == 0) revert("No funds");
        pendingWithdrawals[msg.sender] = 0;
        (bool s, ) = payable(msg.sender).call{value: amount}("");
        if (!s) revert ETHTransferFailed();
        emit Withdraw(msg.sender, amount);
    }
}