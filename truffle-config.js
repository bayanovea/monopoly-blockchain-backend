require("dotenv").config()

module.exports = {
  networks: {
    development: {
      host: process.env.BLOCKCHAIN_HOST,
      port: process.env.BLOCKCHAIN_PORT,
      network_id: process.env.BLOCKCHAIN_NETWORK_ID
    }
  },
  compilers: {
    solc: {
      version: "^0.8.0"
    }
  }
};
