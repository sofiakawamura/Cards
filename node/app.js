const express = require('express');

const app = express();
const port = 8000;

app.use(express.json());

const monitores = require('./assets/monitores.json');

app.listen(port, () => {
    console.log('Servidor Node iniciado na porta ' + port)
})

app.get("/monitores", (req, res) => {
    res.status(200).json({ monitores })
})

module.exports = app