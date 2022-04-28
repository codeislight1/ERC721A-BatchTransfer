// SPDX-License-Identifier: MIT
// Creator: Chiru Labs

pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC721/IERC721.sol';
import '@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol';

/**
 * @dev Interface of an ERC721A compliant contract.
 */
interface IERC721A is IERC721, IERC721Metadata {
    error ApprovalCallerNotOwnerNorApproved();
    error ApprovalQueryForNonexistentToken();
    error ApproveToCaller();
    error ApprovalToCurrentOwner();
    error BalanceQueryForZeroAddress();
    error MintToZeroAddress();
    error MintZeroQuantity();
    error OwnerQueryForNonexistentToken();
    error TransferCallerNotOwnerNorApproved();
    error TransferFromIncorrectOwner();
    error BatchTransferFromNonConsecutiveToken();
    error QueryForNonexistentToken();
    error BatchTransferFromIncorrectOwner();
    error TransferToNonERC721ReceiverImplementer();
    error TransferToZeroAddress();
    error URIQueryForNonexistentToken();
    // Compiler will pack this into a single 256bit word.
    struct TokenOwnership {
        // The address of the owner.
        address addr;
        // Keeps track of the start time of ownership with minimal overhead for tokenomics.
        uint64 startTimestamp;
        // Whether the token has been burned.
        bool burned;
    }

    // Compiler will pack this into a single 256bit word.
    struct AddressData {
        // Realistically, 2**64-1 is more than enough.
        uint64 balance;
        // Keeps track of mint count with minimal overhead for tokenomics.
        uint64 numberMinted;
        // Keeps track of burn count with minimal overhead for tokenomics.
        uint64 numberBurned;
        // For miscellaneous variable(s) pertaining to the address
        // (e.g. number of whitelist mint slots used).
        // If there are multiple variables, please pack them into a uint64.
        uint64 aux;
    }

    /**
     * @dev Returns the total amount of tokens stored by the contract.
     * @dev Burned tokens are calculated here, use _totalMinted() if you want to count just minted tokens.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns if the parameters are eligible for BatchTransfer
     */
    function isBatchTransferable(
        address from,
        address to,
        uint256 lowerTokenId,
        uint256 upperTokenId
    ) external view returns (bool);

    /**
     * @dev Transfers [`lowerTokenId`, `upperTokenId`] tokens from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeBatchTransferFrom} whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `lowerTokenId` token must be owned by `from`.
     * - `upperTokenId` token must be owned by zero address
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits multiple {Transfer} event.
     */
    function batchTransferFrom(
        address from,
        address to,
        uint256 lowerTokenId,
        uint256 upperTokenId
    ) external;

    /**
     * @dev Safely transfers [`lowerTokenId`, `upperTokenId`] tokens from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `lowerTokenId` token must be owned by `from`.
     * - `upperTokenId` token must be owned by zero address
     * - If the caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256 lowerTokenId,
        uint256 upperTokenId
    ) external;

    /**
     * @dev Safely transfers [`lowerTokenId`, `upperTokenId`] tokens from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `lowerTokenId` token must be owned by `from`.
     * - `upperTokenId` token must be owned by zero address
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256 lowerTokenId,
        uint256 upperTokenId,
        bytes memory _data
    ) external;
}
