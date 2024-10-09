const express = require('express');
const cors = require('cors');

const app = express();
const port = 8000;

app.use(express.json());
app.use(cors());

const monitores = require('./assets/monitores.json');
const horarios = require('./assets/horarios.json');

app.listen(port, () => {
    console.log('Servidor Node iniciado na porta ' + port)
})

app.get("/monitores", (req, res) => {
    res.status(200).json(monitores)
})

app.get("/horarios", (req, res) => {
    res.status(200).json(horarios)
})

module.exports = app