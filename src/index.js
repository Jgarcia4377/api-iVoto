const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const path = require('path');
const bodyParser = require('body-parser');
const user_routes = require('./routes/usuariosRouter');
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
app.use(cors({origin: 'http://localhost:8100'}));


//Rutas

//require('./routes/usuariosRouter')(app);
app.use(user_routes);


//Archivos publicos



//Iniciar servidor
app.listen(app.get('port'), ()=>{
    console.log("Servidor en puerto", app.get('port'));
});
