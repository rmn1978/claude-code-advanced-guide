# 🎨 Web3 NFT Marketplace (OpenSea Clone)

**Stack**: Next.js 15 + Solidity + Hardhat + Ethers.js + IPFS + The Graph + PostgreSQL

**Nivel**: Avanzado (10-12 horas)

**Descripción**: Marketplace completo de NFTs con smart contracts en Ethereum, integración con wallets (MetaMask), subasta de NFTs, y indexing con The Graph. Un clon funcional de OpenSea.

## 🔥 ¿QUÉ CONSTRUIREMOS?

Un **marketplace descentralizado de NFTs** que demuestra:

### 🎯 Características Principales

**Smart Contracts (Solidity)**:
- ✅ ERC-721 NFT contract (tokens únicos)
- ✅ ERC-1155 contract (tokens semi-fungibles)
- ✅ Marketplace contract (compra/venta)
- ✅ Auction contract (subastas inglesas)
- ✅ Royalty system (creadores reciben % de reventas)
- ✅ Lazy minting (gas-efficient)
- ✅ Upgradeable contracts (proxy pattern)

**Frontend Web3**:
- ✅ Wallet connection (MetaMask, WalletConnect)
- ✅ Web3 authentication (Sign-In with Ethereum)
- ✅ NFT minting interface
- ✅ Marketplace browse & search
- ✅ Auction bidding system
- ✅ Collection management
- ✅ User profiles

**Decentralized Storage**:
- ✅ IPFS for NFT metadata & images
- ✅ Pinata for pinning (reliability)
- ✅ Arweave for permanent storage
- ✅ Content addressing (CID)

**Indexing & Analytics**:
- ✅ The Graph for blockchain indexing
- ✅ Real-time price tracking
- ✅ Sales history & volume
- ✅ Floor price calculation
- ✅ Trending collections

**Advanced Features**:
- ✅ Bulk minting (gas optimization)
- ✅ Rarity tools
- ✅ Collection verification
- ✅ Activity feed
- ✅ Notifications
- ✅ Multi-chain support (Ethereum, Polygon)

## 🏗️ Arquitectura del Sistema

```
┌──────────────────────────────────────────────────────────┐
│                    User Browser                           │
│              (Next.js + Ethers.js)                       │
└────────────┬─────────────────────────────────────────────┘
             │
      ┌──────┴──────┐
      │             │
      ↓             ↓
┌─────────┐   ┌────────────────────────────────────────┐
│MetaMask │   │        Ethereum Network                 │
│ Wallet  │   │  ┌──────────────────────────────────┐ │
│         │   │  │    Smart Contracts               │ │
│         │   │  │  • NFT.sol (ERC-721)            │ │
│         │   │  │  • Marketplace.sol               │ │
│         │   │  │  • Auction.sol                   │ │
│         │   │  │  • Royalty.sol                   │ │
│         │   │  └──────────────────────────────────┘ │
└─────────┘   │                                        │
              │     Events                             │
              └────────────┬───────────────────────────┘
                          │
                          ↓
              ┌────────────────────────────────────────┐
              │         The Graph (Indexer)             │
              │  • Index blockchain events              │
              │  • GraphQL API                          │
              │  • Real-time updates                    │
              └────────────┬───────────────────────────┘
                          │
                          ↓
              ┌────────────────────────────────────────┐
              │      Backend API (Next.js API)          │
              │  • Off-chain metadata                   │
              │  • User profiles                        │
              │  • Search & filters                     │
              │  • Analytics                            │
              └────────────┬───────────────────────────┘
                          │
                   ┌──────┴──────┐
                   │             │
                   ↓             ↓
          ┌────────────┐  ┌────────────────┐
          │ PostgreSQL │  │      IPFS       │
          │  Database  │  │  • Metadata     │
          │            │  │  • Images       │
          └────────────┘  │  • Assets       │
                          └────────────────┘
```

## 📁 Estructura del Proyecto

