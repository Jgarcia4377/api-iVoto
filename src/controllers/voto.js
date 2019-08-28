'use strict'
var bcrypt = require('bcrypt-nodejs');
var voto = require('../models/votoModels');

function SaveVoto(req,res){
    console.log(req.body)
    const params = req.body
    const fechaHoraVoto = params.FHVoto
    console.log(fechaHoraVoto);
    
    const idEvento = params.idevento
    const idUsuario = params.idusuario
    const idCandidato = params.idcandidato
    const idPuestoCandidato = params.idPuestoCandidato 
    voto.hacerVoto({fechaHoraVoto,idEvento,idUsuario,idCandidato,idPuestoCandidato},(err, data)=>{
        console.log(data);
        if(err) throw err;
            res.send(JSON.stringify(data));   
    })
};

module.exports = {
    SaveVoto
 
}