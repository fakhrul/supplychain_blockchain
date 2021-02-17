# supplychain_blockchain

## Step by step to configure the blockchain on Windows

1. Create working directory

mkdir tat_bc
cd tat_bc

2. download latest geth for windows file and extract to working directory
https://geth.ethereum.org/downloads/

3. check version by running
geth version

4. genereate genesis json using puppeth. Use filename "tat_bc.json"

5 create account

geth account new --datadir accounts/

* for the testing purporse, you can create 3 accounts (3 times) with same password 123456

6. greate genesis sealer

geth -identity "[genesis_name]" init [genesis_file] --datadir data_tat/node1/chain-data

geth -identity "tat_bc-sealer" init tat_bc.json --datadir data_tat/node1/chain-data

7. copy paste account to keystore

8. start the etherium

geth --networkid 1234 --rpc --rpcaddr 0.0.0.0 --port 30303 --rpcport 8545 --rpcapi="admin,debug,net,eth,shh,web3,txpool,personel,db,clique" --rpccorsdomain "*" --rpcvhosts "*" --nodiscover --datadir data_tat/node1/chain-data --wsapi="admin,debug,eth,net,web3,network,debug,txpool,personel,db,clique" --ws --wsaddr 0.0.0.0 --wsport 8546 --wsorigins "*" --syncmode full --gcmode=archive --allow-insecure-unlock --ipcpath "data_tat\node1\geth.ipc" console 

9. test the geth

web3.eth.getBlock("latest")

10. test loadScript

loadScript("myBalance.js")