```
web3-nft-marketplace/
├── contracts/                     # Smart Contracts
│   ├── NFT.sol                   # ERC-721 NFT contract
│   ├── NFTMarketplace.sol        # Marketplace contract
│   ├── NFTAuction.sol            # Auction contract
│   ├── RoyaltyRegistry.sol       # Royalty management
│   └── test/
│       ├── NFT.test.js
│       └── Marketplace.test.js
│
├── scripts/                       # Deployment scripts
│   ├── deploy.js
│   ├── verify.js
│   └── seed.js
│
├── subgraph/                      # The Graph indexer
│   ├── schema.graphql
│   ├── subgraph.yaml
│   └── src/
│       └── mapping.ts
│
├── frontend/                      # Next.js App
│   ├── src/
│   │   ├── app/
│   │   │   ├── page.tsx                    # Homepage
│   │   │   ├── explore/page.tsx            # Browse NFTs
│   │   │   ├── create/page.tsx             # Mint NFT
│   │   │   ├── collection/[id]/page.tsx    # Collection page
│   │   │   ├── nft/[id]/page.tsx          # NFT details
│   │   │   ├── profile/[address]/page.tsx  # User profile
│   │   │   └── api/
│   │   │       ├── metadata/route.ts
│   │   │       ├── upload/route.ts
│   │   │       └── analytics/route.ts
│   │   ├── components/
│   │   │   ├── Web3Provider.tsx
│   │   │   ├── ConnectWallet.tsx
│   │   │   ├── NFTCard.tsx
│   │   │   ├── MintNFT.tsx
│   │   │   ├── BuyNFT.tsx
│   │   │   ├── PlaceBid.tsx
│   │   │   └── ActivityFeed.tsx
│   │   ├── lib/
│   │   │   ├── web3.ts
│   │   │   ├── contracts.ts
│   │   │   ├── ipfs.ts
│   │   │   └── graph.ts
│   │   └── hooks/
│   │       ├── useWeb3.ts
│   │       ├── useNFT.ts
│   │       ├── useMarketplace.ts
│   │       └── useAuction.ts
│   └── package.json
│
├── hardhat.config.js
├── .env.example
└── README.md
```

## 🔐 Smart Contracts

### 1. NFT Contract (ERC-721)

```solidity
// contracts/NFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

contract NFT is
    Initializable,
    ERC721Upgradeable,
    ERC721URIStorageUpgradeable,
    OwnableUpgradeable
{
    using CountersUpgradeable for CountersUpgradeable.Counter;
    CountersUpgradeable.Counter private _tokenIds;

    // Mapping from token ID to creator
    mapping(uint256 => address) public creators;

    // Mapping from token ID to royalty percentage (in basis points, e.g., 250 = 2.5%)
    mapping(uint256 => uint256) public royalties;

    // Events
    event NFTMinted(uint256 indexed tokenId, address indexed creator, string tokenURI);
    event RoyaltySet(uint256 indexed tokenId, uint256 royaltyPercentage);

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __ERC721_init("MyNFTMarketplace", "MNFT");
        __ERC721URIStorage_init();
        __Ownable_init(msg.sender);
    }

    /**
     * @dev Mints a new NFT
     * @param to Address to mint to
     * @param tokenURI Metadata URI (IPFS CID)
     * @param royaltyPercentage Royalty percentage in basis points
     */
    function mint(
        address to,
        string memory tokenURI,
        uint256 royaltyPercentage
    ) public returns (uint256) {
        require(royaltyPercentage <= 1000, "Royalty too high"); // Max 10%

        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _safeMint(to, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        creators[newTokenId] = msg.sender;
        royalties[newTokenId] = royaltyPercentage;

        emit NFTMinted(newTokenId, msg.sender, tokenURI);
        emit RoyaltySet(newTokenId, royaltyPercentage);

        return newTokenId;
    }

    /**
     * @dev Batch mint multiple NFTs (gas efficient)
     */
    function batchMint(
        address to,
        string[] memory tokenURIs,
        uint256 royaltyPercentage
    ) public returns (uint256[] memory) {
        require(royaltyPercentage <= 1000, "Royalty too high");
        require(tokenURIs.length > 0, "No URIs provided");
        require(tokenURIs.length <= 100, "Too many NFTs"); // Prevent gas limit

        uint256[] memory tokenIds = new uint256[](tokenURIs.length);

        for (uint256 i = 0; i < tokenURIs.length; i++) {
            _tokenIds.increment();
            uint256 newTokenId = _tokenIds.current();

            _safeMint(to, newTokenId);
            _setTokenURI(newTokenId, tokenURIs[i]);

            creators[newTokenId] = msg.sender;
            royalties[newTokenId] = royaltyPercentage;

            tokenIds[i] = newTokenId;

            emit NFTMinted(newTokenId, msg.sender, tokenURIs[i]);
        }

        return tokenIds;
    }

    /**
     * @dev Get creator of a token
     */
    function getCreator(uint256 tokenId) public view returns (address) {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");
        return creators[tokenId];
    }

    /**
     * @dev Get royalty info for a token
     */
    function getRoyaltyInfo(uint256 tokenId, uint256 salePrice)
        public
        view
        returns (address, uint256)
    {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");

        address creator = creators[tokenId];
        uint256 royaltyAmount = (salePrice * royalties[tokenId]) / 10000;

        return (creator, royaltyAmount);
    }

    // Override required functions
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
```

