// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Author : Rohit

contract GameToken {
    string public name = "GameToken";
    mapping (address => uint256) public balances;
    uint256 public totalSupply;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function recharge(address _address, uint256 _val) public onlyOwner {
        uint256 oldTotal = totalSupply;
        balances[_address] += _val;
        totalSupply += _val;
        assert(totalSupply == oldTotal + _val);
    }

    function getTotalSupply() view public returns (uint256) {
        return totalSupply;
    }

    function redeem(address _address, uint256 _val) public {
        require(_val <= balances[_address], "Insufficient balance to redeem");
        uint256 oldTotal = totalSupply;
        balances[_address] -= _val;
        totalSupply -= _val;
        assert(totalSupply == oldTotal - _val);
    }

    function redeemItem(address _address, uint256 _val, string memory _item) public {
        require(_val <= balances[_address], "Insufficient balance to redeem item");
        uint256 oldTotal = totalSupply;
        balances[_address] -= _val;
        totalSupply -= _val;
        assert(totalSupply == oldTotal - _val);
    }

    function changeOwner(address _newOwner) public {
        if (msg.sender != owner) {
            revert("Requires owner to personally change to new owner");
        }
        owner = _newOwner;
    }
}
