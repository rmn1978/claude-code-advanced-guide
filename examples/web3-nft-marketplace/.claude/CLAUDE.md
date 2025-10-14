# Web3 NFT Marketplace - Project Memory

## Project Overview

**Name**: Web3 NFT Marketplace
**Type**: Blockchain-based NFT trading platform
**Stack**: Next.js 15 + Solidity + Hardhat + Ethers.js + IPFS + The Graph + PostgreSQL
**Status**: Production-ready template

## Core Purpose

Complete NFT marketplace with:
- Smart contract minting (ERC-721)
- Buy/Sell/Trade functionality
- Auction system (English auctions)
- Royalty payments to creators
- IPFS decentralized storage
- The Graph blockchain indexing

## Architecture

### High-Level Flow

```
User Wallet (MetaMask)
       ↓
Frontend (Next.js) ← Ethers.js → Smart Contracts (Ethereum)
       ↓                                   ↓
   PostgreSQL                         Blockchain
   (metadata)                         (ownership)
       ↓                                   ↓
The Graph Indexer ←──────────────────────┘
       ↓
  IPFS Storage
  (NFT files + metadata JSON)
```

### Smart Contract Architecture

```
NFT.sol (ERC-721)
├── Minting with royalties
├── Royalty info (EIP-2981)
├── Token URI (IPFS links)
└── Creator tracking

NFTMarketplace.sol
├── List NFT for sale
├── Buy NFT (with platform fee + royalty)
├── Cancel listing
├── Update price
└── Offer system

NFTAuction.sol
├── Create auction
├── Place bid
├── End auction
├── Cancel auction
└── Minimum bid increments
```

## Smart Contracts

### 1. NFT.sol (ERC-721 with Royalties)

**Purpose**: NFT token contract with creator royalties

**Key Functions**:
```solidity
function mint(
    address to,
    string memory tokenURI,
    uint256 royaltyPercentage  // basis points (e.g., 250 = 2.5%)
) public returns (uint256)
```

**Features**:
- ERC-721 compliant
- Upgradeable (UUPS pattern)
- Royalty tracking per token
- Creator tracking
- Token URI (IPFS metadata)

**Events**:
```solidity
event NFTMinted(uint256 indexed tokenId, address indexed creator, string tokenURI, uint256 royalty);
```

### 2. NFTMarketplace.sol

**Purpose**: Fixed-price marketplace for buying/selling NFTs

**Key Functions**:

```solidity
// List NFT for sale
function listNFT(
    address nftContract,
    uint256 tokenId,
    uint256 price
) public

// Buy NFT (handles platform fee + royalty)
function buyNFT(uint256 listingId) public payable

// Cancel listing
function cancelListing(uint256 listingId) public

// Make offer
function makeOffer(uint256 listingId, uint256 offerPrice) public payable

// Accept offer
function acceptOffer(uint256 offerId) public
```

**Fee Structure**:
```solidity
uint256 public platformFee = 250;  // 2.5% platform fee
```

**Payment Flow**:
```
Total Sale Price
├── Platform Fee (2.5%)
├── Creator Royalty (configurable, e.g., 2.5%)
└── Seller Payment (remaining)
```

**Events**:
```solidity
event NFTListed(uint256 indexed listingId, address indexed seller, uint256 price);
event NFTSold(uint256 indexed listingId, address indexed buyer, uint256 price);
event OfferMade(uint256 indexed offerId, address indexed buyer, uint256 price);
```

### 3. NFTAuction.sol

**Purpose**: English auction system for NFTs

**Key Functions**:

```solidity
// Create auction
function createAuction(
    address nftContract,
    uint256 tokenId,
    uint256 startingPrice,
    uint256 duration  // in seconds
) public

// Place bid
function placeBid(uint256 auctionId) public payable

// End auction
function endAuction(uint256 auctionId) public

// Cancel auction (only if no bids)
function cancelAuction(uint256 auctionId) public
```

**Auction Rules**:
- Minimum bid increment: 5% above current bid
- Bids are escrowed in contract
- Previous bidder refunded automatically
- Only seller or winner can end auction after duration

**Events**:
```solidity
event AuctionCreated(uint256 indexed auctionId, uint256 startingPrice, uint256 endTime);
event BidPlaced(uint256 indexed auctionId, address indexed bidder, uint256 amount);
event AuctionEnded(uint256 indexed auctionId, address indexed winner, uint256 finalPrice);
```

