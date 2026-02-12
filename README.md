# Minimal On-Chain NFT (SVG)

This repository demonstrates how to store NFT assets entirely on the blockchain. Instead of linking to an external image (like IPFS), the smart contract generates an SVG image and JSON metadata dynamically in real-time.

## How it Works
1. **SVG Construction**: The contract concatenates strings to form an XML-based SVG.
2. **Base64 Encoding**: The SVG and JSON are encoded into Base64 strings.
3. **Data URI**: The `tokenURI` function returns a `data:application/json;base64,...` string directly to the caller.

## Advantages
- **Permanence**: As long as the blockchain exists, the art exists.
- **Composable**: Other contracts can "read" the image data directly.
- **Zero Fees**: No need to pay for external pinning services.

## Tech Stack
- Solidity ^0.8.20
- OpenZeppelin Contracts
- Base64 Utility Library
