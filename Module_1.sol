// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Author: ChatGPT

contract GameToken {
    string public tokenName = "GameToken";
    mapping (address => uint256) public tokenBalances;
    uint256 public totalTokens;
    address public tokenOwner;

    modifier onlyTokenOwner() {
        require(msg.sender == tokenOwner, "Only owner can perform this action");
        _;
    }

    constructor() {
        tokenOwner = msg.sender;
    }

    function rechargeTokens(address _address, uint256 _amount) public onlyTokenOwner {
        uint256 oldTotal = totalTokens;
        tokenBalances[_address] += _amount;
        totalTokens += _amount;
        assert(totalTokens == oldTotal + _amount);
    }

    function getTotalTokens() view public returns (uint256) {
        return totalTokens;
    }

    function redeemTokens(address _address, uint256 _amount) public {
        require(_amount <= tokenBalances[_address], "Insufficient balance to redeem");
        uint256 oldTotal = totalTokens;
        tokenBalances[_address] -= _amount;
        totalTokens -= _amount;
        assert(totalTokens == oldTotal - _amount);
    }

    function redeemItemTokens(address _address, uint256 _amount ) public {
        require(_amount <= tokenBalances[_address], "Insufficient balance to redeem item");
        uint256 oldTotal = totalTokens;
        tokenBalances[_address] -= _amount;
        totalTokens -= _amount;
        assert(totalTokens == oldTotal - _amount);
    }

    function changeTokenOwner(address _newOwner) public {
        if (msg.sender != tokenOwner) {
            revert("Requires owner to personally change to new owner");
        }
        tokenOwner = _newOwner;
    }
}
