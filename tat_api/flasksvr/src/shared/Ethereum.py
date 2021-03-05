import os
import json
from web3 import Web3
from web3.middleware import geth_poa_middleware

geth_url = os.getenv('ETHEREUM_ENDPOINT_URI')
contract_path = os.getenv('ETHEREUM_CONTRACT_PATH')

abi_lib = {}
contract_address_lib = {}
for filename in os.listdir(contract_path):
    try:
        if filename.endswith('.json'):
            fullPath = os.path.join(contract_path, filename)
            with open(fullPath, 'r') as f:
                datastore = json.load(f)
                filenameNoExt = os.path.splitext(filename)[0]
                abi_lib[filenameNoExt] = datastore["abi"]
                contract_address_lib[filenameNoExt] = datastore["contract_address"]
                print('Load Contract Success', filenameNoExt)

    except Exception as e:
        print(e)

class Ethereum():
    @staticmethod
    def create_organization_type(name, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationTypeContract'

        contract = web3.eth.contract(address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        tx_hash = contract.functions.create(name, custom).transact()
        receipt =web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Created().processReceipt(receipt)
        objId =Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_organization_type(id):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationTypeContract'
        contract = web3.eth.contract(address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        # data = "{}".format(contract.functions.getById(id).call())

        objId, name, custom =contract.functions.getById(id).call()
        data = {
            'id' : Web3.toHex(objId),
            'name' : name,
            'custom' : custom
        }
        return data

    @staticmethod
    def get_organization_type_list():
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationTypeContract'
        contract = web3.eth.contract(address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        data = contract.functions.getAll().call()

        tx_json = Web3.toJSON(data)

        print(tx_json)
        return tx_json
        print(dataList)
        return 'a'
        data = {
            'id' : Web3.toHex(objId),
            'name' : name,
            'custom' : custom
        }
        return data
