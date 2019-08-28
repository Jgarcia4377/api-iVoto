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
        let query = 'CALL registrar_candidato (?,?,?,?,?)'
        config.query(query, [data.idevento, data.idpersona, data.idPuestosCandidatos, data.idPartidosPoliticos, data.cantidadVotos],
            (err,res)=>{
                    if(err) throw(err)
                   else
                    callback(null,res);
            })
    }
}

eventosVotacionModel.GetCandidatos=(callback)=>{
    if(config){
        let query = 'SELECT * FROM vmostrarcandidatos';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query,
        (err,res)=>{
                if(err) throw(err)
               else
                callback(null,res);
        })
    } 
};



eventosVotacionModel.RegistroPartidoPolitico=(data, callback)=>{
    if(config){
        let query = 'CALL registrar_partidos_politicos (?,?)'
        config.query(query, [data.nombrePartido, data.numeroPartido],
            (err,res)=>{
                    if(err) throw(err)
                   else
                    callback(null,res);
            })
    }
}

eventosVotacionModel.GetPartidosPoliticos=(callback)=>{
    if(config){
        let query = 'SELECT * FROM vMostrarPartidosPoliticos';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query,
        (err,res)=>{
                if(err) throw(err)
               else
                callback(null,res);
        })
    } 
};

eventosVotacionModel.RegistroPuestosCandidatos=(data, callback)=>{
    if(config){
        let query = 'CALL registrar_puestos_candidatos (?)'
        config.query(query, [data.tipo],
            (err,res)=>{
                    if(err) throw(err)
                   else
                    callback(null,res);
            })
    }
}

eventosVotacionModel.GetPuestosCandidatos=(callback)=>{
    if(config){
        let query = 'SELECT * FROM vMostrarPuestosCandidatos';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query,
        (err,res)=>{
                if(err) throw(err)
               else
                callback(null,res);
        })
    } 
};

eventosVotacionModel.GetPersonas=(callback)=>{
    if(config){
        let query = 'SELECT * FROM vmostrarpersonas';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query,
        (err,res)=>{
                if(err) throw(err)
               else
                callback(null,res);
        })
    } 
};


eventosVotacionModel.actualizaEstadoEvento=(data, callback)=>{
    if(config){
        let query = 'CALL actualizar_estado_evento (?,?)'
        config.query(query, [data.idevento, data.FHActualSistema],
            (err,res)=>{
                    if(err) throw(err)
                   else
                    callback(null,res);
            })
    }
}

eventosVotacionModel.mostrarResultadoGraficoByIdEvento=(data, callback)=>{
    if(config){
        let query = 'CALL BuscarEventoGrafico (?)'
        config.query(query, [data.idEvento],
            (err, res)=>{
                if(err){
                    throw (err);
                }else{
                    callback(null,res)
                }
            }
        )
    }
   
};


module.exports = eventosVotacionModel;
    
