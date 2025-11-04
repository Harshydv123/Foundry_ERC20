# 🪙 OurToken (ERC20)

A simple yet complete ERC-20 token project built with [Foundry](https://book.getfoundry.sh/) and [OpenZeppelin](https://docs.openzeppelin.com/contracts/) contracts.

---

## 📘 Overview

**OurToken (OT)** is an ERC-20–compliant smart contract implemented using OpenZeppelin’s standard libraries.  
It comes with a deployment script and unit tests written in Foundry.

This project demonstrates:
- How to create and deploy an ERC-20 token.
- How to write Forge tests for token functionality.
- How to automate deployment with Foundry scripting.

---

## ⚙️ Tech Stack

- **Solidity** `^0.8.30`
- **Foundry** (Forge & Cast)
- **OpenZeppelin Contracts** `@openzeppelin/contracts`
- **GPG-signed commits (optional)** for verified contributions

---

## 🧩 Project Structure

├── src/
│ └── OurToken.sol # Main ERC20 token contract
│
├── script/
│ └── DeployOurToken.s.sol # Deployment script using Foundry's Script
│
├── test/
│ └── OurToken.t.sol # Comprehensive Forge test suite
│
├── foundry.toml # Foundry configuration
├── Makefile # Common build/test commands
└── README.md

yaml
Copy code

---

## 💻 Contract Details

### `OurToken.sol`
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract OurToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("OurToken", "OT") {
        _mint(msg.sender, initialSupply);
    }
}
✅ Features:

Standard ERC-20 functionality (transfer, approve, allowance)

Configurable initial supply minted to the deployer

Uses OpenZeppelin’s battle-tested ERC-20 implementation

🚀 Deployment
1️⃣ Compile the contracts
bash
Copy code
forge build
2️⃣ Run tests
bash
Copy code
forge test
3️⃣ Deploy locally (Anvil)
Start a local chain:

bash
Copy code
anvil
Deploy using Foundry’s script:

bash
Copy code
forge script script/DeployOurToken.s.sol:DeployOurToken --rpc-url http://127.0.0.1:8545 --broadcast
To deploy to a live network (e.g., Sepolia or Mainnet):

bash
Copy code
forge script script/DeployOurToken.s.sol:DeployOurToken \
    --rpc-url $SEPOLIA_RPC_URL \
    --private-key $PRIVATE_KEY \
    --broadcast \
    --verify
🧪 Tests
Run the test suite:
bash
Copy code
forge test -vv
The tests cover:

✅ Token name & symbol

✅ Initial supply and balances

✅ Transfers & reverts for insufficient balances

✅ Approvals and allowances

✅ TransferFrom behavior

✅ Total supply consistency

Example test output:

less
Copy code
Ran 10 tests for test/OurToken.t.sol
[PASS] testTransferFromWorksWithAllowance() (gas: 29240)
[PASS] testTotalSupplyRemainsConstantAfterTransfers() (gas: 18832)
All tests passed (10/10)
🧠 Key Concepts
ERC-20 Standard: A widely used token standard on Ethereum that defines how tokens can be transferred and tracked.

Foundry Scripts: Allow automated deployments using forge script and vm.startBroadcast().

Testing with Forge: Gives you fast, Solidity-native testing with cheatcodes like vm.prank() and vm.expectRevert().

🛠️ Requirements
Make sure you have:

Foundry installed

Node.js (optional, for tooling)

An Ethereum RPC (e.g., Alchemy, Infura)

🌐 License
This project is licensed under the MIT License.
See the LICENSE file for details.

👤 Author
Harsh Yadav (@Harshydv123)
💼 Smart Contract Developer | Solidity & Foundry Enthusiast
📧 harsh.yadav.948585@gmail.com

⭐️ Support
If you found this project useful, consider giving it a ⭐ on GitHub!

🧭 Next Steps
Extend token with mint/burn functions.

Add EIP-2612 (permit) support for gasless approvals.

Integrate with a frontend using ethers.js or wagmi.

“The best way to learn Solidity is by deploying real code — not just reading about it.” ✨
