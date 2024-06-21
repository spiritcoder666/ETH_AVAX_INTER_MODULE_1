# GameToken Smart Contract

## Simple Overview
This project is a basic implementation of an Ethereum smart contract that creates and manages a custom cryptocurrency token called `GameToken`. The smart contract includes functionalities to recharge balances, redeem tokens, redeem items with tokens, and change the contract owner.

## Description
GameToken is a simple Solidity-based smart contract that demonstrates the fundamental operations of a cryptocurrency token. The contract defines public variables for the token name and total supply. It maintains a mapping of addresses to balances, allowing the contract to track the number of tokens each address holds. The `recharge` function increases the total supply and the balance of a specified address. The `redeem` and `redeemItem` functions decrease the total supply and the balance of a specified address, with checks to ensure the balance is sufficient for redeeming. Additionally, the contract allows the current owner to transfer ownership to a new address.

### Key Functions and Statements
- **`require`**: Used to ensure that certain conditions are met before executing a function. If the condition is not met, the transaction is reverted.
- **`assert`**: Used to check for conditions that should always be true. If the condition fails, it indicates a bug in the contract and the transaction is reverted.
- **`revert`**: Explicitly reverses the transaction, usually accompanied by an error message.

## Getting Started

### Installing
1. **Download the Project**
   - Clone the repository from GitHub:
     ```sh
     git clone https://github.com/spiritcoder666/gametoken-contract.git
     ```
   - Navigate to the project directory:
     ```sh
     cd gametoken-contract
     ```

2. **Open Remix IDE**
   - Go to [Remix IDE](https://remix.ethereum.org/).
   - In the file explorer, create a new file named `GameToken.sol`.

3. **Copy and Paste the Smart Contract Code**
   - Copy the following code and paste it into `GameToken.sol`:
     ```solidity
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
     ```

### Executing Program

#### How to Run the Program in Remix
1. **Compile the Smart Contract**
   - Select the `Solidity Compiler` tab.
   - Ensure the compiler version is set to `0.8.0` or above.
   - Click `Compile GameToken.sol`.

2. **Deploy the Contract**
   - Go to the `Deploy & Run Transactions` tab.
   - Select the appropriate environment (e.g., JavaScript VM).
   - Click `Deploy`.

3. **Interact with the Contract**
   - After deploying, the contract will appear under `Deployed Contracts`.
   - To recharge tokens:
     - Input the address and the amount of tokens to recharge.
     - Click the `recharge` button.
   - To redeem tokens:
     - Input the address and the amount of tokens to redeem.
     - Click the `redeem` button.
   - To redeem items with tokens:
     - Input the address, the amount of tokens, and the item description.
     - Click the `redeemItem` button.
   - To change the owner:
     - Input the new owner's address.
     - Click the `changeOwner` button.

## Help

### Common Issues
- **Compilation Errors:** Ensure the Solidity version specified matches the version set in the Remix compiler.
- **Deployment Errors:** Make sure the selected environment is correct and the contract is compiled without errors.
- **Interaction Errors:** Ensure the address and value inputs are valid and that sufficient balance exists for redeeming tokens.

For detailed debugging and assistance, refer to the Remix documentation or community forums.

## Authors
- **Rohit**
  - GitHub: [NICxKMS](https://github.com/spiritcoder666)
 

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
