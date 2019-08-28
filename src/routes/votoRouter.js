'use strict'

var VotoController = require('../controllers/voto');
var express = require('express');
const api = express.Router();

api.post('/votacion',VotoController.SaveVoto);
//api.post('/registro-evento', EventoVotacionController.SaveEventoVotacion);
module.exports = api;