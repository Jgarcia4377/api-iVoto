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
    const idevento = params.idevento
    const idpersona = params.idpersona
    const idPuestosCandidatos = params.idPuestosCandidatos
    const idPartidosPoliticos = params.idPartidosPoliticos
    const cantidadVotos = params.cantidadVotos
    eventosVotacion.RegistroCandidato({idevento,idpersona,idPuestosCandidatos,idPartidosPoliticos,cantidadVotos},(err,data)=>{
        console.log(data);
        if(err) throw err;
            res.send(JSON.stringify(data));
    })  
}

function getCandidatos(req,res){
    eventosVotacion.GetCandidatos((err,data)=>{
        if(err) throw err;
            res.send(JSON.stringify(data));
    });
}

function SavePartidoPolitico(req,res){
    const params = req.body
    const nombrePartido = params.nombrePartido
    const numeroPartido = params.numeroPartido
    eventosVotacion.RegistroPartidoPolitico({nombrePartido,numeroPartido},(err,data)=>{
        console.log(data);
        if(err) throw err;
            res.send(JSON.stringify(data));
    })  
}

function getPartidosPoliticos(req,res){
    eventosVotacion.GetPartidosPoliticos((err,data)=>{
        if(err) throw err;
            res.send(JSON.stringify(data));
    });
}

function SavePuestosCandidatos(req,res){
    const params = req.body
    const tipo = params.tipo
    eventosVotacion.RegistroPuestosCandidatos({tipo},(err,data)=>{
        console.log(data);
        if(err) throw err;
            res.send(JSON.stringify(data));
    })  
}


function getPuestosCandidatos(req,res){
    eventosVotacion.GetPuestosCandidatos((err,data)=>{
        if(err) throw err;
            res.send(JSON.stringify(data));
    });
}

function getPersonas(req,res){
    eventosVotacion.GetPersonas((err,data)=>{
        if(err) throw err;
            res.send(JSON.stringify(data));
    });

}

function UpdateEstadoEvento(req,res){
    const params = req.body
    const idevento = params.idevento
    const FHActualSistema = params.FHActualSistema
    eventosVotacion.actualizaEstadoEvento({idevento,FHActualSistema},(err,data)=>{
        console.log(data);
        if(err) throw err;
            res.send(JSON.stringify(data));
    })  
}


function MostrarGraficoByID(req,res){
    const params = req.body
    const idEvento = params.idEvento
    eventosVotacion.mostrarResultadoGraficoByIdEvento({idEvento},(err,data)=>{
        if(err) throw err;
        res.send(JSON.stringify(data));
});

}



module.exports = {
    SaveEventoVotacion,
    getTodosEventos,
    SaveCandidato,
    getCandidatos,
    SavePartidoPolitico,
    getPartidosPoliticos,
    SavePuestosCandidatos,
    getPuestosCandidatos,
    getPersonas,
    UpdateEstadoEvento,
    MostrarGraficoByID
}