## Frontend Architecture

### Directory Structure

```
frontend/
├── src/
│   ├── app/
│   │   ├── page.tsx                    # Homepage (featured NFTs)
│   │   ├── explore/page.tsx            # Browse all NFTs
│   │   ├── nft/[id]/page.tsx          # NFT detail page
│   │   ├── create/page.tsx             # Mint NFT
│   │   ├── profile/[address]/page.tsx  # User profile
│   │   └── collection/[id]/page.tsx    # Collection page
│   │
│   ├── components/
│   │   ├── web3/
│   │   │   ├── WalletConnect.tsx       # Wallet connection
│   │   │   ├── NetworkSwitch.tsx       # Network switcher
│   │   │   └── TransactionStatus.tsx   # TX status modal
│   │   ├── nft/
│   │   │   ├── NFTCard.tsx             # NFT grid card
│   │   │   ├── NFTDetail.tsx           # NFT detail view
│   │   │   ├── BuyButton.tsx           # Purchase button
│   │   │   ├── ListingForm.tsx         # List NFT form
│   │   │   └── AuctionBid.tsx          # Auction bidding UI
│   │   ├── forms/
│   │   │   ├── MintNFTForm.tsx         # NFT minting form
│   │   │   └── UploadMedia.tsx         # IPFS upload
│   │   └── layout/
│   │       ├── Header.tsx
│   │       └── Footer.tsx
│   │
│   ├── hooks/
│   │   ├── useWeb3.ts                  # Web3 context
│   │   ├── useContract.ts              # Contract interactions
│   │   ├── useNFT.ts                   # NFT queries
│   │   ├── useMarketplace.ts           # Marketplace functions
│   │   └── useIPFS.ts                  # IPFS uploads
│   │
│   ├── lib/
│   │   ├── contracts/
│   │   │   ├── NFT.json                # ABI
│   │   │   ├── NFTMarketplace.json     # ABI
│   │   │   └── NFTAuction.json         # ABI
│   │   ├── web3/
│   │   │   ├── config.ts               # Network configs
│   │   │   ├── providers.ts            # Ethers providers
│   │   │   └── utils.ts                # Web3 utilities
│   │   ├── ipfs/
│   │   │   └── client.ts               # IPFS client (Pinata)
│   │   └── graphql/
│   │       ├── client.ts               # The Graph client
│   │       └── queries.ts              # GraphQL queries
│   │
│   └── types/
│       ├── nft.ts
│       ├── marketplace.ts
│       └── web3.ts
│
└── public/
    └── contracts/                       # Deployed contract addresses
```

### Key React Hooks

#### useWeb3.ts

```typescript
const Web3Context = createContext<Web3ContextType | undefined>(undefined)

export function Web3Provider({ children }: { children: ReactNode }) {
  const [account, setAccount] = useState<string | null>(null)
  const [chainId, setChainId] = useState<number | null>(null)
  const [provider, setProvider] = useState<Web3Provider | null>(null)
  const [signer, setSigner] = useState<Signer | null>(null)

  // Connect wallet
  const connectWallet = async () => {
    if (typeof window.ethereum !== 'undefined') {
      const provider = new ethers.BrowserProvider(window.ethereum)
      const accounts = await provider.send('eth_requestAccounts', [])
      const signer = await provider.getSigner()
      const network = await provider.getNetwork()

      setProvider(provider)
      setSigner(signer)
      setAccount(accounts[0])
      setChainId(Number(network.chainId))
    }
  }

  // Listen for account changes
  useEffect(() => {
    if (typeof window.ethereum !== 'undefined') {
      window.ethereum.on('accountsChanged', (accounts: string[]) => {
        setAccount(accounts[0] || null)
      })
      window.ethereum.on('chainChanged', (chainId: string) => {
        setChainId(parseInt(chainId, 16))
      })
    }
  }, [])

  return (
    <Web3Context.Provider value={{ account, chainId, provider, signer, connectWallet }}>
      {children}
    </Web3Context.Provider>
  )
}

export const useWeb3 = () => {
  const context = useContext(Web3Context)
  if (!context) throw new Error('useWeb3 must be used within Web3Provider')
  return context
}
```

