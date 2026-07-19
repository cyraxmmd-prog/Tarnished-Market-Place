

⚔️ Tarnished Marketplace

A decentralized NFT marketplace designed for hierarchical digital assets.

Tarnished Marketplace is a decentralized marketplace built specifically for ERC-721 Hierarchical NFTs. Unlike traditional NFT marketplaces that treat every NFT as an isolated asset, Tarnished Marketplace introduces a marketplace architecture capable of handling parent-child NFT relationships while remaining fully compatible with the Ethereum ecosystem.

The project was developed in Solidity using OpenZeppelin Contracts and deployed through Remix IDE on the Ethereum Sepolia network.


---

✨ Features

ERC-721 compatible marketplace

Fixed-price NFT listings

Buy listed NFTs securely

Cancel active listings

Update listing price

Marketplace fee support

Ownership verification

Event-driven architecture

Reentrancy protection

Pausable marketplace

Emergency administration

Full metadata compatibility (IPFS)

Support for hierarchical NFT collections



---

🏗 Marketplace Workflow

Owner
   │
   ▼
Approve Marketplace
   │
   ▼
Create Listing
   │
   ▼
Stored On-Chain
   │
   ▼
Buyer Purchases NFT
   │
   ▼
NFT Ownership Transferred
   │
   ▼
Seller Receives Payment


---

🌳 Hierarchical NFT Architecture

This marketplace is designed around a hierarchical NFT ecosystem.

Instead of existing independently, NFTs can be connected through verifiable parent-child relationships.

Example hierarchy:

Dragon Armor
│
├── Dragon Helmet
│
├── Dragon Sword
│      │
│      └── Dragon Moonlight Sword
│
└── Dragon Shield

Each child NFT stores references to its parent contract and parent token, enabling decentralized asset composition directly on-chain.


---

🔒 Security

The marketplace includes several security mechanisms:

ReentrancyGuard

Ownable access control

Pausable emergency stop

Input validation

Safe payment handling

Event logging

Ownership verification before listing



---

📂 Project Structure

contracts/
│
├── TarnishedMarketplace.sol
│
├── interfaces/
│
├── libraries/
│
└── utils/


---

📜 Marketplace Events

The marketplace emits events for every important action.

NFTListed

NFTPurchased

ListingCancelled

ListingPriceUpdated

MarketplaceFeeUpdated

MarketplacePaused

MarketplaceUnpaused

These events simplify indexing through applications such as The Graph or custom backend services.


---

⚙️ Technologies

Solidity

Ethereum

ERC-721

OpenZeppelin

Remix IDE

MetaMask

IPFS

Pinata

Sepolia Testnet



---

🎯 Future Roadmap

Auction System

Collection Verification

Royalty Support (ERC-2981)

Bundle Listings

Hierarchical Bundle Trading

Offer System

Marketplace Analytics

Multi-Collection Support

Frontend (React + Ethers.js)

Indexing with The Graph



---

📸 NFT Ecosystem

This marketplace is built to support the companion NFT collection:

Dragon Armor

Dragon Helmet

Dragon Sword

Dragon Moonlight Sword

Dragon Shield


These NFTs demonstrate hierarchical ownership relationships and modular digital asset composition.


---

🚀 Deployment

Network

Ethereum Sepolia

Storage

IPFS

Wallet

MetaMask


---

📄 License

MIT License

