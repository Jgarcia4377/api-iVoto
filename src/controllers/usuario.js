'use strict'
var bcrypt = require('bcrypt-nodejs');
var Usuario = require('../models/usuarioModels');
    
//loginUser
function loginUser(req, res,done){
    const params = req.body
    const usuario = params.usuario
    const contrasena = params.contrasena
        Usuario.LoginUsuario({usuario,contrasena},(err,dataUsuario)=>{
            if(err) throw err;
            res.send(JSON.stringify(dataUsuario))
            // const usu = usuario;
            // if(err) return res.status(500).send({status:false,message: 'Error en la petición'});
            // if(dataUsuario){res.status(201).json({message: 'Iniciando Sesión',dataUsuario});
            //     }else{
            //         res.status(500).json({message: 'El usuario no se ha podido identificar'});
                    
            // }
            // console.log(usu) 
           
                })
              
    };
        
//loginUserAdmin
function loginUserAdmin(req, res,done){
    const params = req.body
    const usuario = params.usuario
    const contrasena = params.contrasena
        Usuario.LoginUsuarioAdmin({usuario,contrasena},(err,dataUsuario)=>{
            if(err) throw err;
                    res.send(JSON.stringify(dataUsuario));
      })
              
    };

function removeTipoUsuario(req,res){
       // const params = req.body
        const id = req.params.id
        Usuario.deleteTipoUsuario(id,(err, data)=>{
            console.log(id);
            if(err) throw err;
                res.send(JSON.stringify(data));   
        })
    };


function SaveTipoUsuario(req,res){
         const params = req.body
         const tipo_usuario = params.tipo_usuario
         Usuario.insertTipoUsuario(tipo_usuario,(err, data)=>{
             console.log(tipo_usuario);
             if(err) throw err;
                 res.send(JSON.stringify(data));   
         })
     };

function getTipoUsuario(req,res){
    Usuario.getTipoUsuarios((err, data)=>{
        if(err) throw err;
            res.send(JSON.stringify(data));   
    })
};

function getTodoTipoUsuario(req,res){
    Usuario.todosTiposUsuarioGet((err, data)=>{
        if(err) throw err;
            res.send(JSON.stringify(data));   
    })
};


function getUsuarios(req,res){
    Usuario.getUsuarios((err,data)=>{
        if(err) throw err;
            res.send(JSON.stringify(data));
    });

}

    function saveUser(req, res){
    //app.post('/usuario-nuevo', (req, res)=>{
        const params = req.body
        const cedula = params.cedula
        const nombres = params.nombres
        const apellido_p = params.apellido_p
        const apellido_m = params.apellido_m
        const huella_dactilar = params.huella_dactilar
        const correo = params.correo
        const telefono = params.telefono
        const direccion = params.direccion
        const tipo_usuario_id = params.tipo_usuario_id
        const estado_usuario_id = params.estado_usuario_id
        // var UsuarioData={};
        // UsuarioData.cedula=req.body.cedula,
        // UsuarioData.nombres=req.body.nombres,
        
        // UsuarioData.apellido_p=req.body.apellido_p,
        // UsuarioData.apellido_m=req.body.apellido_m,
        // UsuarioData.huella_dactilar=req.body.huella_dactilar,
        // UsuarioData.correo=req.body.correo,
        // UsuarioData.telefono=req.body.telefono,
        // UsuarioData.direccion=req.body.direccion,
        // UsuarioData.tipo_usuario_id= req.body.tipo_usuario_id,
        // UsuarioData.estado_usuario_id=1
       // console.log(UsuarioData);
        Usuario.InsertUsuario({cedula,nombres,apellido_p,apellido_m,huella_dactilar,correo,telefono,direccion
        ,tipo_usuario_id,estado_usuario_id},(err,dataUsuario)=>{
       
            if(err) throw err;
                    res.send(JSON.stringify(dataUsuario));
        //    if(data){
               
        //        res.status(200).json({
        //            data: data
        //        });
        //    }else{
        //        res.status(500).json({
        //            data: data
        //        });
        //    }
         });
    };
//}

module.exports = {
    saveUser,
    getUsuarios,
    loginUser,
    loginUserAdmin,
    getTipoUsuario,
    SaveTipoUsuario,
    removeTipoUsuario,
    getTodoTipoUsuario,
    //getUsers,
    //updateUser,
    //uploadImage,
	//getImageFile
}