#### useContract.ts

```typescript
export function useContract<T extends Contract>(
  address: string,
  abi: any
): T | null {
  const { signer, provider } = useWeb3()

  return useMemo(() => {
    if (!address || !abi) return null
    if (signer) {
      return new ethers.Contract(address, abi, signer) as T
    }
    if (provider) {
      return new ethers.Contract(address, abi, provider) as T
    }
    return null
  }, [address, abi, signer, provider])
}
```

#### useMarketplace.ts

```typescript
export function useMarketplace() {
  const { account, signer } = useWeb3()
  const marketplaceContract = useContract(MARKETPLACE_ADDRESS, MarketplaceABI)

  const listNFT = async (
    nftContract: string,
    tokenId: number,
    price: string  // in ETH
  ) => {
    if (!marketplaceContract || !signer) throw new Error('Not connected')

    const priceWei = ethers.parseEther(price)
    const tx = await marketplaceContract.listNFT(nftContract, tokenId, priceWei)
    await tx.wait()
    return tx.hash
  }

  const buyNFT = async (listingId: number, price: string) => {
    if (!marketplaceContract || !signer) throw new Error('Not connected')

    const priceWei = ethers.parseEther(price)
    const tx = await marketplaceContract.buyNFT(listingId, { value: priceWei })
    await tx.wait()
    return tx.hash
  }

  const cancelListing = async (listingId: number) => {
    if (!marketplaceContract || !signer) throw new Error('Not connected')

    const tx = await marketplaceContract.cancelListing(listingId)
    await tx.wait()
    return tx.hash
  }

  return { listNFT, buyNFT, cancelListing }
}
```

#### useIPFS.ts

```typescript
export function useIPFS() {
  const uploadToIPFS = async (file: File): Promise<string> => {
    const formData = new FormData()
    formData.append('file', file)

    const response = await fetch('https://api.pinata.cloud/pinning/pinFileToIPFS', {
      method: 'POST',
      headers: {
        pinata_api_key: process.env.NEXT_PUBLIC_PINATA_API_KEY!,
        pinata_secret_api_key: process.env.NEXT_PUBLIC_PINATA_SECRET_KEY!,
      },
      body: formData,
    })

    const data = await response.json()
    return `ipfs://${data.IpfsHash}`
  }

  const uploadMetadata = async (metadata: NFTMetadata): Promise<string> => {
    const response = await fetch('https://api.pinata.cloud/pinning/pinJSONToIPFS', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        pinata_api_key: process.env.NEXT_PUBLIC_PINATA_API_KEY!,
        pinata_secret_api_key: process.env.NEXT_PUBLIC_PINATA_SECRET_KEY!,
      },
      body: JSON.stringify(metadata),
    })

    const data = await response.json()
    return `ipfs://${data.IpfsHash}`
  }

  return { uploadToIPFS, uploadMetadata }
}
```

## NFT Metadata Standard (ERC-721)

### Metadata JSON Structure

Stored on IPFS, referenced by `tokenURI` in smart contract:

```json
{
  "name": "Cool NFT #1234",
  "description": "This is an amazing NFT",
  "image": "ipfs://QmXxx.../image.png",
  "external_url": "https://marketplace.com/nft/1234",
  "attributes": [
    {
      "trait_type": "Background",
      "value": "Blue"
    },
    {
      "trait_type": "Rarity",
      "value": "Legendary"
    },
    {
      "trait_type": "Power",
      "value": 95,
      "display_type": "number",
      "max_value": 100
    }
  ],
  "properties": {
    "creator": {
      "name": "Artist Name",
      "address": "0x..."
    },
    "royalty": 250,
    "collection": "Cool NFTs"
  }
}
```

## The Graph Integration

### Subgraph Schema

```graphql
type NFT @entity {
  id: ID!                           # tokenId
  tokenId: BigInt!
  contract: Bytes!
  creator: Bytes!
  owner: Bytes!
  tokenURI: String!
  royalty: BigInt!
  createdAt: BigInt!

  listings: [Listing!]! @derivedFrom(field: "nft")
  auctions: [Auction!]! @derivedFrom(field: "nft")
  transfers: [Transfer!]! @derivedFrom(field: "nft")
}

