const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const path = require('path');
const bodyParser = require('body-parser');
const user_routes = require('./routes/usuariosRouter');
const evento_routes = require('./routes/eventoRouter');
const voto_routes = require('./routes/votoRouter');
//inicializaciones
const app= express();




const cors = require('cors');

//app.use(cors());
//Configuracion del servidor
app.set('port', process.env.PORT || 3000);

//Middlewares
// app.use(morgan('dev'));
// app.use(express.urlencoded({extended:false}));
// app.use(bodyParser.json());

app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended:false}));
app.use(express.json());
//app.enableCors();
// app.use(function(req, res, next) {
//   res.header("Access-Control-Allow-Origin", "*"); // update to match the domain you will make the request from
//   res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
//   next();
// });



 app.use(cors({origin: '*'}));


//Rutas

//require('./routes/usuariosRouter')(app);
app.use(user_routes,cors());
app.use(evento_routes,cors());
app.use(voto_routes,cors());

//Archivos publicos



//Iniciar servidor
app.listen(app.get('port'), ()=>{
    console.log("Servidor en puerto", app.get('port'));
});
