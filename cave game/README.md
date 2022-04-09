# Cave Game Bug Bounty
​
This repository contains the code that will be used for Cave Game
​
## Bug Bounty
​
I am offering up to $50,000 as a bounty for any vulnerabilities found. The amount received by the party that notifies me of a vulnerability will be determined based on severity.
​
The purpose of the Cave Game contracts is to enable off-chain generation of signed messages that allow users to claim assets on-chain. CaveGame.sol implements a claim method that requires a signature from an administrative private signing key. FarmerGems are an ERC-1155 that can be minted by controller contracts. The non-standard operation on FarmerGems is that the administrator is able to burn them in bulk. This will be used after the Gem submission deadline for Farmer reveal to ensure there are no tokens leftover with expected utility. The code is documented in-line for functionality. 
​
Vulnerabilities should be submitted via this [Google Form](https://docs.google.com/forms/d/e/1FAIpQLSfWr5PxOq5NhFEG8jgPAG8IcTRDyj_X1M-RIwPNg8z6iBM3Kg/viewform) and the first submitter of any vulnerability will be eligible.
​
## Scope of the bounty
​
### Smart contract code review
​
The scope of the Bug Bounty contains the smart contracts: CaveGame.sol, FarmerGem.sol, and IControllable1155.sol. Only these new, specifically named smart contracts are in scope.
​
Note: Surprise1 is a standard ERC721 contract and Surprise2 is a standard ERC1155 with controller mint capabilities, identical to those in FarmerGem.sol.
​
### Blackbox testing of web components
​
Since the release of Allegiance, the team has researched L2 bridge technologies and developed an internal proof-of-concept for Wolf Game on L2. However, we have decided that for this interim game we would explore hybrid on-chain / off-chain capabilities to build an interactive experience. Therefore, we have decided to build a serverless backend for Cave Game.
​
Once the game is deployed, issues in the backend are also within scope. We will consider all types of web application and infrastructure vulnerabilities (RCE, XSS, authentication bypass,...) except DOS/DDOS. Feel free to use your methods of choice, even if the only true weapon is the sharpness of your mind. We are not planning to publish the source code for the backend.
​
Happy Hunting,
The Shepherd & The Herdsman