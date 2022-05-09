var GamesStorage = artifacts.require("GamesStorage");

module.exports = function (deployer) {
  deployer.deploy(GamesStorage);
};