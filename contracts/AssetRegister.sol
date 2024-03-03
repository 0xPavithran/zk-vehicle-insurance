// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AssetRegister {
    event LogAssetRegistered(address indexed assetId, uint256 value, bytes information);

    struct Insurance {
        uint256 value;
        bytes information;
        address creator;
        bool exist;
        bool claimed;
    }

    mapping(address => Insurance) public Insurance;

    function registerAsset(uint256 Value, bytes memory In_formation) public {
        address A = sha256(abi.encodePacked(Value, In_formation, msg.sender, block.number));

        // Ensure asset hasn't been registered previously
        require(!Insurance[A].exist, "Asset already registered");

        // Store asset data
        Insurance[A].value = Value;
        Insurance[A].information = In_formation;
        Insurance[A].creator = msg.sender;
        Insurance[A].exist = true;
        Insurance[A].claimed = false;

        emit LogAssetRegistered(A, Value, In_formation);
    }
}
