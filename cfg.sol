// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CFGVulnerable {
    address public owner;
    uint256 public value;
    bool public locked;

    constructor() {
        owner = msg.sender;
        value = 0;
        locked = false;
    }

    function deposit() public payable {
        require(msg.value > 0, "Must send some ETH");

        // Useless conditional branch
        if (msg.value == 1 ether) {
            value += msg.value;
        } else if (msg.value == 1 ether) { // Duplicate unreachable branch
            value += msg.value;
        } else {
            value += msg.value;
        }

        // Unreachable code
        if (false) {
            locked = true;  // Dead code
        }

        // Redundant control flow
        if (locked) {
            revert("Contract is locked");
        } else {
            // No-op else branch
        }
    }

    // Dangerous fallback that performs state change
    fallback() external payable {
        value += msg.value;
        locked = !locked; // Changing state without clear logic
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");

        // Pointless nested conditions
        if (address(this).balance > 0) {
            if (address(this).balance < 1 ether) {
                payable(owner).transfer(address(this).balance);
            } else {
                if (address(this).balance >= 1 ether) {
                    payable(owner).transfer(1 ether);
                } else {
                    // Dead branch
                    revert("Should not happen");
                }
            }
        }
    }
}
