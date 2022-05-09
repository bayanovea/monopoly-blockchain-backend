// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GameInstance {
    uint16 internal constant MAP_CELLS_COUNT = 8;

    struct Player {
        string name;
        uint256 balance;
        uint16 currentPosition;
    }

    struct Map {
        MapCell[] cells;
    }

    struct MapCell {
        uint8 position;
        bool isEnemyFactory;
    }

    event MoveMade(
        address playerAddress,
        uint16 dicesValue,
        uint16 newPosition,
        uint256 balance
    );

    mapping(address => Player) players;
    Map internal map;

    constructor() {
        fillMapCells();
    }

    function addPlayer(address _address, string memory name) public {
        players[_address] = Player(name, 100, 0);
    }

    function makeMove(address playerAddress) public {
        // Check conditions if it's player's turn

        // TODO: Exception if no player
        Player storage player = players[playerAddress];

        // TODO: Get real random value via ChainLink
        // TODO: Change max value 3 to 6
        uint16 firstDiceValue = 1 + uint16(uint8(block.timestamp) % 3);
        uint16 secondDiceValue = 1 + uint16(uint8(block.timestamp) % 3);
        uint16 dicesValue = firstDiceValue + secondDiceValue;

        uint16 newPosition = player.currentPosition + dicesValue;
        if (newPosition >= MAP_CELLS_COUNT) {
            newPosition -= MAP_CELLS_COUNT;
        }

        MapCell memory mapCell = map.cells[newPosition];
        if (mapCell.isEnemyFactory) {
            player.balance -= 1;
        }

        player.currentPosition = newPosition;

        emit MoveMade(playerAddress, dicesValue, newPosition, player.balance);
    }

    function fillMapCells() internal {
        map.cells.push(MapCell(0, false));
        map.cells.push(MapCell(1, false));
        map.cells.push(MapCell(2, false));
        map.cells.push(MapCell(3, false));
        map.cells.push(MapCell(4, true));
        map.cells.push(MapCell(5, true));
        map.cells.push(MapCell(6, true));
        map.cells.push(MapCell(7, true));
    }
}
