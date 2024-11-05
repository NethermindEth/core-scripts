# gen2spec.jq

Transforms Geth genesis into Nethermind chainspec.
<br>Supports Ethereum L1, OP, Taiko

Usage:

```sh
cat genesis.json | jq --from-file gen2spec.jq > chainspec.json
# Taiko's pnpm genesis:gen genesis generator has some issues with forks, difficulty, and mentioning taiko
cat genesis.json | jq ". * {difficulty: 0, config: {taiko: true, londonBlock: 0, ontakeBlock: 1, shanghaiTime: 0}} | del(.config.clique)" | jq --from-file gen2spec.jq > chainspec.json
```

Based on https://github.com/ethereum/hive