### 2. Marketplace Contract

```solidity
// contracts/NFTMarketplace.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./NFT.sol";

contract NFTMarketplace is ReentrancyGuardUpgradeable, OwnableUpgradeable {
    // Platform fee (in basis points, e.g., 250 = 2.5%)
    uint256 public platformFee;
    address public feeRecipient;

    struct Listing {
        address seller;
        address nftContract;
        uint256 tokenId;
        uint256 price;
        bool active;
    }

    // Mapping from listing ID to Listing
    mapping(uint256 => Listing) public listings;
    uint256 public listingCounter;

    // Events
    event NFTListed(
        uint256 indexed listingId,
        address indexed seller,
        address indexed nftContract,
        uint256 tokenId,
        uint256 price
    );

    event NFTSold(
        uint256 indexed listingId,
        address indexed buyer,
        address indexed seller,
        uint256 price,
        uint256 platformFeeAmount,
        uint256 royaltyAmount
    );

    event ListingCancelled(uint256 indexed listingId);

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address _feeRecipient, uint256 _platformFee) public initializer {
        __ReentrancyGuard_init();
        __Ownable_init(msg.sender);

        feeRecipient = _feeRecipient;
        platformFee = _platformFee;
    }

    /**
     * @dev List an NFT for sale
     */
    function listNFT(
        address nftContract,
        uint256 tokenId,
        uint256 price
    ) public nonReentrant returns (uint256) {
        require(price > 0, "Price must be greater than 0");

        IERC721 nft = IERC721(nftContract);
        require(nft.ownerOf(tokenId) == msg.sender, "Not the owner");
        require(
            nft.isApprovedForAll(msg.sender, address(this)) ||
            nft.getApproved(tokenId) == address(this),
            "Marketplace not approved"
        );

        listingCounter++;
        uint256 listingId = listingCounter;

        listings[listingId] = Listing({
            seller: msg.sender,
            nftContract: nftContract,
            tokenId: tokenId,
            price: price,
            active: true
        });

        emit NFTListed(listingId, msg.sender, nftContract, tokenId, price);

        return listingId;
    }

    /**
     * @dev Buy an NFT
     */
    function buyNFT(uint256 listingId) public payable nonReentrant {
        Listing storage listing = listings[listingId];

        require(listing.active, "Listing not active");
        require(msg.value >= listing.price, "Insufficient payment");

        listing.active = false;

        // Calculate fees
        uint256 platformFeeAmount = (listing.price * platformFee) / 10000;
        uint256 remainingAmount = listing.price - platformFeeAmount;

        // Get royalty info (if NFT contract supports it)
        uint256 royaltyAmount = 0;
        address creator = address(0);

        try NFT(listing.nftContract).getRoyaltyInfo(listing.tokenId, listing.price)
            returns (address _creator, uint256 _royaltyAmount)
        {
            creator = _creator;
            royaltyAmount = _royaltyAmount;
            remainingAmount -= royaltyAmount;
        } catch {
            // NFT doesn't support royalties, continue without them
        }

        // Transfer NFT to buyer
        IERC721(listing.nftContract).safeTransferFrom(
            listing.seller,
            msg.sender,
            listing.tokenId
        );

        // Transfer funds
        (bool success1, ) = payable(feeRecipient).call{value: platformFeeAmount}("");
        require(success1, "Platform fee transfer failed");

        if (royaltyAmount > 0 && creator != address(0)) {
            (bool success2, ) = payable(creator).call{value: royaltyAmount}("");
            require(success2, "Royalty transfer failed");
        }

        (bool success3, ) = payable(listing.seller).call{value: remainingAmount}("");
        require(success3, "Seller payment failed");

        // Refund excess payment
        if (msg.value > listing.price) {
            (bool success4, ) = payable(msg.sender).call{value: msg.value - listing.price}("");
            require(success4, "Refund failed");
        }

        emit NFTSold(
            listingId,
            msg.sender,
            listing.seller,
            listing.price,
            platformFeeAmount,
            royaltyAmount
        );
    }

    /**
     * @dev Cancel a listing
     */
    function cancelListing(uint256 listingId) public {
        Listing storage listing = listings[listingId];

        require(listing.active, "Listing not active");
        require(listing.seller == msg.sender, "Not the seller");

        listing.active = false;

        emit ListingCancelled(listingId);
    }

    /**
     * @dev Update platform fee (owner only)
     */
    function updatePlatformFee(uint256 newFee) public onlyOwner {
        require(newFee <= 1000, "Fee too high"); // Max 10%
        platformFee = newFee;
    }

    /**
     * @dev Update fee recipient (owner only)
     */
    function updateFeeRecipient(address newRecipient) public onlyOwner {
        require(newRecipient != address(0), "Invalid address");
        feeRecipient = newRecipient;
    }
}
```

