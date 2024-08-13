// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {BagelToken} from "../src/BagelToken.sol";

contract MerkleAirdropTest is Test {
    MerkleAirdrop public merkleAirdrop;
    BagelToken public bagelToken;

    bytes32 public ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public AMOUNT_TO_CLAIM = 25 * 1e18;
    uint256 public AMOUNT_TO_SEND = 4 * AMOUNT_TO_CLAIM;
    bytes32 proofOne = 0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
    bytes32 proofTwo = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;

    bytes32[] public PROOF = [proofOne, proofTwo];
    address user;
    uint256 userPrivKey;

    function setUp() public {
        bagelToken = new BagelToken();
        merkleAirdrop = new MerkleAirdrop(ROOT, bagelToken);
        bagelToken.mint(bagelToken.owner(), AMOUNT_TO_SEND);
        bagelToken.transfer(address(merkleAirdrop), AMOUNT_TO_SEND);
        (user, userPrivKey) = makeAddrAndKey("user");
    }

    function testUserCanCliam() public {
        uint256 startingBalance = bagelToken.balanceOf(user);

        vm.prank(user);
        merkleAirdrop.claim(user, AMOUNT_TO_CLAIM, PROOF);

        uint256 endingBalance = bagelToken.balanceOf(user);
        console.log("endingBalance", endingBalance);
        assertEq(endingBalance - startingBalance, AMOUNT_TO_CLAIM);
    }
}
