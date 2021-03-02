import os
import json
from web3 import Web3
from web3.middleware import geth_poa_middleware

geth_url = os.getenv('ETHEREUM_ENDPOINT_URI')
contract_file = os.getenv('ETHEREUM_CONTRACT_PATH')

with open(contract_file, 'r') as f:
    datastore = json.load(f)
    abi = datastore["abi"]
    contract_address = datastore["contract_address"]

class Ethereum():
    @staticmethod
    def get_info():
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contract = web3.eth.contract(address=contract_address, abi=abi)
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        data = contract.functions.getInfo().call()
        return data