type Listing @entity {
  id: ID!                           # listingId
  nft: NFT!
  seller: Bytes!
  price: BigInt!
  active: Boolean!
  createdAt: BigInt!
  soldAt: BigInt
  buyer: Bytes

  offers: [Offer!]! @derivedFrom(field: "listing")
}

type Auction @entity {
  id: ID!                           # auctionId
  nft: NFT!
  seller: Bytes!
  startingPrice: BigInt!
  endTime: BigInt!
  active: Boolean!

  bids: [Bid!]! @derivedFrom(field: "auction")
  winner: Bytes
  finalPrice: BigInt
}

type Bid @entity {
  id: ID!
  auction: Auction!
  bidder: Bytes!
  amount: BigInt!
  timestamp: BigInt!
}

type Transfer @entity {
  id: ID!
  nft: NFT!
  from: Bytes!
  to: Bytes!
  timestamp: BigInt!
  transactionHash: Bytes!
}
```

### GraphQL Queries

```graphql
# Get all NFTs by creator
query getNFTsByCreator($creator: Bytes!) {
  nfts(where: { creator: $creator }, orderBy: createdAt, orderDirection: desc) {
    id
    tokenId
    tokenURI
    owner
    royalty
    createdAt
  }
}

# Get active listings
query getActiveListings($first: Int!, $skip: Int!) {
  listings(
    where: { active: true }
    first: $first
    skip: $skip
    orderBy: createdAt
    orderDirection: desc
  ) {
    id
    nft {
      id
      tokenId
      tokenURI
      creator
    }
    seller
    price
    createdAt
  }
}

# Get auction with bids
query getAuction($auctionId: ID!) {
  auction(id: $auctionId) {
    id
    nft {
      tokenId
      tokenURI
    }
    seller
    startingPrice
    endTime
    active
    bids(orderBy: amount, orderDirection: desc) {
      bidder
      amount
      timestamp
    }
  }
}

# Get user activity
query getUserActivity($address: Bytes!) {
  nfts(where: { owner: $address }) {
    id
    tokenId
    tokenURI
  }
  listings(where: { seller: $address, active: true }) {
    id
    price
    nft {
      tokenURI
    }
  }
  bids(where: { bidder: $address }, orderBy: timestamp, orderDirection: desc) {
    auction {
      id
      nft {
        tokenURI
      }
    }
    amount
  }
}
```

## Database Schema (PostgreSQL)

Used for off-chain data (user profiles, favorites, etc.):

```prisma
model User {
  id            String   @id @default(cuid())
  address       String   @unique
  username      String?  @unique
  bio           String?
  avatar        String?
  coverImage    String?
  verified      Boolean  @default(false)
  createdAt     DateTime @default(now())

  nfts          NFT[]
  favorites     Favorite[]
  collections   Collection[]

  @@index([address])
}

model NFT {
  id            String   @id @default(cuid())
  tokenId       Int
  contractAddress String
  chainId       Int
  creator       User     @relation(fields: [creatorAddress], references: [address])
  creatorAddress String

  // Cached from blockchain/IPFS
  name          String
  description   String?
  image         String
  metadata      Json

  favorites     Favorite[]
  views         Int      @default(0)

  @@unique([contractAddress, tokenId, chainId])
  @@index([creatorAddress])
  @@index([contractAddress])
}

model Collection {
  id            String   @id @default(cuid())
  name          String
  description   String?
  image         String?
  creator       User     @relation(fields: [creatorAddress], references: [address])
  creatorAddress String
  contractAddress String @unique

  floorPrice    Decimal? @db.Decimal(78, 0)
  volumeTraded  Decimal  @default(0) @db.Decimal(78, 0)

  @@index([creatorAddress])
}

