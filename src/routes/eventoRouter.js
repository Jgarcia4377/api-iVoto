'use strict'

var EventoVotacionController = require('../controllers/eventosVotacion');
var express = require('express');
const api = express.Router();

//const app= express();
//var api = express.Router();

api.post('/registro-evento', EventoVotacionController.SaveEventoVotacion);
api.get('/registro-evento', EventoVotacionController.getTodosEventos);
api.get('/dashboard', EventoVotacionController.getTodosEventos);
api.get('/registro-candidato', EventoVotacionController.getTodosEventos);
api.post('/registro-candidato', EventoVotacionController.SaveCandidato);
module.exports = api;

