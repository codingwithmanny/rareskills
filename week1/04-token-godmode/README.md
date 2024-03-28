# Rareskills Token God Mode

An ERC20 fungible token that allows for the deployer to have god mode over transferring all tokens.

## Requirements

- forge `v0.2.0` or greater

## Quick Setup

### 1 - Install Dependencies

```bash
# FROM: ./week1/04-token-godmode

forge install;
```

### 2 - Run Tests

```bash
# FROM: ./week1/04-token-godmode

forge test -vvv;

# [Expected Output]:
# [⠒] Compiling...
# [⠊] Compiling 1 files with 0.8.20
# [⠒] Solc 0.8.20 finished in 908.51ms
# Compiler run successful!
# 
# Ran 5 tests for test/TokenGodMode.t.sol:TokenSanctionsTest
# [PASS] test_checkSupply() (gas: 27101)
# [PASS] test_godAddress() (gas: 12724)
# [PASS] test_initialTokenTransfer() (gas: 75221)
# [PASS] test_setGodTransferFails() (gas: 28758)
# [PASS] test_setGodTransferSucceeds() (gas: 77539)
# Suite result: ok. 5 passed; 0 failed; 0 skipped; finished in 6.95ms (3.12ms CPU time)
# 
# Ran 1 test suite in 186.45ms (6.95ms CPU time): 5 tests passed, 0 failed, 0 skipped (5 total tests)
```

## Deploy Contract

### 1 - Create Environment Variables

```bash
# FROM: ./week1/04-token-godmode

cp .env.example .env;
```

Modify as needed:

**File:** `./week1/04-token-godmode/.env`

```bash
WALLET_PRIVATE_KEY="<YOUR_WALLET_PRIVATE_KEY>"
```

### 2 - Deploy Contract

```bash
# FROM: ./week1/04-token-godmode

forge script script/TokenGodMode.s.sol --rpc-url https://artio.rpc.berachain.com/ --broadcast;

# [Expected Output]:
# Compiler run successful!
# Script ran successfully.
# 
# == Logs ==
#   5678
# ...
# ✅  [Success]Hash: 0x69aeb8ee5084c44cce00cae2fda3563bd10efb9c8c663ec7b6a6929d6d48a50e
# Contract Address: 0x01870EC5C7656723b31a884259537B183FE15Fa7
# Block: 68764
```

## Author

[@codingwithmanny](https://github.com/codingwithmanny)