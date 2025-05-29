# gen2spec.jq

Transforms Geth genesis into Nethermind chainspec.<br>
Supports Ethereum L1, clique, OP, Taiko

Usage:

```sh
cat genesis.json | jq --from-file gen2spec.jq > chainspec.json
```

Taiko's pnpm genesis:gen genesis generator provides clique config, needs some corrections in part of forks, difficulty, and mentioning taiko. The line below also sets ontakeBlock to 1, correct with block number you need to fork at

```sh
cat genesis.json | jq ". * {difficulty: 0, config: {taiko: true, londonBlock: 0, ontakeBlock: 1, shanghaiTime: 0}} | del(.config.clique)" | jq --from-file gen2spec.jq > chainspec.json
```

Based on https://github.com/ethereum/hive
