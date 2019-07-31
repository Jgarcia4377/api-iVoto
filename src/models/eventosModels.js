const mysql = require('mysql');
let config = require('../keys');

let eventosVotacionModel ={};

eventosVotacionModel.saveEventosVotacion=(data, callback)=>{
    if(config){
        let query = 'CALL  RegistrarEventoVotacion (?,?,?,?,?)';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query, [data.descripcion, data.observaciones, data.fechahorainicio, data.fechahorafin, data.idestadovotacion],
        (err,res)=>{
                if(err) throw(err)
               else
                callback(null,res);
        })
    } 
};

eventosVotacionModel.GetTodosEventos=(callback)=>{
    if(config){
        let query = 'SELECT * FROM vmostrareventos';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query,
        (err,res)=>{
                if(err) throw(err)
               else
                callback(null,res);
        })
    } 
};

eventosVotacionModel.RegistroCandidato=(data, callback)=>{
    if(config){
        let query = 'CALL registrar_candidato (?,?,?,?,?,?)'
        config.query(query, [data.puestoCandidato, data.partidoPolitico, data.idVotacion, data.cantidadVotos, data.nombres, data.apellidos],
            (err,res)=>{
                    if(err) throw(err)
                   else
                    callback(null,res);
            })
    }
}



module.exports = eventosVotacionModel;
    
