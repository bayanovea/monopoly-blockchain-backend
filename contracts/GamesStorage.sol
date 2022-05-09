// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./GameInstance.sol";

contract GamesStorage {
    enum Status {
        NEW,
        IN_PROGRESS,
        FINISHED
    }

    struct Game {
        address[] playersAddresses;
        Status status;
    }

    struct Player {
        string name;
        uint256 balance;
    }

    mapping(address => Game) games;
    mapping(address => Player) public players;

    function getGame(address _address) public view returns (Status status) {
        Game memory game = games[_address];
        return (game.status);
    }

    function addGame() public returns (address) {
        address[] memory playersAddresses;

        GameInstance newGameInstance = new GameInstance();
        address newGameAddress = address(newGameInstance);

        Game memory newGame = Game(playersAddresses, Status.NEW);
        games[newGameAddress] = newGame;

        return newGameAddress;
    }

    function getPlayer(address _address) public view returns (string memory) {
        Player memory player = players[_address];
        return player.name;
    }

    function addPlayer(string memory _name) public {
        players[msg.sender] = Player(_name, 100);
    }

    function addPlayerToGame(address gameAddress, address playerAddress)
        public
    {
        games[gameAddress].playersAddresses.push(playerAddress);

        GameInstance gameInstance = GameInstance(gameAddress);
        gameInstance.addPlayer(playerAddress, players[playerAddress].name);
    }

    function makeMove(address gameAddress, address playerAddress) public {
        GameInstance gameInstance = GameInstance(gameAddress);

        // Player memory player = players[playerAddress];
        // TODO: Exception if no game instance

        gameInstance.makeMove(playerAddress);
    }
}
