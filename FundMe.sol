// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConvertor} from "./PriceConvertor.sol";

error NotOwner();
contract FundMe {
    using PriceConvertor for uint256;

    address public immutable i_owner;
    uint256 public constant MINIMUM_USD = 5e18;
    address[] public funders;
    mapping(address => uint256) public addressesToFunded;

    // Set the contract owner to the deployer
    constructor() {
        i_owner = msg.sender;
    }

    // Ensure only the owner can call certain functions
    modifier onlyOwner {
        if(msg.sender != i_owner ){ revert NotOwner();}
        _;
    }

    // Allow users to fund the contract
    function fund() public payable {
        // Ensure the sent amount meets the minimum USD requirement
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Insufficient Ether sent");
        
        funders.push(msg.sender);
        addressesToFunded[msg.sender] += msg.value;
    }

    // Allow the owner to withdraw all funds
    function withdraw() public onlyOwner {
        // Reset funder balances
        for (uint256 fundersIndex = 0; fundersIndex < funders.length; fundersIndex++) {
            address funder = funders[fundersIndex];
            addressesToFunded[funder] = 0;
        }
        
        // Reset funders array
        funders = new address[](0);

        // Transfer the contract balance to the owner
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Transfer failed");
    }
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

 
}
