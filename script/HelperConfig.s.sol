// SPDX-License-Identifier: MIT

// Deploy mocks when we are on a local anvil chain
// Keep track of contract address across different chains
// Sepolia ETH/USD
// Mainnet ETH/USD

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script {
    // If we are on a local anvil chain, we deploy mocks
    // Otherwise grab the existing address from the live network
    NetworkConfig public activeNetworkConfig;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8; //2000 USD

    struct NetworkConfig {
        address pricefeed; //ETH/USD price feed address
    }

    constructor() {
        if (block.chainid == 11155111) {
            //Sepolia
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            //Mainnet
            activeNetworkConfig = getMainnetEthConfig();
        } else {
            //Anvil
            activeNetworkConfig = getorCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        //price feed address
        NetworkConfig memory sepoliaConfig = NetworkConfig({pricefeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaConfig;
    }

    function getMainnetEthConfig() public pure returns (NetworkConfig memory) {
        //price feed address
        NetworkConfig memory ethConfig = NetworkConfig({pricefeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});
        return ethConfig;
    }

    function getorCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        if (activeNetworkConfig.pricefeed != address(0)) {
            return activeNetworkConfig;
        }

        //Deploy the mocks
        //Return the mock address

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({pricefeed: address(mockPriceFeed)});
        return anvilConfig;
    }
}
