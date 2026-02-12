// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract OnChainNFT is ERC721 {
    using Strings for uint256;

    uint256 private _nextTokenId;

    constructor() ERC721("OnChainDots", "DOT") {}

    function mint() public {
        _safeMint(msg.sender, _nextTokenId);
        _nextTokenId++;
    }

    function generateSVG(uint256 tokenId) public pure returns (string memory) {
        return string(abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            '<style>.base { fill: white; font-family: serif; font-size: 24px; }</style>',
            '<rect width="100%" height="100%" fill="black" />',
            '<circle cx="175" cy="175" r="50" fill="red" />',
            '<text x="50%" y="80%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Token #", tokenId.toString(),
            '</text></svg>'
        ));
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);

        string memory image = Base64.encode(bytes(generateSVG(tokenId)));
        string memory json = Base64.encode(bytes(string(abi.encodePacked(
            '{"name": "OnChain Dot #', tokenId.toString(), 
            '", "description": "A fully on-chain SVG NFT", "image": "data:image/svg+xml;base64,', 
            image, '"}'
        ))));

        return string(abi.encodePacked("data:application/json;base64,", json));
    }
}
