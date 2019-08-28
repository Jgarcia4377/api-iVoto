'use strict'

var UsuarioController = require('../controllers/usuario');
var EventoVotacionController = require('../controllers/eventosVotacion');
var express = require('express');
const api = express.Router();


//const app= express();
//var api = express.Router();
api.post('/login',UsuarioController.loginUser);
api.post('/admin',UsuarioController.loginUserAdmin);
api.get('/admin',EventoVotacionController.getPersonas);
api.post('/registro-usuario',UsuarioController.SaveTipoUsuario);
api.post('/registro-votante',UsuarioController.saveUser);
api.get('/registro-votante',UsuarioController.getUsuarios);
api.get('/registro-tipo-usuario',UsuarioController.getTipoUsuario);
api.delete('/registro-tipo-usuario/:id',UsuarioController.removeTipoUsuario);
//api.post('/registro-evento', EventoVotacionController.SaveEventoVotacion);
module.exports = api;


