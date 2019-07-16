// var express = require('express');
// var mysql = require("mysql");



// let config = {
//   host    : 'localhost',
//   user    : 'root',
//   password: '',
//   database: 'iVoto',
//   multipleStatements: true
// };

var mysql = require('mysql');
var config= mysql.createConnection({
  host    : 'localhost',
  user    : 'root',
  password: 'root',
  database: 'iVoto',
  multipleStatements: true
});


config.connect(function(err) {
  if (err) {
      console.error('Error de conexion: ' + err.stack);
      return;
  }
  console.log('Conectado con el identificador ' + config.threadId);
});
module.exports = config;