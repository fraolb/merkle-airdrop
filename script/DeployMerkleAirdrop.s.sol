// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {BagelToken} from "../src/BagelToken.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 private s_merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 private s_amountToTransfer = 4 * 25 * 1e18;

    function deployMerkleAirdrop() public returns (MerkleAirdrop, BagelToken) {
        vm.startBroadcast();
        BagelToken bagelToken = new BagelToken();
        MerkleAirdrop merkleAirdrop = new MerkleAirdrop(s_merkleRoot, IERC20(address(bagelToken)));
        bagelToken.mint(bagelToken.owner(), s_amountToTransfer);
        bagelToken.transfer(address(merkleAirdrop), s_amountToTransfer);
        vm.stopBroadcast();
    }

    function run() external returns (MerkleAirdrop, BagelToken) {
        return deployMerkleAirdrop();
    }
}
