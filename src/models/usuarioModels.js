const mysql = require('mysql');
let config = require('../keys');


let UsuarioModel ={};
UsuarioModel.getUsuarios=(callback)=>{
    if(config){
        let query = 'SELECT * FROM vMostrarUsuarios';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query,
        (err,rows)=>{
            if(err){
                throw (err);
            }else{
                callback(null,rows);
            }
        })
    }
    
};

UsuarioModel.getTipoUsuarios=(callback)=>{
    if(config){
        let query = 'SELECT * FROM vMostrarTiposUsuarios';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query,
        (err,rows)=>{
          
                if(err) {throw(err)}
               else{
                callback(null,rows);
            }
        })
    } 
};

UsuarioModel.todosTiposUsuarioGet=(page=0)=>{

    if(config){
        page = page * 5;
        let query = 'SELECT * FROM tipo_usuario limit 0,5';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query,
        (err,rows)=>{
                if(err) {throw(err)}
               else{
                callback(null,rows);
            }
        })
    } 

}

UsuarioModel.insertTipoUsuario=(tipo_usuario, callback)=>{
    if(config){
        let query = 'CALL  registrar_tipo_usuario (?)';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query, [tipo_usuario],
        (err,res)=>{
                if(err) throw(err)
               else
                callback(null,res);
        })
    } 
};


UsuarioModel.deleteTipoUsuario=(id, callback)=>{
    if(config){
        let query = 'CALL  eliminar_tipo_usuario (?)';
        // connection.query('SELECT * FROM usuario ORDER BY idUsuario',
        config.query(query, [id],
        (err,res)=>{
                if(err) throw(err)
               else
                callback(null,res);
        })
    } 
};

UsuarioModel.LoginUsuario=(UsuarioData,callback)=>{
    if(config){
        let query ='CALL BuscarUsuarioLogin (?,?)';
        config.query(query,[UsuarioData.usuario, UsuarioData.contrasena],
            (err,res)=>{
                if(err){
                    throw err;                   
                }else{
                  callback(null,res); 
                  //resolve(JSON.parse(JSON.stringify(result)));
                }
                console.log(res)
            })
    }
};

UsuarioModel.LoginUsuarioAdmin=(UsuarioAdminData,callback)=>{
    if(config){
        let query ='CALL BuscarUsuarioAdminLogin (?,?)';
        config.query(query,[UsuarioAdminData.usuario, UsuarioAdminData.contrasena],
            (err,res)=>{
                if(err) {throw(err)}
                else{   
                 callback(null,res);}
                //   callback(null,res); 
                //console.log(JSON.parse(JSON.stringify(res)))
            })
    }
};




UsuarioModel.InsertUsuario=(UsuarioData,callback)=>{
    
    if(config){
        let query = "CALL registrar_usuario (?,?,?,?,?,?,?,?,?,?)";   
        config.query(query,[UsuarioData.cedula, UsuarioData.nombres,UsuarioData.apellido_p,UsuarioData.apellido_m,UsuarioData.huella_dactilar,
            UsuarioData.correo,UsuarioData.telefono,UsuarioData.direccion,UsuarioData.tipo_usuario_id,UsuarioData.estado_usuario_id],
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



module.exports = UsuarioModel;
    