model Favorite {
  id            String   @id @default(cuid())
  user          User     @relation(fields: [userId], references: [id])
  userId        String
  nft           NFT      @relation(fields: [nftId], references: [id])
  nftId         String
  createdAt     DateTime @default(now())

  @@unique([userId, nftId])
}
```

## Minting Flow (Frontend → IPFS → Blockchain)

```typescript
// components/forms/MintNFTForm.tsx
const MintNFTForm = () => {
  const { account } = useWeb3()
  const { uploadToIPFS, uploadMetadata } = useIPFS()
  const nftContract = useContract(NFT_CONTRACT_ADDRESS, NFTABI)

  const handleMint = async (formData: {
    name: string
    description: string
    image: File
    royalty: number  // percentage (e.g., 2.5)
    attributes: { trait_type: string; value: string }[]
  }) => {
    // 1. Upload image to IPFS
    const imageURI = await uploadToIPFS(formData.image)

    // 2. Create metadata JSON
    const metadata = {
      name: formData.name,
      description: formData.description,
      image: imageURI,
      attributes: formData.attributes,
      properties: {
        creator: {
          address: account,
        },
        royalty: formData.royalty * 100,  // convert to basis points
      },
    }

    // 3. Upload metadata to IPFS
    const metadataURI = await uploadMetadata(metadata)

    // 4. Mint NFT on blockchain
    const royaltyBasisPoints = formData.royalty * 100  // 2.5% → 250
    const tx = await nftContract.mint(account, metadataURI, royaltyBasisPoints)

    // 5. Wait for confirmation
    const receipt = await tx.wait()

    // 6. Get tokenId from event
    const mintEvent = receipt.logs.find((log) => log.eventName === 'NFTMinted')
    const tokenId = mintEvent.args.tokenId

    return { tokenId, transactionHash: receipt.hash }
  }

  return (
    <form onSubmit={handleSubmit(handleMint)}>
      {/* Form fields... */}
    </form>
  )
}
```

## Buying Flow (Frontend → Marketplace Contract)

```typescript
// components/nft/BuyButton.tsx
const BuyButton = ({ listing }: { listing: Listing }) => {
  const { buyNFT } = useMarketplace()
  const nftContract = useContract(listing.nft.contract, NFTABI)
  const [isPurchasing, setIsPurchasing] = useState(false)

  const handleBuy = async () => {
    setIsPurchasing(true)
    try {
      // 1. Buy NFT (sends ETH to marketplace)
      const txHash = await buyNFT(listing.id, listing.price)

      // 2. Show success message
      toast.success(`NFT purchased! TX: ${txHash}`)

      // 3. Refresh NFT data from The Graph
      await refetch()

    } catch (error) {
      toast.error(`Purchase failed: ${error.message}`)
    } finally {
      setIsPurchasing(false)
    }
  }

  return (
    <button onClick={handleBuy} disabled={isPurchasing}>
      {isPurchasing ? 'Processing...' : `Buy for ${ethers.formatEther(listing.price)} ETH`}
    </button>
  )
}
```

## Listing Flow (Approve → List)

```typescript
// components/nft/ListingForm.tsx
const ListingForm = ({ nft }: { nft: NFT }) => {
  const { listNFT } = useMarketplace()
  const nftContract = useContract(nft.contract, NFTABI)

  const handleList = async (price: string) => {
    // 1. Check if marketplace is approved
    const approvedAddress = await nftContract.getApproved(nft.tokenId)

    // 2. If not approved, request approval
    if (approvedAddress !== MARKETPLACE_ADDRESS) {
      const approveTx = await nftContract.approve(MARKETPLACE_ADDRESS, nft.tokenId)
      await approveTx.wait()
    }

    // 3. List NFT on marketplace
    const listTx = await listNFT(nft.contract, nft.tokenId, price)

    toast.success('NFT listed successfully!')
    return listTx
  }

  return <form onSubmit={handleSubmit(handleList)}>{/* ... */}</form>
}
```

## Auction Flow

### Creating Auction

```typescript
const createAuction = async (
  nftContract: string,
  tokenId: number,
  startingPrice: string,
  durationInHours: number
) => {
  // 1. Approve auction contract
  const nft = useContract(nftContract, NFTABI)
  const approveTx = await nft.approve(AUCTION_CONTRACT_ADDRESS, tokenId)
  await approveTx.wait()

  // 2. Create auction
  const auctionContract = useContract(AUCTION_CONTRACT_ADDRESS, AuctionABI)
  const priceWei = ethers.parseEther(startingPrice)
  const duration = durationInHours * 3600  // convert to seconds

  const tx = await auctionContract.createAuction(
    nftContract,
    tokenId,
    priceWei,
    duration
  )
  await tx.wait()
}
```

### Bidding on Auction

```typescript
const placeBid = async (auctionId: number, bidAmount: string) => {
  const auctionContract = useContract(AUCTION_CONTRACT_ADDRESS, AuctionABI)

  const bidWei = ethers.parseEther(bidAmount)
  const tx = await auctionContract.placeBid(auctionId, { value: bidWei })
  await tx.wait()
}
```

### Ending Auction

```typescript
const endAuction = async (auctionId: number) => {
  const auctionContract = useContract(AUCTION_CONTRACT_ADDRESS, AuctionABI)

  const tx = await auctionContract.endAuction(auctionId)
  await tx.wait()

  // Transfers NFT to winner, pays out seller (minus fees + royalty)
}
```

## Network Configuration

### Supported Networks

```typescript
// lib/web3/config.ts
export const NETWORKS = {
  ethereum: {
    chainId: 1,
    name: 'Ethereum Mainnet',
    rpcUrl: 'https://mainnet.infura.io/v3/...',
    blockExplorer: 'https://etherscan.io',
    nativeCurrency: { name: 'Ether', symbol: 'ETH', decimals: 18 },
  },
  goerli: {
    chainId: 5,
    name: 'Goerli Testnet',
    rpcUrl: 'https://goerli.infura.io/v3/...',
    blockExplorer: 'https://goerli.etherscan.io',
    nativeCurrency: { name: 'Goerli Ether', symbol: 'ETH', decimals: 18 },
  },
  polygon: {
    chainId: 137,
    name: 'Polygon Mainnet',
    rpcUrl: 'https://polygon-rpc.com',
    blockExplorer: 'https://polygonscan.com',
    nativeCurrency: { name: 'MATIC', symbol: 'MATIC', decimals: 18 },
  },
  mumbai: {
    chainId: 80001,
    name: 'Mumbai Testnet',
    rpcUrl: 'https://rpc-mumbai.maticvigil.com',
    blockExplorer: 'https://mumbai.polygonscan.com',
    nativeCurrency: { name: 'MATIC', symbol: 'MATIC', decimals: 18 },
  },
}

