// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Events} from "./Events.sol";
import {Modifiers} from "./Modifiers.sol";

abstract contract MarketplaceOffers is Events, Modifiers {
    struct Offer {
        address offerer;
        uint256 price;
        bool active;
    }
    mapping(address => mapping(uint256 => mapping(address => Offer))) public offers;

    function makeOffer(address nftAddress, uint256 tokenId, uint256 price) external payable {
        if (price == 0 || msg.value != price) revert InvalidPrice();
        if (nftAddress == address(0)) revert InvalidAddress();
        
        Offer storage offer = offers[nftAddress][tokenId][msg.sender];
        if (offer.active) revert OfferAlreadyExists();
        
        offer.offerer = msg.sender;
        offer.price = price;
        offer.active = true;
        
        emit OfferMade(msg.sender, nftAddress, tokenId, price);
    }

    function cancelOffer(address nftAddress, uint256 tokenId) external {
        Offer storage offer = offers[nftAddress][tokenId][msg.sender];
        if (!offer.active) revert OfferDoesNotExist();
        
        uint256 price = offer.price;
        offer.active = false;
        
        (bool success, ) = payable(msg.sender).call{value: price}("");
        if (!success) revert ETHTransferFailed();
        
        emit OfferCancelled(msg.sender, nftAddress, tokenId);
    }
}