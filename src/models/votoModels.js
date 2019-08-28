const mysql = require('mysql');
let config = require('../keys');

let votosModel ={};

votosModel.hacerVoto=(data, callback)=>{
    if(config){
        let query = 'CALL  RegistrarVotoDetalle (?,?,?,?,?)';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query, [data.fechaHoraVoto, data.idEvento, data.idUsuario, data.idCandidato, data.idPuestoCandidato],
        (err,res)=>{
                if(err) throw(err)
               else
                callback(null,res);
        })
    } 
};


module.exports = votosModel;