### 3. Auction Contract

```solidity
// contracts/NFTAuction.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract NFTAuction is ReentrancyGuardUpgradeable {
    struct Auction {
        address seller;
        address nftContract;
        uint256 tokenId;
        uint256 startPrice;
        uint256 endTime;
        address highestBidder;
        uint256 highestBid;
        bool ended;
    }

    mapping(uint256 => Auction) public auctions;
    uint256 public auctionCounter;

    event AuctionCreated(
        uint256 indexed auctionId,
        address indexed seller,
        uint256 tokenId,
        uint256 startPrice,
        uint256 endTime
    );

    event BidPlaced(
        uint256 indexed auctionId,
        address indexed bidder,
        uint256 amount
    );

    event AuctionEnded(
        uint256 indexed auctionId,
        address indexed winner,
        uint256 amount
    );

    function initialize() public initializer {
        __ReentrancyGuard_init();
    }

    /**
     * @dev Create an auction
     */
    function createAuction(
        address nftContract,
        uint256 tokenId,
        uint256 startPrice,
        uint256 duration
    ) public returns (uint256) {
        require(duration >= 1 hours, "Duration too short");
        require(duration <= 30 days, "Duration too long");

        IERC721 nft = IERC721(nftContract);
        require(nft.ownerOf(tokenId) == msg.sender, "Not the owner");
        require(
            nft.isApprovedForAll(msg.sender, address(this)),
            "Marketplace not approved"
        );

        auctionCounter++;
        uint256 auctionId = auctionCounter;

        auctions[auctionId] = Auction({
            seller: msg.sender,
            nftContract: nftContract,
            tokenId: tokenId,
            startPrice: startPrice,
            endTime: block.timestamp + duration,
            highestBidder: address(0),
            highestBid: 0,
            ended: false
        });

        emit AuctionCreated(
            auctionId,
            msg.sender,
            tokenId,
            startPrice,
            block.timestamp + duration
        );

        return auctionId;
    }

    /**
     * @dev Place a bid
     */
    function placeBid(uint256 auctionId) public payable nonReentrant {
        Auction storage auction = auctions[auctionId];

        require(!auction.ended, "Auction ended");
        require(block.timestamp < auction.endTime, "Auction expired");
        require(msg.value >= auction.startPrice, "Bid too low");
        require(msg.value > auction.highestBid, "Bid not high enough");

        // Refund previous bidder
        if (auction.highestBidder != address(0)) {
            (bool success, ) = payable(auction.highestBidder).call{
                value: auction.highestBid
            }("");
            require(success, "Refund failed");
        }

        auction.highestBidder = msg.sender;
        auction.highestBid = msg.value;

        emit BidPlaced(auctionId, msg.sender, msg.value);
    }

    /**
     * @dev End the auction
     */
    function endAuction(uint256 auctionId) public nonReentrant {
        Auction storage auction = auctions[auctionId];

        require(!auction.ended, "Auction already ended");
        require(block.timestamp >= auction.endTime, "Auction not yet ended");

        auction.ended = true;

        if (auction.highestBidder != address(0)) {
            // Transfer NFT to winner
            IERC721(auction.nftContract).safeTransferFrom(
                auction.seller,
                auction.highestBidder,
                auction.tokenId
            );

            // Transfer payment to seller
            (bool success, ) = payable(auction.seller).call{
                value: auction.highestBid
            }("");
            require(success, "Payment failed");

            emit AuctionEnded(
                auctionId,
                auction.highestBidder,
                auction.highestBid
            );
        } else {
            // No bids, return NFT to seller
            emit AuctionEnded(auctionId, address(0), 0);
        }
    }
}
```

