# Wolf Game Bug Bounty Repo

This repository contains the code that will be used for the full game.

## Overview

These contracts serve two key purposes:
1. WoolBridge.sol allows for WOOL to be deposited into the game (and burned in the process), and withdrawn from the game (and minted in the process).
2. WoolfGen2.sol is an ERC-721 contract for Gen 2 Sheep and Wolves. WolfGameBridge.sol is able to mint these Sheep and Wolves on behalf of users who breed them in the game.

## Bug Bounty

I am offering up to $50,000 as a bounty for any vulnerabilities found. The amount received by the party that notifies me of a vulnerability will be determined based on severity.

Vulnerabilities should be submitted via this [Google Form](https://docs.google.com/forms/d/e/1FAIpQLSfWr5PxOq5NhFEG8jgPAG8IcTRDyj_X1M-RIwPNg8z6iBM3Kg/viewform) and the first submitter of any vulnerability will be eligible.

## Code For Review

The scope of the Bug Bounty is for the new contracts: WoolfGen2.sol, WoolBridge.sol, and WolfGameBridge.sol. Only these new, specifically named smart contracts are in scope. Bugs in the already deployed smart contracts are not eligible for a bounty.

## 

Happy Hunting,
The Shepherd & The Herdsman
