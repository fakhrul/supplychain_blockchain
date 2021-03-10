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
    def update_organization(id, name, organizationTypeIdList, organizationAddress, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationContract'

        organizationTypeIdListInBytes = []
        for organizationTypeId in organizationTypeIdList:
            organizationTypeIdListInBytes.append(organizationTypeId["id"])

        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.update(
            id, name, organizationTypeIdListInBytes, organizationAddress, custom, True).transact()
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
        objId, name, organizationTypeIdList, organizationAddress, isActive, custom = contract.functions.getById(
            id).call()

        organizationType = []
        for data in organizationTypeIdList:
            orgTypeInfo = Ethereum.get_organization_type(Web3.toHex(data))
            organizationType.append(orgTypeInfo)

        data = {
            'id': Web3.toHex(objId),
            'name': name,
            'organizationTypeIdList': organizationType,
            'organizationAddress': organizationAddress,
            'custom': custom,
            'isActive': isActive
        }
        return data

    @staticmethod
    def delete_organization(id):
        print(id)
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'OrganizationContract'
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

# ACTIVITY

    @staticmethod
    def create_activity(name, organizationType, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'ActivityContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        organizationTypeId = organizationType["id"]
        tx_hash = contract.functions.create(
            name, organizationTypeId, custom).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Created().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def update_activity(id, name, organizationType, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'ActivityContract'

        organizationTypeId = organizationType["id"]

        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.update(
            id, name, organizationTypeId, custom, True).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_activity(id):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'ActivityContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        objId, name, organizationTypeId, isActive, custom = contract.functions.getById(
            id).call()

        organizationType = Ethereum.get_organization_type(Web3.toHex(organizationTypeId))

        data = {
            'id': Web3.toHex(objId),
            'name': name,
            'organizationType': organizationType,
            'custom': custom,
            'isActive': isActive
        }
        return data

    @staticmethod
    def delete_activity(id):
        print(id)
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'ActivityContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.activate(id, False).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_activity_list():
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'ActivityContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        datas = contract.functions.getAll().call()
        dataInHex = []
        for data in datas:
            retObj = Ethereum.get_activity(Web3.toHex(data))
            if retObj['isActive']:
                dataInHex.append(retObj)

        return dataInHex

# AREA

    @staticmethod
    def create_area(name, organization, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'AreaContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        organizationId = organization["id"]
        tx_hash = contract.functions.create(
            name, organizationId, custom).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Created().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def update_area(id, name, organization, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'AreaContract'

        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        organizationId = organization["id"]

        tx_hash = contract.functions.update(
            id, name, organizationId, custom, True).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_area(id):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'AreaContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        objId, name, organizationId, isActive, custom = contract.functions.getById(
            id).call()

        organization = Ethereum.get_organization(Web3.toHex(organizationId))

        data = {
            'id': Web3.toHex(objId),
            'name': name,
            'organization': organization,
            'custom': custom,
            'isActive': isActive
        }
        return data

    @staticmethod
    def delete_area(id):
        print(id)
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'AreaContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.activate(id, False).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_area_list():
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'AreaContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        datas = contract.functions.getAll().call()
        dataInHex = []
        for data in datas:
            retObj = Ethereum.get_area(Web3.toHex(data))
            if retObj['isActive']:
                dataInHex.append(retObj)

        return dataInHex

# category

    @staticmethod
    def create_category(name, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'CategoryContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.create(
            name,custom).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Created().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def update_category(id, name, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'CategoryContract'

        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.update(
            id, name,  custom, True).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_category(id):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'CategoryContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        objId, name, isActive, custom = contract.functions.getById(
            id).call()

        data = {
            'id': Web3.toHex(objId),
            'name': name,
            'custom': custom,
            'isActive': isActive
        }
        return data

    @staticmethod
    def delete_category(id):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'CategoryContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.activate(id, False).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_category_list():
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'CategoryContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        datas = contract.functions.getAll().call()
        dataInHex = []
        for data in datas:
            retObj = Ethereum.get_category(Web3.toHex(data))
            if retObj['isActive']:
                dataInHex.append(retObj)

        return dataInHex


# certification

    @staticmethod
    def create_certification(name, certificateUrl, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'CertificationContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.create(
            name,certificateUrl, custom).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Created().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def update_certification(id, name,certificateUrl, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'CertificationContract'

        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.update(
            id, name, certificateUrl, custom, True).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_certification(id):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'CertificationContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        objId, name, isActive, custom = contract.functions.getById(
            id).call()

        data = {
            'id': Web3.toHex(objId),
            'name': name,
            'custom': custom,
            'isActive': isActive
        }
        return data

    @staticmethod
    def delete_certification(id):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'CertificationContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.activate(id, False).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_certification_list():
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'CertificationContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        datas = contract.functions.getAll().call()
        dataInHex = []
        for data in datas:
            retObj = Ethereum.get_certification(Web3.toHex(data))
            if retObj['isActive']:
                dataInHex.append(retObj)

        return dataInHex

# product

    @staticmethod
    def create_product(name, category, description,certificationList, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'ProductContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        categoryId = category["id"]
        certificationIdListInBytes = []
        for certification in certificationList:
            certificationIdListInBytes.append(certification["id"])

        tx_hash = contract.functions.create(
            name,categoryId, description, certificationIdListInBytes, custom).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Created().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def update_product(id, name, category,description, certificationList, custom):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'ProductContract'
        categoryId = category["id"]
        certificationIdListInBytes = []
        for certification in certificationList:
            certificationIdListInBytes.append(certification["id"])

        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.update(
            id, name, categoryId, description, certificationIdListInBytes, custom, True).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_product(id):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'ProductContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)
        objId, categoryId, name, description, certificationIdList, isActive, custom = contract.functions.getById(
            id).call()

        category = Ethereum.get_category(Web3.toHex(organizationId))

        certificationList = []
        for data in certificationIdList:
            certification = Ethereum.get_certification(Web3.toHex(data))
            certificationList.append(certification)

        data = {
            'id': Web3.toHex(objId),
            'name': name,
            'category' : category,
            'description' : description,
            'certificationList' : certificationList,
            'custom': custom,
            'isActive': isActive
        }
        return data

    @staticmethod
    def delete_product(id):
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'ProductContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        tx_hash = contract.functions.activate(id, False).transact()
        receipt = web3.eth.waitForTransactionReceipt(tx_hash)
        logs = contract.events.Updated().processReceipt(receipt)
        objId = Web3.toHex(logs[0]['args']['objId'])
        return objId

    @staticmethod
    def get_product_list():
        web3 = Web3(Web3.HTTPProvider(geth_url))
        web3.eth.defaultAccount = web3.eth.accounts[0]
        contractName = 'ProductContract'
        contract = web3.eth.contract(
            address=contract_address_lib[contractName], abi=abi_lib[contractName])
        web3.middleware_onion.inject(geth_poa_middleware, layer=0)

        datas = contract.functions.getAll().call()
        dataInHex = []
        for data in datas:
            retObj = Ethereum.get_product(Web3.toHex(data))
            if retObj['isActive']:
                dataInHex.append(retObj)

        return dataInHex
