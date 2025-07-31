# gen2spec.jq

Transforms Geth genesis into Nethermind chainspec.<br>
Supports Ethereum L1, clique, OP, Taiko

## Usage

### Regular Ethereum and OP chains

```sh
cat genesis.json | jq --from-file gen2spec.jq > chainspec.json
```

### Taiko

`pnpm genesis:gen` genesis generator creates clique config, which needs to be corrected in part of forks, difficulty, and mentioning taiko. The line below also sets ontake and pacaya forks:

```sh
cat genesis.json | jq ". * {difficulty: 0, config: {taiko: true, londonBlock: 0, ontakeBlock: 1, pacayaBlock: 1, shanghaiTime: 0}} | del(.config.clique)" | jq --from-file gen2spec.jq > chainspec.json
```

### Surge 

The chainspec extends Taiko's one with UseSurgeGasPriceOracle:

```sh
cat genesis.json | jq ". * {difficulty: 0, config: {taiko: true, londonBlock: 0, ontakeBlock: 1, pacayaBlock: 1, useSurgeGasPriceOracle: true, shanghaiTime: 0}} | del(.config.clique)" | jq --from-file gen2spec.jq > chainspec.json
```


Based on https://github.com/ethereum/hive
