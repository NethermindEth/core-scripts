# gen2spec.jq

Transforms Geth genesis into Nethermind chainspec.
<br>Supports Ethereum L1, OP, Taiko

Usage:

```sh
cat genesis.json | jq --from-file gen2spec.jq > chainspec.json
```

Based on https://github.com/ethereum/hive