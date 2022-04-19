require("dotenv").config()

module.exports = {
  networks: {
    development: {
      host: process.env.HOST,
      port: process.env.PORT,
      network_id: process.env.NETWORK_ID
    }
  },
  compilers: {
    solc: {
      version: "^0.8.0"
    }
  }
};
