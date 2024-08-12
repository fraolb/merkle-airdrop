// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Merkle Airdrop
 * @author Fraol Bereket
 * @notice This contract takes list of addresses and allow the addresses to claim tokens
 */
contract MerkleAirdrop is ERC20, Ownable {
    constructor() ERC20("Bagel", "BAGEL") Ownable(msg.sender) {}
}
