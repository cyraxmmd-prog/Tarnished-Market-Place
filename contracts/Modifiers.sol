// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Storage} from "./Storage.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

/**
 * @title Modifiers
 * @author Mohammad Hossein Ghiasvand
 * @notice Abstract contract providing gas-optimized modifiers for security and validation.
 */
abstract contract Modifiers is Storage {

    ////////////////////////////////////////////////////////////////
    // MODIFIERS
    ////////////////////////////////////////////////////////////////

    modifier onlySeller(uint256 listingId) {
        if (listings[listingId].seller != msg.sender) {
            revert NotSeller(msg.sender);
        }
        _;
    }

    modifier isListingActive(uint256 listingId) {
        if (listings[listingId].status != ListingStatus.Active) {
            revert ListingNotActive(listingId);
        }
        _;
    }

    modifier onlyNFTOwner(address nftAddress, uint256 tokenId) {
        address actualOwner = IERC721(nftAddress).ownerOf(tokenId);
        if (actualOwner != msg.sender) {
            revert NotNFTOwner(nftAddress, tokenId, actualOwner);
        }
        _;
    }

    modifier isMarketplaceApproved(address nftAddress, uint256 tokenId) {
        address owner = IERC721(nftAddress).ownerOf(tokenId);
        
        bool isApproved = IERC721(nftAddress).getApproved(tokenId) == address(this);
        bool isOperator = IERC721(nftAddress).isApprovedForAll(owner, address(this));
        
        if (!isApproved && !isOperator) {
            revert MarketplaceNotApproved(nftAddress, tokenId);
        }
        _;
    }

    modifier preventDuplicateListing(address nftAddress, uint256 tokenId) {
        // Core duplicate listings validation logic for further versions
        _;
    }
}