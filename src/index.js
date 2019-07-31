const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const path = require('path');
const bodyParser = require('body-parser');
const user_routes = require('./routes/usuariosRouter');
const evento_routes = require('./routes/eventoRouter');
//inicializaciones
const app= express();




const cors = require('cors');


//Configuracion del servidor
app.set('port', process.env.PORT || 3000);

//Middlewares
// app.use(morgan('dev'));
// app.use(express.urlencoded({extended:false}));
// app.use(bodyParser.json());

app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended:false}));
app.use(express.json());
app.use((req,res,next)=>{
    res.header('Access-Control-Allow-Origin','*');
    res.header('Access-Control-Allow-Headers','Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method')
    res.header('Access-Control-Allow-Methods','GET, POST, OPTIONS, PUT, DELETE');
    res.header('Allow','GET, POST, OPTIONS, PUT, DELETE');
  next();
})

app.use(cors({origin: '*'}));


//Rutas

//require('./routes/usuariosRouter')(app);
app.use(user_routes);
app.use(evento_routes);

//Archivos publicos



//Iniciar servidor
app.listen(app.get('port'), ()=>{
    console.log("Servidor en puerto", app.get('port'));
});