## 🌐 Frontend Integration

### Web3 Provider & Wallet Connection

```typescript
// frontend/src/components/Web3Provider.tsx
'use client'

import { createContext, useContext, useState, useEffect, ReactNode } from 'react'
import { ethers } from 'ethers'

interface Web3ContextType {
  provider: ethers.BrowserProvider | null
  signer: ethers.Signer | null
  account: string | null
  chainId: number | null
  connect: () => Promise<void>
  disconnect: () => void
  isConnected: boolean
}

const Web3Context = createContext<Web3ContextType>({
  provider: null,
  signer: null,
  account: null,
  chainId: null,
  connect: async () => {},
  disconnect: () => {},
  isConnected: false,
})

export function Web3Provider({ children }: { children: ReactNode }) {
  const [provider, setProvider] = useState<ethers.BrowserProvider | null>(null)
  const [signer, setSigner] = useState<ethers.Signer | null>(null)
  const [account, setAccount] = useState<string | null>(null)
  const [chainId, setChainId] = useState<number | null>(null)

  const connect = async () => {
    if (typeof window.ethereum === 'undefined') {
      alert('Please install MetaMask!')
      return
    }

    try {
      // Request account access
      const accounts = await window.ethereum.request({
        method: 'eth_requestAccounts',
      })

      // Create provider
      const provider = new ethers.BrowserProvider(window.ethereum)
      const signer = await provider.getSigner()
      const network = await provider.getNetwork()

      setProvider(provider)
      setSigner(signer)
      setAccount(accounts[0])
      setChainId(Number(network.chainId))

      // Listen for account changes
      window.ethereum.on('accountsChanged', handleAccountsChanged)
      window.ethereum.on('chainChanged', handleChainChanged)
    } catch (error) {
      console.error('Error connecting wallet:', error)
    }
  }

  const disconnect = () => {
    setProvider(null)
    setSigner(null)
    setAccount(null)
    setChainId(null)

    if (window.ethereum) {
      window.ethereum.removeListener('accountsChanged', handleAccountsChanged)
      window.ethereum.removeListener('chainChanged', handleChainChanged)
    }
  }

  const handleAccountsChanged = (accounts: string[]) => {
    if (accounts.length === 0) {
      disconnect()
    } else {
      setAccount(accounts[0])
    }
  }

  const handleChainChanged = () => {
    window.location.reload()
  }

  // Auto-connect if previously connected
  useEffect(() => {
    if (typeof window.ethereum !== 'undefined') {
      window.ethereum.request({ method: 'eth_accounts' }).then((accounts: string[]) => {
        if (accounts.length > 0) {
          connect()
        }
      })
    }
  }, [])

  return (
    <Web3Context.Provider
      value={{
        provider,
        signer,
        account,
        chainId,
        connect,
        disconnect,
        isConnected: !!account,
      }}
    >
      {children}
    </Web3Context.Provider>
  )
}

export const useWeb3 = () => useContext(Web3Context)
```

