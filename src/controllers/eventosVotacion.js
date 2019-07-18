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
    eventosVotacion.insertTipoUsuario({descripcion,observaciones,fechahorainicio,fechahorafin,idestadovotacion},(err, data)=>{
        console.log(data);
        if(err) throw err;
            res.send(JSON.stringify(data));   
    })
};

module.exports = {
    SaveEventoVotacion
}