# Wolf Game Bug Bounty Repo

This repository contains the code that will be used for the migration of the legacy Wolf Game NFTs to their new contract.

## Bug Bounty

I am offering up to $50,000 as a bounty for any vulnerabilities found. The amount received by the party that notifies me of a vulnerability will be determined based on severity.

Vulnerabilities should be submitted via this [Google Form](https://docs.google.com/forms/d/e/1FAIpQLSfWr5PxOq5NhFEG8jgPAG8IcTRDyj_X1M-RIwPNg8z6iBM3Kg/viewform) and the first submitter of any vulnerability will be eligible.

## Code For Review

The scope of the Bug Bounty is for the new contract: [WoolfReborn.sol](contracts/WoolfReborn.sol). Only this new, specifically named smart contracts is in scope. Bugs in the already deployed smart contracts are not eligible for a bounty.

## Referenced smart contract

For reference, here are the already deployed smart contracts that get called during the migration. Please note that bugs in the old contracts do not qualify for a bounty unless they directly affect the migration.

- [Legacy Wolf Game NFT v1](https://etherscan.io/address/0xeb834ae72b30866af20a6ce5440fa598bfad3a42#code)
- [Legacy Barn](https://etherscan.io/address/0x29205f257F9E3B78bcb27e253D0f3Fad9D7522a2#code)

## 

Happy Hunting,
The Shepherd & The Herdsman
