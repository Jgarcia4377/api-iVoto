'use strict'
var bcrypt = require('bcrypt-nodejs');
var eventosVotacion = require('../models/eventosModels');
    
function SaveEventoVotacion(req,res){
    const params = req.body
    const descripcion = params.descripcion
    const observaciones = params.observaciones
    const fechahorainicio = params.fechahorainicio
    const fechahorafin = params.fechahorafin
    const idestadovotacion = params.idestadovotacion 
    eventosVotacion.saveEventosVotacion({descripcion,observaciones,fechahorainicio,fechahorafin,idestadovotacion},(err, data)=>{
        console.log(data);
        if(err) throw err;
            res.send(JSON.stringify(data));   
    })
};

function getTodosEventos(req,res){
    eventosVotacion.GetTodosEventos((err,data)=>{
        if(err) throw err;
            res.send(JSON.stringify(data));
    });

}

function SaveCandidato(req,res){
    const params = req.body
    const puestoCandidato = params.puestoCandidato
    const partidoPolitico = params.partidoPolitico
    const idVotacion = params.idVotacion
    const cantidadVotos = params.cantidadVotos
    const nombres = params.nombres
    const apellidos = params.apellidos
    eventosVotacion.RegistroCandidato({puestoCandidato,partidoPolitico,idVotacion,cantidadVotos,nombres,apellidos},(err,data)=>{
        console.log(data);
        if(err) throw err;
            res.send(JSON.stringify(data));
    })  
}

module.exports = {
    SaveEventoVotacion,
    getTodosEventos,
    SaveCandidato
}