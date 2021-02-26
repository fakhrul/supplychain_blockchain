# /src/views/ActivityView.py
from flask import Flask, request, g, Blueprint, json, Response
from marshmallow import ValidationError
from ..shared.Authentication import Auth


import json
from web3 import Web3
from web3.middleware import geth_poa_middleware

geth_url = "http://127.0.0.1:8545"
web3 = Web3(Web3.HTTPProvider(geth_url))
web3.eth.defaultAccount = web3.eth.accounts[0]
abi = json.loads('[{"constant":true,"inputs":[],"name":"getInfo","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_info","type":"string"}],"name":"setInfo","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]')

address = web3.toChecksumAddress('0x40F8B7b30DbAbC5141A7F668A1ad328E2B1FF95c') # FILL IN YOUR ACTUAL ADDRESS
contract = web3.eth.contract(address=address, abi=abi)

web3.middleware_onion.inject(geth_poa_middleware, layer=0)

# print('Is Connected {}'.format(web3.isConnected()))
# print('Client Version {}'.format(web3.clientVersion))

# print('Previous contract info: {}'.format(
#     contract.functions.getInfo().call()
# ))
# # Set info
# tx_hash = contract.functions.setInfo('HEELLLLOOOOOO!!!').transact()
# # Wait for transaction to be mined
# web3.eth.waitForTransactionReceipt(tx_hash)
# # Display the new greeting value
# print('Updated contract info: {}'.format(
#     contract.functions.getInfo().call()
# ))



app = Flask(__name__)
etheruem_api = Blueprint('etheruem_api', __name__)


@etheruem_api.route('/', methods=['GET'])
def index():
    return custom_response('etheruem', 200)


@etheruem_api.route('/info', methods=['GET'])
def getInfo():
    data = contract.functions.getInfo().call()
    retObj = {
        'data' : data
    }
    return custom_response(retObj, 200)

@etheruem_api.route('/info', methods=['POST'])
def setInfo():
    req_data = request.get_json()
    info = req_data['info'];
    tx_hash = contract.functions.setInfo(info).transact()
    web3.eth.waitForTransactionReceipt(tx_hash)

    data = contract.functions.getInfo().call()
    retObj = {
        'data' : data
    }
    return custom_response(retObj, 201)    

def custom_response(res, status_code):
    """
    Custom Response Function
    """
    return Response(
        mimetype="application/json",
        response=json.dumps(res),
        status=status_code
    )
