// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Storage} from "./Storage.sol";
import {Events} from "./Events.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

abstract contract Modifiers is Storage, Events {
    uint256 constant MAX_FEE_BPS = 1000;

    modifier isListingActive(uint256 listingId) {
        if (listings[listingId].status != ListingStatus.Active) {
            revert OfferDoesNotExist(); // یا هر ارور مناسب دیگر
        }
        _;
    }

    modifier onlyNFTOwner(address nftAddress, uint256 tokenId) {
        address actualOwner = IERC721(nftAddress).ownerOf(tokenId);
        if (actualOwner != msg.sender) {
            revert NotSeller(msg.sender);
        }
        _;
    }

    modifier isMarketplaceApproved(address nftAddress, uint256 tokenId) {
        address owner = IERC721(nftAddress).ownerOf(tokenId);
        bool isApproved = IERC721(nftAddress).getApproved(tokenId) == address(this);
        bool isOperator = IERC721(nftAddress).isApprovedForAll(owner, address(this));
        if (!isApproved && !isOperator) {
            revert InvalidAddress();
        }
        _;
    }
}
