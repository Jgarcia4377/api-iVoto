const mysql = require('mysql');
const {promisify} = require('util');
const {config} = require('./keys');

const pool = mysql.createPool(config);
pool.getConnection((err,connection)=>{
    if(err){
        if(err.code ==='PROTOCOL_CONNECTION_LOST'){
            console.error('LA CONEXION CON LA BASE DE DATOS FUE CERRADA');
        }
        if(err.code === 'ER_CON_COUNT_ERROR'){
            console.log('LA BASE DE DATOS TIENE MUCHAS CONEXIONES');
        }
        if(err.code === 'ECONNREFUSED'){
            console.log('LA CONEXION CON LA BASE DE DATOS FUE RECHAZADA');
        }
    }
    if(connection) connection.release();
    console.log('DB esta conectada');
    return;
});
//convertir callbacks en promeasa en base de datos
pool.query = promisify(pool.query);
module.exports = pool;