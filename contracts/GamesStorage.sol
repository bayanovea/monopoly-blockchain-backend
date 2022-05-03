// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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

    function addGame() public {
        address[] memory playersAddresses;

        // TODO: Deploy Game and use deployed address instead of hardcode value
        address newGameAddress = 0x1000000000000000000000000000000000000000;

        Game memory newGame = Game(playersAddresses, Status.NEW);
        games[newGameAddress] = newGame;
    }

    function getPlayer(address _address)
        public
        view
        returns (string memory name, uint256 balance)
    {
        Player memory player = players[_address];
        return (player.name, player.balance);
    }

    function addPlayer(string memory _name) public {
        players[msg.sender] = Player(_name, 0);
    }

    function addPlayerToGame(address gameAddress, address playerAddress)
        public
    {
        games[gameAddress].playersAddresses.push(playerAddress);
    }
}
