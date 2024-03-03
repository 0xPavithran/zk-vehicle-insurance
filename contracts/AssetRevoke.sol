// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AssetRevoke {
    event LogAssetRevocation(address indexed assetId);

    struct Insurance {
        // ... other fields
        bool exist;
        bool claimed;
    }

    mapping(address => Insurance) public Insurance;

    function revokeAsset(address A) public returns (bool) {
        // 1: creator = creatorQuery(A);
        address creator = creatorQuery(A);

        // 2: if msg.sender == creator then
        if (msg.sender == creator) {
            // 3: Insurance[A].claimed = true; (using exist for revocation instead of claimed)
            Insurance[A].exist = false; // Mark the asset as revoked

            // 4: emit LogAssetRevocation(A);
            emit LogAssetRevocation(A);

            // 5: return True;
            return true;
        }

        // 6: end if

        // 7: return False;
        return false;
    }

    // Helper function to query asset creator
    function creatorQuery(address A) public view returns (address) {
        return Insurance[A].creator;
    }
}
