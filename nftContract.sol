// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
// URI : https://ipfs.filebase.io/ipfs/QmQvxS3Rm6fcnTuF6VyKv4rSGVXPCReqtiiTcrknLzScH4
import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";

import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";

contract StalkNftSEarlyUser is ERC721, ERC721Enumerable, ERC721URIStorage{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAX_SUPPLY = 1000;
    constructor() ERC721("Stalk Nft's Early User", "Stlk") {}
    struct counter{
        uint256 mintedNfts;
    }
    mapping(address => counter) mintCounter;
    function safeMint(address to, string memory uri) public{
        uint256 tokenId = _tokenIdCounter.current();

       require(tokenId<MAX_SUPPLY,"You have reached max supply,sry");
       mintCounter[msg.sender].mintedNfts += 1;
       require(mintCounter[msg.sender].mintedNfts<=5,"You have reached max minting limit ");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
