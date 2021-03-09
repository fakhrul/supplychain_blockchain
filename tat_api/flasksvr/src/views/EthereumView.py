# /src/views/ActivityView.py
from flask import Flask, request, g, Blueprint, json, Response
from marshmallow import ValidationError
from ..shared.Authentication import Auth
from ..shared.Ethereum import Ethereum


# import json
# from web3 import Web3
# from web3.middleware import geth_poa_middleware

# # geth_url = "http://127.0.0.1:8545"
# # web3 = Web3(Web3.HTTPProvider(geth_url))
# # web3.eth.defaultAccount = web3.eth.accounts[0]
# # abi = json.loads('[{"constant":true,"inputs":[],"name":"getInfo","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_info","type":"string"}],"name":"setInfo","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]')

# # address = web3.toChecksumAddress('0x40F8B7b30DbAbC5141A7F668A1ad328E2B1FF95c') # FILL IN YOUR ACTUAL ADDRESS
# # contract = web3.eth.contract(address=address, abi=abi)

# # web3.middleware_onion.inject(geth_poa_middleware, layer=0)


app = Flask(__name__)
etheruem_api = Blueprint('etheruem_api', __name__)


@etheruem_api.route('/', methods=['GET'])
def index():
    return custom_response('etheruem', 200)

## ORGANIZATION TYPE

@etheruem_api.route('/organizationType', methods=['GET'])
def get_organization_type_list():
    retObj = {
        'data' : Ethereum.get_organization_type_list()
    }
    return custom_response(retObj, 200)

@etheruem_api.route('/organizationType/<string:id>', methods=['GET'])
def getOrganizationType(id):
    retObj = {
        'data' : Ethereum.get_organization_type(id)
    }
    return custom_response(retObj, 200)

@etheruem_api.route('/organizationType', methods=['POST'])
def createOrganizationType():
    req_data = request.get_json()
    name = req_data['name'];
    custom = req_data['custom'];

    data = Ethereum.create_organization_type(name, custom)
    retObj = {
        'data' : data
    }
    return custom_response(retObj, 201)    

@etheruem_api.route('/organizationType/<string:id>', methods=['PUT'])
def updateOrganizationType(id):
    req_data = request.get_json()
    name = req_data['name'];
    custom = req_data['custom'];

    data = Ethereum.update_organization_type(id, name, custom)
    retObj = {
        'data' : data
    }
    return custom_response(retObj, 201)    

@etheruem_api.route('/organizationType/<string:id>', methods=['DELETE'])
def deleteOrganizationType(id):
    retObj = {
        'data' : Ethereum.delete_organization_type(id)
    }
    return custom_response(retObj, 200)

## ORGANIZATION

@etheruem_api.route('/organization', methods=['GET'])
def getOrganizationList():
    retObj = {
        'data' : Ethereum.get_organization_list()
    }
    return custom_response(retObj, 200)

@etheruem_api.route('/organization/<string:id>', methods=['GET'])
def getOrganization(id):
    retObj = {
        'data' : Ethereum.get_organization(id)
    }
    return custom_response(retObj, 200)

@etheruem_api.route('/organization', methods=['POST'])
def createOrganization():
    req_data = request.get_json()
    name = req_data['name'];
    custom = req_data['custom'];

    data = Ethereum.create_organization(name, custom)
    retObj = {
        'data' : data
    }
    return custom_response(retObj, 201)    

@etheruem_api.route('/organization/<string:id>', methods=['PUT'])
def updateOrganization(id):
    req_data = request.get_json()
    name = req_data['name'];
    custom = req_data['custom'];

    data = Ethereum.update_organization(id, name, custom)
    retObj = {
        'data' : data
    }
    return custom_response(retObj, 201)    

@etheruem_api.route('/organization/<string:id>', methods=['DELETE'])
def deleteOrganization(id):
    retObj = {
        'data' : Ethereum.delete_organization(id)
    }
    return custom_response(retObj, 200)


def custom_response(res, status_code):
    """
    Custom Response Function
    """
    return Response(
        mimetype="application/json",
        response=json.dumps(res),
        status=status_code
    )
