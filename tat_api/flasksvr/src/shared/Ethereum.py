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

        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        tx_hash = contract.functions.create(name, custom).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Created().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def update_organization_type(id, name, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationTypeContract'

        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        tx_hash = contract.functions.update(id, name, custom, True).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_organization_type(id):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationTypeContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        objId, name, isActive, custom = contract.functions.getById(id).call()
        data = {
            'id': Web3.toHex(objId),
            'name': name,
            'custom': custom,
            'isActive': isActive
        }
        return data

    @staticmethod
    def delete_organization_type(id):
        print(id)
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationTypeContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.activate(id, False).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_organization_type_list():
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationTypeContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        datas = contract.functions.getAll().call()
        dataInHex = []
        for data in datas:
            retObj = Ethereum.get_organization_type(Web3.toHex(data))
            if retObj['isActive']:
                dataInHex.append(retObj)
            # dataInHex.append(Web3.toHex(data))

        return dataInHex

# ORGANIZATION

    @staticmethod
    def create_organization(name, organizationTypeIdList, organizationAddress, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationContract'
        organizationTypeIdListInBytes = []
        for organizationTypeId in organizationTypeIdList:
            organizationTypeIdListInBytes.append(organizationTypeId["id"])

        # print(organizationTypeIdListInBytes)
        # return 'a'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        tx_hash = contract.functions.create(
            name, organizationTypeIdListInBytes, organizationAddress, custom).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Created().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def update_organization(id, name, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationTypeContract'

        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        tx_hash = contract.functions.update(id, name, custom, True).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_organization(id):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        objId, name, organizationTypeIdList,organizationAddress, isActive, custom = contract.functions.getById(id).call()

        organizationType = []
        for data in organizationTypeIdList:
            orgTypeInfo = Ethereum.get_organization_type(Web3.toHex(data))
            organizationType.append(orgTypeInfo)

        data = {
            'id': Web3.toHex(objId),
            'name': name,
            'organizationTypeIdList' : organizationType,
            'organizationAddress' : organizationAddress,
            'custom': custom,
            'isActive': isActive
        }
        return data

    @staticmethod
    def delete_organization(id):
        print(id)
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationTypeContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.activate(id, False).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_organization_list():
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        datas = contract.functions.getAll().call()
        dataInHex = []
        for data in datas:
            retObj = Ethereum.get_organization(Web3.toHex(data))
            if retObj['isActive']:
                dataInHex.append(retObj)
        # for data in datas:
        #     dataInHex.append(Web3.toHex(data))

        return dataInHex
