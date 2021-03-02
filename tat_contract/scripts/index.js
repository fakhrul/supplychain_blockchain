// scripts/index.js
module.exports = async function main(callback) {
    try {
        // Our code will go here
        const accounts = await web3.eth.getAccounts();
        console.log(accounts)
        callback(0);
    } catch (error) {
        console.error(error);
        callback(1);
    }
}