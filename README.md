# supplychain_blockchain

## Step by step to configure the blockchain on Windows

### Pre requisite
1. geth.exe - for running the etherum. You can download the latest geth for windows file and extract to working directory https://geth.ethereum.org/downloads/
2. puppeth.exe > for generating the genesis file

### Etherium preparation

1. Create working directory
````
mkdir tat_bc
cd tat_bc
````
2. Place the geth.exe and puppeth.exe to working directory

3. check version by running
geth version

4. create account
````
geth account new --datadir accounts/
````
This will generate an account in the directory accounts.
For the testing purporse,create 3 accounts (3 times) with same password of 123456

5. Genereate genesis json using puppeth. Use filename "sirim.json"
```
puppeth.exe

Please specify a network name to administer (no spaces, hyphens or capital letters please)
> sirim

What would you like to do? (default = stats)
 1. Show network stats
 2. Configure new genesis
 3. Track new remote server
 4. Deploy network components
> 2

What would you like to do? (default = create)
 1. Create new genesis from scratch
 2. Import already existing genesis
> 1

Which consensus engine to use? (default = clique)
 1. Ethash - proof-of-work
 2. Clique - proof-of-authority
> 2

How many seconds should blocks take? (default = 15)
> 5

Which accounts are allowed to seal? (mandatory at least one)
> 0x79a903a884a740ed68ecb2dedc328ee13ef4c3fc

(advice to put the first account)

Which accounts should be pre-funded? (advisable at least one)
> 0x79a903a884a740ed68ecb2dedc328ee13ef4c3fc
> 0xe4ce636c7a1f6e0cff746069e51496911cad2ce4
> 0xad03e3dab78bbcc3c7f2957e93fc74f38152854b
> 0x

Should the precompile-addresses (0x1 .. 0xff) be pre-funded with 1 wei? (advisable yes)
> no

Specify your chain/network ID if you want an explicit one (default = random)
> 1234

```

Now exporting the genesis file

```
What would you like to do? (default = stats)
 1. Show network stats
 2. Manage existing genesis
 3. Track new remote server
 4. Deploy network components
> 2

 1. Modify existing configurations
 2. Export genesis configurations
 3. Remove genesis configuration
> 2

Which folder to save the genesis specs into? (default = current)
  Will create sirim.json, sirim-aleth.json, sirim-harmony.json, sirim-parity.json
>
←[32mINFO ←[0m[02-26|10:55:14.256] Saved native genesis chain spec          ←[32mpath←[0m=sirim.json
←[31mERROR←[0m[02-26|10:55:14.256] Failed to create Aleth chain spec        ←[31merr←[0m="unsupported consensus engine"
←[31mERROR←[0m[02-26|10:55:14.257] Failed to create Parity chain spec       ←[31merr←[0m="unsupported consensus engine"
←[32mINFO ←[0m[02-26|10:55:14.258] Saved genesis chain spec                 ←[32mclient←[0m=harmony ←[32mpath←[0m=sirim-harmony.json

```
genesis file named sirim.json is created.

6. Edit the genesis file. update the balance for all 3 acount to 1000000000000000000000000 wei (you can google utility for wei calculator)
```
"balance": "1000000000000000000000000"

```
8. greate genesis sealer

geth -identity "[genesis_name]" init [genesis_file] --datadir data_tat/node1/chain-data

geth -identity "tat_bc-sealer" init tat_bc.json --datadir data_tat/node1/chain-data

7. copy paste account to keystore

8. start the etherium

geth --networkid 1234 --rpc --rpcaddr 0.0.0.0 --port 30303 --rpcport 8545 --rpcapi="admin,debug,net,eth,shh,web3,txpool,personel,db,clique" --rpccorsdomain "*" --rpcvhosts "*" --nodiscover --datadir data_tat/node1/chain-data --wsapi="admin,debug,eth,net,web3,network,debug,txpool,personel,db,clique" --ws --wsaddr 0.0.0.0 --wsport 8546 --wsorigins "*" --syncmode full --gcmode=archive --allow-insecure-unlock --ipcpath "data_tat\node1\geth.ipc" console 

9. test the geth

web3.eth.getBlock("latest")

10. test loadScript

loadScript("myBalance.js")

11. unlock command

// Unlock accounts[0] for 60 seconds for transaction

web3.personal.unlockAccount(eth.accounts[1], "123456", 60)

// If you want to Unlock One Month for Sealer Node

web3.personal.unlockAccount(eth.accounts[0], "123456", 2600000)

// Lock accounts[0]

personal.lockAccount(eth.accounts[0])


// E.g: Send 1 ether from accounts[0] to ETH address, You must unlock accounts[0] before sending transaction

eth.sendTransaction({from:eth.accounts[0], to:"0x0000706e899d0f46c5efe22c4caaeb885af4dcac", value: web3.toWei(1, "ether")})

eth.sendTransaction({from:eth.accounts[1], to:eth.accounts[0], value: web3.toWei(1, "ether")})

// E.g: Send 1 ether from "0xf1326b3d4fbe5049fe94ed8a622f227d36a6d5ee" to eth.accounts[1], You must unlock "0xf1326b3d4fbe5049fe94ed8a622f227d36a6d5ee" before sending transaction

eth.sendTransaction({from:"0xf1326b3d4fbe5049fe94ed8a622f227d36a6d5ee", to:eth.accounts[1], value: web3.toWei(1, "ether")})


