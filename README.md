
## Install Sui 
```
cargo install --locked --git https://github.com/MystenLabs/sui.git --branch releases/sui-v0.26.0-release sui
```

# Deploy
```
sui client publish suistart --gas-budget 30000
```

# Mint
```
sui client call --gas-budget 30000 --package <ADDRESS> --module suistart --function mint --args <TREASURY_CAP_OBJECT>
```
