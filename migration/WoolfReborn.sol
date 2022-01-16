// SPDX-License-Identifier: NO LICENSE  

pragma solidity ^0.8.0;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "./Barn.sol";
import "./interfaces/IWoolfMetadata.sol";

contract WoolfReborn is 
  Initializable, 
  ERC721Upgradeable, 
  OwnableUpgradeable, 
  PausableUpgradeable
{

  /*

  Security notes
  ==============

  - Ignoring Slither reentrancy warning by in migrate() because called contract is trusted & call / state change order is intended
  - No need for safeTransferFrom here, using transferFrom so we don't have to worry about callbacks
  - We don't do explicit prevent attempts of multiple claims of the same tokenID. _mint will fail if the tokenID already exists

  */

  mapping(address => bool) public controllers;

  uint256 constant public ORIGINAL_SUPPLY = 13809;
  uint256 public minted;

  Woolf public woolf;
  Barn public barn;
  IWoolfMetadata public originalMetadata;
  IWoolfMetadata public unoriginalMetadata;

  /** 
   * initializes contract
   * @param _woolf address of original woolf contract
   * @param _barn address of original barn contract
   */
  function initialize(address _woolf, address _barn) external initializer {
    __Ownable_init();
    __Pausable_init();
    __ERC721_init("Wolf Game", "WGAME");

    woolf = Woolf(_woolf);
    barn = Barn(_barn);
    originalMetadata = IWoolfMetadata(_woolf);

    minted = ORIGINAL_SUPPLY;

    _pause();
  }

  /** EXTERNAL */

  /**
   * creates identical tokens in the new contract
   * and burns any original tokens that are not in the barn
   * @param tokenIds the ids of the tokens to migrate
   */
  function migrate(uint256[] calldata tokenIds) external whenNotPaused {
    for (uint i = 0; i < tokenIds.length; i++) {
      (address owner, bool inBarn) = _ownerOf(tokenIds[i]);
      require(owner == _msgSender(), "STOP! THIEF!");
      if (!inBarn) _attemptBurn(_msgSender(), tokenIds[i]);
      _mint(_msgSender(), tokenIds[i]); // built-in duplicate protection
    }
  }

  /**
   * mints a new ERC721
   * @dev must implement correct checks on controller contract for allowed mints
   * @param recipient address to mint the token to
   */
  function mint(address recipient) external whenNotPaused {
    require(controllers[_msgSender()], "Only controllers can mint");
    _mint(recipient, ++minted);
  }

  /** INTERNAL */

  /**
   * burns a token if its not currently in the barn
   * @param owner the owner of the legacy token
   * @param tokenId id of the token to burn
   */
  function _attemptBurn(address owner, uint256 tokenId) internal {
    woolf.transferFrom(owner, address(0xdead), tokenId);
  }

  /**
   * checks if a token is a Sheep
   * @param sheepWolfId the ID of the token to check
   * @return sheep - whether or not a token is a Sheep
   */
  function _isSheep(uint256 sheepWolfId) internal view returns (bool sheep) {
    (sheep, , , , , , , , , ) = woolf.tokenTraits(sheepWolfId);
  }

  /**
   * gets the alpha score for a Wolf
   * @param sheepWolfId the ID of the Wolf to get the alpha score for
   * @return the alpha score of the Wolf (5-8)
   */
  function _alphaForWolf(uint256 sheepWolfId) internal view returns (uint8) {
    ( , , , , , , , , , uint8 alphaIndex) = woolf.tokenTraits(sheepWolfId);
    return 8 - alphaIndex; // alpha index is 0-3
  }

  /**
   * gets the owner / staker of a sheep / wolf
   * @param sheepWolfId the ID of the Wolf to get the alpha score for
   * @return owner - the owner of the token
   * @return inBarn - whether or not it's currently in the barn
   */
  function _ownerOf(uint256 sheepWolfId) internal view returns (address owner, bool inBarn) {
    owner = woolf.ownerOf(sheepWolfId);
    if (owner != address(barn)) return (owner, false);
    if (_isSheep(sheepWolfId)) {
      ( , , owner) = barn.barn(sheepWolfId);
    } else {
      uint256 index = barn.packIndices(sheepWolfId);
      ( , , owner) = barn.pack(_alphaForWolf(sheepWolfId), index);
    }
    return (owner, true);
  }

  /** ADMIN */

  /**
   * enables owner to pause / unpause minting
   */
  function setPaused(bool _paused) external onlyOwner {
    if (_paused) _pause();
    else _unpause();
  }

  /**
   * sets the proxied values of the metadata for the original tokens
   * @param _metadata an address that conforms to IWoolfMetadata
   */
  function setOriginalMetadata(address _metadata) external onlyOwner {
    originalMetadata = IWoolfMetadata(_metadata);
  }

  /**
   * sets the proxied values of the metadata for any tokens beyond the original ones
   * @param _metadata an address that conforms to IWoolfMetadata
   */
  function setUnoriginalMetadata(address _metadata) external onlyOwner {
    unoriginalMetadata = IWoolfMetadata(_metadata);
  }

  /**
   * enables an address to mint / burn
   * @param controller the address to enable
   */
  function addController(address controller) external onlyOwner {
    controllers[controller] = true;
  }

  /**
   * disables an address from minting / burning
   * @param controller the address to disbale
   */
  function removeController(address controller) external onlyOwner {
    controllers[controller] = false;
  }

  /** RENDER */

  /**
   * proxies tokenURI to whichever contract hosts the data
   */
  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
    if (tokenId <= ORIGINAL_SUPPLY) {
      return originalMetadata.tokenURI(tokenId);
    } else {
      return unoriginalMetadata.tokenURI(tokenId);
    }
  }
}