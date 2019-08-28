'use strict'

var EventoVotacionController = require('../controllers/eventosVotacion');
var express = require('express');
const api = express.Router();

//const app= express();
//var api = express.Router();

api.post('/registro-evento', EventoVotacionController.SaveEventoVotacion);
api.get('/registro-evento', EventoVotacionController.getTodosEventos);
api.put('/registro-evento', EventoVotacionController.UpdateEstadoEvento);
api.get('/dashboard', EventoVotacionController.getTodosEventos);
// api.get('/registro-candidato', EventoVotacionController.getTodosEventos);
api.post('/registro-candidato', EventoVotacionController.SaveCandidato);
api.get('/registro-candidato', EventoVotacionController.getCandidatos);
api.post('/registro-partido-politico', EventoVotacionController.SavePartidoPolitico);
api.get('/registro-partido-politico', EventoVotacionController.getPartidosPoliticos);
api.post('/registro-puestos', EventoVotacionController.SavePuestosCandidatos);
api.get('/registro-puestos', EventoVotacionController.getPuestosCandidatos);
api.post('/resultados', EventoVotacionController.MostrarGraficoByID);
module.exports = api;