export const CONTRACT_ADDRESSES = {
  1: {  // Ethereum mainnet
    nft: '0x...',
    marketplace: '0x...',
    auction: '0x...',
  },
  5: {  // Goerli
    nft: '0x...',
    marketplace: '0x...',
    auction: '0x...',
  },
  137: {  // Polygon
    nft: '0x...',
    marketplace: '0x...',
    auction: '0x...',
  },
}
```

## Smart Contract Development

### Hardhat Configuration

```javascript
// hardhat.config.ts
import { HardhatUserConfig } from 'hardhat/config'
import '@nomicfoundation/hardhat-toolbox'

const config: HardhatUserConfig = {
  solidity: {
    version: '0.8.20',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    goerli: {
      url: process.env.GOERLI_RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
    mainnet: {
      url: process.env.MAINNET_RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
    polygon: {
      url: process.env.POLYGON_RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
}

export default config
```

### Deployment Script

```typescript
// scripts/deploy.ts
import { ethers, upgrades } from 'hardhat'

async function main() {
  // 1. Deploy NFT contract (upgradeable)
  const NFT = await ethers.getContractFactory('NFT')
  const nft = await upgrades.deployProxy(NFT, ['NFT Collection', 'NFT'], {
    initializer: 'initialize',
  })
  await nft.waitForDeployment()
  console.log('NFT deployed to:', await nft.getAddress())

  // 2. Deploy Marketplace
  const Marketplace = await ethers.getContractFactory('NFTMarketplace')
  const marketplace = await upgrades.deployProxy(Marketplace, [250], {
    initializer: 'initialize',
  })
  await marketplace.waitForDeployment()
  console.log('Marketplace deployed to:', await marketplace.getAddress())

  // 3. Deploy Auction
  const Auction = await ethers.getContractFactory('NFTAuction')
  const auction = await upgrades.deployProxy(Auction, [], {
    initializer: 'initialize',
  })
  await auction.waitForDeployment()
  console.log('Auction deployed to:', await auction.getAddress())

  // 4. Save addresses
  const addresses = {
    nft: await nft.getAddress(),
    marketplace: await marketplace.getAddress(),
    auction: await auction.getAddress(),
  }

  await fs.writeFile(
    './frontend/public/contracts/addresses.json',
    JSON.stringify(addresses, null, 2)
  )
}

main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
```

## Testing Strategy

### Smart Contract Tests

```typescript
// test/NFTMarketplace.test.ts
describe('NFTMarketplace', function () {
  let nft, marketplace, owner, seller, buyer

  beforeEach(async function () {
    ;[owner, seller, buyer] = await ethers.getSigners()

    const NFT = await ethers.getContractFactory('NFT')
    nft = await upgrades.deployProxy(NFT, ['Test NFT', 'TNFT'])

    const Marketplace = await ethers.getContractFactory('NFTMarketplace')
    marketplace = await upgrades.deployProxy(Marketplace, [250])

    // Mint NFT to seller
    await nft.connect(seller).mint(seller.address, 'ipfs://metadata', 250)
  })

  it('should list NFT for sale', async function () {
    const tokenId = 1
    const price = ethers.parseEther('1.0')

    await nft.connect(seller).approve(await marketplace.getAddress(), tokenId)
    await marketplace.connect(seller).listNFT(await nft.getAddress(), tokenId, price)

    const listing = await marketplace.listings(1)
    expect(listing.seller).to.equal(seller.address)
    expect(listing.price).to.equal(price)
  })

  it('should handle buy with platform fee and royalty', async function () {
    const tokenId = 1
    const price = ethers.parseEther('1.0')

    // List NFT
    await nft.connect(seller).approve(await marketplace.getAddress(), tokenId)
    await marketplace.connect(seller).listNFT(await nft.getAddress(), tokenId, price)

    // Buy NFT
    const buyerBalanceBefore = await ethers.provider.getBalance(buyer.address)
    const sellerBalanceBefore = await ethers.provider.getBalance(seller.address)

    await marketplace.connect(buyer).buyNFT(1, { value: price })

    // Check ownership transfer
    expect(await nft.ownerOf(tokenId)).to.equal(buyer.address)

    // Check payments (platform fee 2.5%, royalty 2.5%, seller gets 95%)
    const sellerBalanceAfter = await ethers.provider.getBalance(seller.address)
    const expectedPayment = (price * 95n) / 100n
    expect(sellerBalanceAfter - sellerBalanceBefore).to.be.closeTo(expectedPayment, ethers.parseEther('0.01'))
  })
})
```

### Frontend E2E Tests (Playwright)

```typescript
// e2e/marketplace.spec.ts
import { test, expect } from '@playwright/test'

test.describe('NFT Marketplace', () => {
  test.beforeEach(async ({ page }) => {
    // Connect MetaMask (using Synpress or custom wallet mock)
    await page.goto('/')
  })

  test('should mint NFT', async ({ page }) => {
    await page.click('text=Create')
    await page.fill('input[name="name"]', 'Test NFT')
    await page.fill('textarea[name="description"]', 'Test description')
    await page.setInputFiles('input[type="file"]', './test-image.png')
    await page.fill('input[name="royalty"]', '2.5')

    await page.click('button:has-text("Mint NFT")')

    // Wait for IPFS upload + transaction
    await expect(page.locator('text=NFT minted successfully')).toBeVisible({ timeout: 60000 })
  })

  test('should list and buy NFT', async ({ page }) => {
    await page.goto('/nft/1')
    await page.click('button:has-text("List for Sale")')
    await page.fill('input[name="price"]', '0.5')
    await page.click('button:has-text("List NFT")')

    // Wait for approval + listing transaction
    await expect(page.locator('text=Listed successfully')).toBeVisible({ timeout: 60000 })

    // Switch to buyer account
    // ... (account switching logic)

    await page.click('button:has-text("Buy for 0.5 ETH")')
    await expect(page.locator('text=Purchase successful')).toBeVisible({ timeout: 60000 })
  })
})
```

## Security Considerations

### Smart Contract Security

1. **Reentrancy Protection**: All contracts use `ReentrancyGuard` from OpenZeppelin
2. **Access Control**: `Ownable` pattern for admin functions
3. **Integer Overflow**: Solidity 0.8+ has built-in overflow checks
4. **Pull Payment Pattern**: Funds transferred immediately (no pull required)
5. **Gas Limit**: Avoid unbounded loops

### Frontend Security

1. **Input Validation**: Validate all user inputs before blockchain interaction
2. **Network Verification**: Check user is on correct network before transactions
3. **Gas Estimation**: Estimate gas before sending transaction
4. **Transaction Simulation**: Use `callStatic` to simulate before actual transaction
5. **Error Handling**: Graceful handling of reverted transactions

## Performance Optimizations

### Frontend

1. **The Graph**: Use indexed blockchain data instead of direct RPC calls
2. **IPFS Gateway**: Use fast IPFS gateway (Cloudflare, Pinata)
3. **Image Optimization**: Lazy load NFT images, use Next.js Image component
4. **Caching**: Cache NFT metadata in PostgreSQL
5. **Pagination**: Paginate NFT lists (50 per page)

### Smart Contracts

1. **Gas Optimization**: Pack struct variables efficiently
2. **Events**: Use events for frontend updates instead of storage reads
3. **Batch Operations**: Support bulk minting/listing where possible

## Environment Variables

```bash
# Frontend (.env.local)
NEXT_PUBLIC_CHAIN_ID=5
NEXT_PUBLIC_NFT_CONTRACT=0x...
NEXT_PUBLIC_MARKETPLACE_CONTRACT=0x...
NEXT_PUBLIC_AUCTION_CONTRACT=0x...
NEXT_PUBLIC_GRAPH_API_URL=https://api.thegraph.com/subgraphs/name/...
NEXT_PUBLIC_PINATA_API_KEY=...
NEXT_PUBLIC_PINATA_SECRET_KEY=...

# Hardhat (.env)
GOERLI_RPC_URL=https://goerli.infura.io/v3/...
MAINNET_RPC_URL=https://mainnet.infura.io/v3/...
POLYGON_RPC_URL=https://polygon-rpc.com
PRIVATE_KEY=0x...
ETHERSCAN_API_KEY=...
```

## Deployment Checklist

### Smart Contracts

- [ ] Audit smart contracts (Certik, OpenZeppelin, etc.)
- [ ] Deploy to testnet (Goerli, Mumbai)
- [ ] Test all functions on testnet
- [ ] Verify contracts on Etherscan
- [ ] Deploy to mainnet
- [ ] Transfer ownership to multisig wallet
- [ ] Set platform fee recipient

### Frontend

- [ ] Configure IPFS gateway (Pinata, Cloudflare)
- [ ] Deploy The Graph subgraph
- [ ] Set up PostgreSQL database
- [ ] Deploy frontend to Vercel
- [ ] Configure environment variables
- [ ] Test wallet connections (MetaMask, WalletConnect)
- [ ] Set up monitoring (Sentry for errors)

### Infrastructure

- [ ] CDN for static assets
- [ ] Database backups
- [ ] Error tracking (Sentry)
- [ ] Analytics (Google Analytics, Mixpanel)
- [ ] Rate limiting for API routes

## Business Model

### Revenue Streams

1. **Platform Fee**: 2.5% on all sales
2. **Featured Listings**: Pay to feature NFT on homepage
3. **Premium Accounts**: Verified badge, higher upload limits
4. **Auction Upgrades**: Extended auctions, reserve prices

### Projected MRR

- Low estimate: $50k MRR (2,000 sales/month @ $1k avg × 2.5% fee)
- High estimate: $500k MRR (20,000 sales/month @ $1k avg × 2.5% fee)

## Known Limitations

1. **Gas Costs**: High on Ethereum L1 (consider L2 like Polygon, Arbitrum)
2. **IPFS Reliability**: Need paid Pinata plan for guaranteed pinning
3. **The Graph Latency**: ~30 seconds for new data (use WebSocket for real-time)
4. **Wallet Support**: Limited to browser extension wallets (MetaMask, etc.)
5. **Mobile**: Limited mobile wallet support (consider WalletConnect)

## Future Enhancements

- [ ] Lazy minting (mint on first sale to save gas)
- [ ] Fractional NFT ownership (ERC-1155)
- [ ] NFT lending/borrowing
- [ ] Rarity scoring algorithm
- [ ] Portfolio tracking
- [ ] Social features (comments, likes)
- [ ] Mobile app (React Native)
- [ ] Layer 2 deployment (Polygon, Arbitrum, Optimism)
- [ ] Gasless transactions (meta-transactions)
- [ ] 3D NFT viewer (Three.js)

---

**Last Updated**: 2025-10-15
**Project Status**: Production-ready template
**Complexity**: Advanced (8-12 hours to complete)