### Mint NFT Component

```typescript
// frontend/src/components/MintNFT.tsx
'use client'

import { useState } from 'react'
import { useWeb3 } from './Web3Provider'
import { ethers } from 'ethers'
import { uploadToIPFS } from '@/lib/ipfs'
import NFTAbi from '@/contracts/NFT.json'

const NFT_CONTRACT_ADDRESS = process.env.NEXT_PUBLIC_NFT_CONTRACT_ADDRESS!

export function MintNFT() {
  const { signer, isConnected } = useWeb3()
  const [name, setName] = useState('')
  const [description, setDescription] = useState('')
  const [file, setFile] = useState<File | null>(null)
  const [royalty, setRoyalty] = useState(250) // 2.5%
  const [minting, setMinting] = useState(false)

  const handleMint = async (e: React.FormEvent) => {
    e.preventDefault()

    if (!signer || !file) return

    try {
      setMinting(true)

      // Upload image to IPFS
      console.log('Uploading image to IPFS...')
      const imageUrl = await uploadToIPFS(file)

      // Create metadata
      const metadata = {
        name,
        description,
        image: imageUrl,
        attributes: [],
      }

      // Upload metadata to IPFS
      console.log('Uploading metadata to IPFS...')
      const metadataUrl = await uploadToIPFS(
        new Blob([JSON.stringify(metadata)], { type: 'application/json' })
      )

      // Mint NFT
      console.log('Minting NFT...')
      const contract = new ethers.Contract(NFT_CONTRACT_ADDRESS, NFTAbi.abi, signer)

      const tx = await contract.mint(
        await signer.getAddress(),
        metadataUrl,
        royalty
      )

      console.log('Transaction sent:', tx.hash)
      const receipt = await tx.wait()
      console.log('NFT minted!', receipt)

      alert('NFT minted successfully!')

      // Reset form
      setName('')
      setDescription('')
      setFile(null)
    } catch (error) {
      console.error('Error minting NFT:', error)
      alert('Error minting NFT')
    } finally {
      setMinting(false)
    }
  }

  if (!isConnected) {
    return <div>Please connect your wallet to mint NFTs</div>
  }

  return (
    <form onSubmit={handleMint} className="max-w-2xl mx-auto space-y-6">
      <div>
        <label className="block text-sm font-medium mb-2">Name</label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
          className="w-full px-4 py-2 border rounded-lg"
        />
      </div>

      <div>
        <label className="block text-sm font-medium mb-2">Description</label>
        <textarea
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          rows={4}
          className="w-full px-4 py-2 border rounded-lg"
        />
      </div>

      <div>
        <label className="block text-sm font-medium mb-2">Image</label>
        <input
          type="file"
          accept="image/*"
          onChange={(e) => setFile(e.target.files?.[0] || null)}
          required
          className="w-full"
        />
      </div>

      <div>
        <label className="block text-sm font-medium mb-2">
          Royalty ({royalty / 100}%)
        </label>
        <input
          type="range"
          min="0"
          max="1000"
          step="25"
          value={royalty}
          onChange={(e) => setRoyalty(parseInt(e.target.value))}
          className="w-full"
        />
        <p className="text-sm text-gray-600 mt-1">
          You'll receive {royalty / 100}% of future sales
        </p>
      </div>

      <button
        type="submit"
        disabled={minting}
        className="w-full bg-blue-600 text-white py-3 rounded-lg hover:bg-blue-700 disabled:opacity-50"
      >
        {minting ? 'Minting...' : 'Mint NFT'}
      </button>
    </form>
  )
}
```

