const express = require('express');
const Contracts = require('./app/contracts.js');
const port = process.env.APP_PORT || 80;
var bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

let currentAccount = undefined;
initCurrentAccount();

// Rounting: Accounts

app.get('/accounts', function (req, res) {
    Contracts.web3.eth.getAccounts(function (err, accounts) {
        if (err) { res.status(500).json({ error: err }); return; }
        res.json({
            accounts: accounts
        });
    });
});

// Rounting: Player

app.get('/currentPlayer', function (req, res) {
    Contracts.GamesStorage.deployed().then(function (instance) {
        return instance.getPlayer(currentAccount, { from: currentAccount });
    }).then(function (value) {
        res.json({
            player: {
                name: value[0],
                balance: value[1].toNumber()
            }
        });
    }).catch(function (err) {
        res.status(500).json({ error: err.message });
    });
});

app.post('/player', function (req, res) {
    Contracts.GamesStorage.deployed().then(function (instance) {
        return instance.addPlayer(req.query.name, { from: currentAccount });
    }).catch(function (err) {
        res.status(500).json({ error: err.message });
    });
});

// Rounting: Game

app.get('/game', function (req, res) {
    Contracts.GamesStorage.deployed().then(function (instance) {
        return instance.getGame(address, { from: currentAccount });
    }).then(function (value) {
        res.json({
            game: {
                status: value[0],
            }
        });
    }).catch(function (err) {
        res.status(500).json({ error: err.message });
    });
});

app.post('/game', function (req, res) {
    Contracts.GamesStorage.deployed().then(function (instance) {
        return instance.addGame({ from: currentAccount });
    }).catch(function (err) {
        res.status(500).json({ error: err.message });
    });
});

app.post('/game/add-player', function (req, res) {
    Contracts.GamesStorage.deployed().then(function (instance) {
        return instance.addPlayerToGame(req.body.gameAddress, req.body.playerAddress, { from: currentAccount });
    }).catch(function (err) {
        res.status(500).json({ error: err.message });
    });
});



function initCurrentAccount() {
    if (currentAccount === undefined) {
        Contracts.web3.eth.getAccounts(function (err, accounts) {
            if (err) { throw Error(err); }
            currentAccount = accounts[0];
        });
    }
}

app.listen(port);