## 📊 IPFS Integration

```typescript
// frontend/src/lib/ipfs.ts
import { create } from 'ipfs-http-client'

// Connect to IPFS (using Infura or local node)
const client = create({
  host: 'ipfs.infura.io',
  port: 5001,
  protocol: 'https',
  headers: {
    authorization: `Basic ${Buffer.from(
      `${process.env.NEXT_PUBLIC_INFURA_PROJECT_ID}:${process.env.NEXT_PUBLIC_INFURA_PROJECT_SECRET}`
    ).toString('base64')}`,
  },
})

export async function uploadToIPFS(file: File | Blob): Promise<string> {
  try {
    const added = await client.add(file)
    const url = `https://ipfs.io/ipfs/${added.path}`
    return url
  } catch (error) {
    console.error('Error uploading to IPFS:', error)
    throw error
  }
}

export async function pinToIPFS(cid: string): Promise<void> {
  // Pin to Pinata for persistence
  const url = 'https://api.pinata.cloud/pinning/pinByHash'

  await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${process.env.PINATA_JWT}`,
    },
    body: JSON.stringify({ hashToPin: cid }),
  })
}
```

## 🚀 Deployment

### Deploy Smart Contracts

```javascript
// scripts/deploy.js
const hre = require("hardhat")

async function main() {
  // Deploy NFT Contract
  const NFT = await hre.ethers.getContractFactory("NFT")
  const nft = await hre.upgrades.deployProxy(NFT, [], {
    initializer: "initialize",
  })
  await nft.waitForDeployment()
  console.log("NFT deployed to:", await nft.getAddress())

  // Deploy Marketplace
  const Marketplace = await hre.ethers.getContractFactory("NFTMarketplace")
  const marketplace = await hre.upgrades.deployProxy(
    Marketplace,
    [
      "0xYourFeeRecipientAddress", // Fee recipient
      250, // 2.5% platform fee
    ],
    { initializer: "initialize" }
  )
  await marketplace.waitForDeployment()
  console.log("Marketplace deployed to:", await marketplace.getAddress())

  // Deploy Auction
  const Auction = await hre.ethers.getContractFactory("NFTAuction")
  const auction = await hre.upgrades.deployProxy(Auction, [], {
    initializer: "initialize",
  })
  await auction.waitForDeployment()
  console.log("Auction deployed to:", await auction.getAddress())
}

main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
```

## 💰 Business Model

| Revenue Stream | Details |
|---------------|---------|
| Platform Fee | 2.5% on all sales |
| Listing Fee | Optional $0.01-0.1 ETH |
| Premium Features | Verified collections, analytics |
| Promoted Listings | Featured placement |

**Revenue Projections**:
- 10,000 monthly sales @ 1 ETH avg = 250 ETH/month
- At $2,000/ETH = **$500k MRR**
- Scale to OpenSea level = **$50M-500M MRR**

## 🌟 ¿POR QUÉ ES INCREÍBLE?

1. **Web3 Native**: Totalmente descentralizado
2. **Royalty System**: Creadores ganan forever
3. **Multi-Chain**: Ethereum, Polygon, etc.
4. **Upgradeable**: Smart contracts upgradeables
5. **Gas Efficient**: Batch minting, lazy minting
6. **Revenue Model**: Probado ($50M+ MRR possible)

---

**Estimated Time**: 10-12 hours
**Difficulty**: Advanced 🔴
**Potential Revenue**: $500k - $500M MRR
**Tech Stack**: 10+ cutting-edge Web3 tools

**¡Claude Code puede construir el futuro descentralizado!** 🔗✨
