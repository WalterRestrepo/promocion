//console.log("Console test");
//codepen
//node server.js ->Para correr
//npm cache clean --force
//figma
var express = require("express");
var app = express();
var path = require("path");
var mysql = require("mysql");
const application = require('./application.json')
var Sequelize = require('sequelize');
var cookieParser = require('cookie-parser');
var session = require('express-session');
var User = require('./models/user');
var morgan = require('morgan');
var bodyParser = require('body-parser');

app.use(morgan('dev'));//Debug
const sequelize = new Sequelize(application.database, application.username, application.password, {
    host: application.host,
    dialect: 'mysql'
});
var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "6uHsCIhZlaxc",
    database: "db_descuentos"
});
//Configuramos la aplicacion
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(session({
    key: 'user_sid',
    secret: 'promocionesya',
    resave: false,
    saveUninitialized: false,
    cookie: { expires: 600000 }
}));
app.use((req, res, next) => {
    if (req.cookies.user_sid && !req.session.user) {
        res.clearCookie('user_sid');
    }
    next();
});
var sessionChecker = (req, res, next) => {
    if (req.session.user && req.cookies.user_sid) {
        res.redirect('/inicio');
    } else {
        next();
    }
};
app.get('/', sessionChecker, (req, res) => {
    res.redirect('/login');
});
app.get('/iniciarsesioncss', (req, res) => {
    res.sendFile(__dirname + '/css/iniciarsesion.css');
});
app.get('/listapromocionescss', (req, res) => {
    res.sendFile(__dirname + '/css/listapromociones.css');
});
app.get('/registrocss', (req, res) => {
    res.sendFile(__dirname + '/css/registro.css');
});
app.get('/vistadetalladacss', (req, res) => {
    res.sendFile(__dirname + '/css/vistadetallada.css');
});
app.get('/inicio', (req, res) => {
    if (req.session.user && req.cookies.user_sid) {
        res.sendFile(__dirname + '/public/listaPromociones.html');
    } else {
        res.redirect('/login');
    }
});
app.get('/get/detallePromocion/:id', (req, res) => {
    var usuario = req.params.usuario;
    if (req.session.user && req.cookies.user_sid) {
        res.sendFile(__dirname + '/public/listaPromociones.html');
    } else {
        res.redirect('/login');
    }
});
app.route('/login')
    .get(sessionChecker, (req, res) => {
        res.sendFile(__dirname + '/public/iniciarSesion.html');
    })
    .post((req, res) => {
        var email = req.body.email,
            password = req.body.password;
        console.debug(email);
        console.debug(password);
        User.findOne({ where: { email: email } }).then(function (user) {
            if (!user) {
                res.redirect('/login');
            } else if (!user.validPassword(password)) {
                res.redirect('/login');
            } else {
                req.session.user = user.dataValues;
                res.redirect('/inicio');
            }
        });
    });
app.get('/promociones/get', function (req, res) {
    var consulta = "SELECT pr.id_promocion, co.nombre as NombreComercio, pr.nombre as NombrePromocion, pr.precio, pr.porcion_descuento, pr.descripcion,";
    consulta += " pa.direccion, pa.barrio, pa.telefono, pa.latitud, pa.longitud, mo.nombre as MomentoDia, ra.nombre as Restriccion,";
    consulta += " tc.nombre as TipoComida, tp.nombre as TipoPromocion, pr.cantidad";
    consulta += " FROM promocion pr";
    consulta += " INNER JOIN puntos_atencion pa ON pr.id_punto_atencion = pa.id_puntos_atencion";
    consulta += " INNER JOIN comercio co ON co.id_comercio = pa.id_comercio";
    consulta += " INNER JOIN tipo_promocion tp ON tp.id_tipo_promocion = pr.id_tipo_promocion";
    consulta += " LEFT JOIN momento_dia mo ON mo.id_momento_dia = pr.id_momento_dia";
    consulta += " LEFT JOIN restriccion_alimenticia ra ON ra.id_restriccion_alimenticia = pr.id_restriccion_alimenticia";
    consulta += " LEFT JOIN tipo_comida tc ON tc.id_tipo_comida = pr.id_tipo_comida";
    consulta += " WHERE pr.id_tipo_promocion = 3 OR";
    consulta += " (pr.cantidad > 0 and pr.id_tipo_promocion = 2) OR";
    consulta += " (pr.id_tipo_promocion = 1 AND now() BETWEEN pr.inicio and pr.fin)";
    con.query(consulta, function (err, result, fields) {
        if (err) throw err;
        res.json(result);
    });
});

app.get('/promociones/momento/get', function (req, res) {
    var consulta = "SELECT distinct mo.nombre as MomentoDia";
    consulta += " FROM promocion pr";
    consulta += " INNER JOIN puntos_atencion pa ON pr.id_punto_atencion = pa.id_puntos_atencion";
    consulta += " INNER JOIN comercio co ON co.id_comercio = pa.id_comercio";
    consulta += " INNER JOIN tipo_promocion tp ON tp.id_tipo_promocion = pr.id_tipo_promocion";
    consulta += " LEFT JOIN momento_dia mo ON mo.id_momento_dia = pr.id_momento_dia";
    consulta += " LEFT JOIN restriccion_alimenticia ra ON ra.id_restriccion_alimenticia = pr.id_restriccion_alimenticia";
    consulta += " LEFT JOIN tipo_comida tc ON tc.id_tipo_comida = pr.id_tipo_comida";
    consulta += " WHERE mo.nombre is not null and (pr.id_tipo_promocion = 3 OR";
    consulta += " (pr.cantidad > 0 and pr.id_tipo_promocion = 2) OR";
    consulta += " (pr.id_tipo_promocion = 1 AND now() BETWEEN pr.inicio and pr.fin))";
    con.query(consulta, function (err, result, fields) {
        if (err) throw err;
        res.json(result);
    });
});

app.get('/promociones/restriccion/get', function (req, res) {
    var consulta = "SELECT distinct ra.nombre as Restriccion";
    consulta += " FROM promocion pr";
    consulta += " INNER JOIN puntos_atencion pa ON pr.id_punto_atencion = pa.id_puntos_atencion";
    consulta += " INNER JOIN comercio co ON co.id_comercio = pa.id_comercio";
    consulta += " INNER JOIN tipo_promocion tp ON tp.id_tipo_promocion = pr.id_tipo_promocion";
    consulta += " LEFT JOIN momento_dia mo ON mo.id_momento_dia = pr.id_momento_dia";
    consulta += " LEFT JOIN restriccion_alimenticia ra ON ra.id_restriccion_alimenticia = pr.id_restriccion_alimenticia";
    consulta += " LEFT JOIN tipo_comida tc ON tc.id_tipo_comida = pr.id_tipo_comida";
    consulta += " WHERE ra.nombre is not null and (pr.id_tipo_promocion = 3 OR";
    consulta += " (pr.cantidad > 0 and pr.id_tipo_promocion = 2) OR";
    consulta += " (pr.id_tipo_promocion = 1 AND now() BETWEEN pr.inicio and pr.fin))";
    con.query(consulta, function (err, result, fields) {
        if (err) throw err;
        res.json(result);
    });
});

app.get('/promociones/tipocomida/get', function (req, res) {
    var consulta = "SELECT distinct tc.nombre as TipoComida";
    consulta += " FROM promocion pr";
    consulta += " INNER JOIN puntos_atencion pa ON pr.id_punto_atencion = pa.id_puntos_atencion";
    consulta += " INNER JOIN comercio co ON co.id_comercio = pa.id_comercio";
    consulta += " INNER JOIN tipo_promocion tp ON tp.id_tipo_promocion = pr.id_tipo_promocion";
    consulta += " LEFT JOIN momento_dia mo ON mo.id_momento_dia = pr.id_momento_dia";
    consulta += " LEFT JOIN restriccion_alimenticia ra ON ra.id_restriccion_alimenticia = pr.id_restriccion_alimenticia";
    consulta += " LEFT JOIN tipo_comida tc ON tc.id_tipo_comida = pr.id_tipo_comida";
    consulta += " WHERE tc.nombre is not null and (pr.id_tipo_promocion = 3 OR";
    consulta += " (pr.cantidad > 0 and pr.id_tipo_promocion = 2) OR";
    consulta += " (pr.id_tipo_promocion = 1 AND now() BETWEEN pr.inicio and pr.fin))";
    con.query(consulta, function (err, result, fields) {
        if (err) throw err;
        res.json(result);
    });
});

app.get('/promociones/get/:id', function (req, res) {
    var id = req.params.id;
    var consulta = "SELECT pr.id_promocion, co.nombre as NombreComercio, pr.nombre as NombrePromocion, pr.precio, pr.porcion_descuento, pr.descripcion,";
    consulta += " pa.direccion, pa.barrio, pa.telefono, pa.latitud, pa.longitud, mo.nombre as MomentoDia, ra.nombre as Restriccion,";
    consulta += " tc.nombre as TipoComida, tp.nombre as TipoPromocion, pr.cantidad, ip.imagen";
    consulta += " FROM promocion pr";
    consulta += " INNER JOIN puntos_atencion pa ON pr.id_punto_atencion = pa.id_puntos_atencion";
    consulta += " INNER JOIN comercio co ON co.id_comercio = pa.id_comercio";
    consulta += " INNER JOIN tipo_promocion tp ON tp.id_tipo_promocion = pr.id_tipo_promocion";
    consulta += " LEFT JOIN momento_dia mo ON mo.id_momento_dia = pr.id_momento_dia";
    consulta += " LEFT JOIN restriccion_alimenticia ra ON ra.id_restriccion_alimenticia = pr.id_restriccion_alimenticia";
    consulta += " LEFT JOIN tipo_comida tc ON tc.id_tipo_comida = pr.id_tipo_comida";
    consulta += " LEFT JOIN imagen_promocion ip ON ip.id_promocion = pr.id_promocion";
    consulta += " WHERE (pr.id_tipo_promocion = 3 OR";
    consulta += " (pr.cantidad > 0 and pr.id_tipo_promocion = 2) OR";
    consulta += " (pr.id_tipo_promocion = 1 AND now() BETWEEN pr.inicio and pr.fin))";
    consulta += " AND pr.id_promocion = ?";
    con.query(consulta, [id], function (err, result, fields) {
        if (err) throw err;
        res.json(result);
    });
});

app.route('/redencion/save')
    .get(sessionChecker, (req, res) => {
        res.sendFile(__dirname + '/public/login.html');
    })
    .post((req, res) => {
        var idUsuario = req.session.user.id;
        var promocion = req.body.id_promocion
        var codigo = req.body.codigo;
        con.query("INSERT INTO redencion (id_redencion, id_usuario, id_promocion, estado, codigo, fecha_hora) VALUES (?, ?, ?, 0, ?, CURRENT_TIMESTAMP);",
            [null, idUsuario, promocion, codigo], function (err, result, fields) {
                if (err) throw err;
                if (result.affectedRows >= 1) {
                    res.json({ insert: true });
                } else {
                    res.json({ insert: false });
                }
            });

    });

app.get('/redencion/redeem/:codigo/:comercio', function (req, res) {
    var promocion = req.params.promocion;
    var codigo = req.params.codigo;
    var idUsuario = req.session.user.id;
});

app.get('/id_usuario/get', function (req, res) {
    console.log(req.session.user.id);
});

// app.get('/logout', (req, res) => {
//     if (req.session.user && req.cookies.user_sid) {
//         res.clearCookie('user_sid');
//         res.redirect('/');
//     } else {
//         res.redirect('/login');
//     }
// });
app.route('/signup')
    .get(sessionChecker, (req, res) => {
        res.sendFile(__dirname + '/public/registroUsuario.html');
    })
    .post((req, res) => {
        console.debug(req.body.nombre);
        console.debug(req.body.fecha_nacimiento);
        console.debug(req.body.Genero_M);
        console.debug(req.body.Genero_F);
        console.debug(req.body.celular);
        console.debug(req.body.email);
        console.debug(req.body.clave);
        var sexoH = "M";
        if (req.body.Genero_F == undefined && req.body.Genero_M == undefined) {
        } else if (req.body.Genero_F == undefined && req.body.Genero_M !== undefined) {
            sexoH = "M";
        } else if (req.body.Genero_F !== undefined && req.body.Genero_M == undefined) {
            sexoH = "F";
        }
        User.create({
            nombre: req.body.nombre,
            fecha_nacimiento: req.body.fecha_nacimiento,
            sexo: sexoH,
            celular: req.body.celular,
            email: req.body.email,
            password: req.body.clave,
            id_comercio: null,
            estado: 1,
        })
            .then(user => {
                console.debug("Creado");
                req.session.user = user.dataValues;
                res.redirect('/inicio');
            })
            .catch(error => {
                console.debug("Error");
                res.redirect('/signup');
            });
    });


// //auditoria
// app.get('/auditoria/get', function (req, res) {
//     con.query("SELECT * FROM auditoria", function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });
// app.get('/auditoria/get/:id', function (req, res) {
//     var id = req.params.id;
//     con.query("SELECT * FROM auditoria WHERE id = ?", [id], function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });
// app.get('/auditoria/save/:empresa/:pregunta/:respuesta/:norma/:auditor', function (req, res) {
//     var empresa = req.params.empresa;
//     var pregunta = req.params.pregunta;
//     var respuesta = req.params.respuesta;
//     var norma = req.params.norma;
//     var auditor = req.params.auditor;
//     con.query("INSERT INTO auditoria (id, empresa, pregunta, respuesta, norma, fecha, auditor) VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?);",
//         [null, empresa, pregunta, respuesta, norma, auditor], function (err, result, fields) {
//             if (err) throw err;
//             if (result.affectedRows >= 1) {
//                 res.json({ insert: true });
//             } else {
//                 res.json({ insert: false });
//             }
//         });
// });
// app.get('/auditoriaresultado/get/:idempresa', function (req, res) {
//     var idempresa = req.params.idempresa;
//     var consulta = "select e.nombre, e.nit, n.nombre, p.texto, a.respuesta, u.usuario, a.fecha from auditoria a ";
//     consulta = consulta + "inner join empresa e on a.empresa = e.id ";
//     consulta = consulta + "inner join pregunta p on a.pregunta = p.id ";
//     consulta = consulta + "inner join norma n on a.norma = n.id ";
//     consulta = consulta + "inner join usuario u on a.auditor = u.id ";
//     consulta = consulta + "where e.id = ?;";
//     con.query(consulta, [idempresa], function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });

// //empresa
// app.get('/empresa/get', function (req, res) {
//     con.query("SELECT * FROM empresa", function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });
// app.get('/empresa/get/:id', function (req, res) {
//     var id = req.params.id;
//     con.query("SELECT * FROM empresa WHERE id = ?", [id], function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });
// app.get('/empresa/save/:name/:nit', function (req, res) {
//     var name = req.params.name;
//     var nit = req.params.nit;
//     con.query("INSERT INTO empresa (id, nombre, nit) VALUES (?, ?, ?);", [null, name, nit], function (err, result, fields) {
//         if (err) throw err;
//         if (result.affectedRows >= 1) {
//             res.json({ insert: true });
//         } else {
//             res.json({ insert: false });
//         }
//     });
// });

// //norma
// app.get('/norma/get', function (req, res) {
//     con.query("SELECT * FROM norma", function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });
// app.get('/norma/get/:id', function (req, res) {
//     var id = req.params.id;
//     con.query("SELECT * FROM norma WHERE id = ?", [id], function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });
// app.get('/norma/save/:name', function (req, res) {
//     var name = req.params.name;
//     con.query("INSERT INTO norma (id, nombre) VALUES (?, ?);", [null, name], function (err, result, fields) {
//         if (err) throw err;
//         if (result.affectedRows >= 1) {
//             res.json({ insert: true });
//         } else {
//             res.json({ insert: false });
//         }
//     });
// });

// //preguntas
// app.get('/pregunta/get', function (req, res) {
//     con.query("SELECT * FROM pregunta", function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });
// app.get('/pregunta/get/:id', function (req, res) {
//     var id = req.params.id;
//     con.query("SELECT * FROM pregunta WHERE id = ?", [id], function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });
// app.get('/preguntanorma/get/:idnorma', function (req, res) {
//     var idnorma = req.params.idnorma;
//     con.query("SELECT * FROM pregunta WHERE norma = ?", [idnorma], function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });
// app.get('/pregunta/save/:idnorma/:pregunta', function (req, res) {
//     var idnorma = req.params.idnorma;
//     var pregunta = req.params.pregunta;
//     con.query("INSERT INTO pregunta (id, norma, texto) VALUES (?, ?, ?);", [null, idnorma, pregunta], function (err, result, fields) {
//         if (err) throw err;
//         if (result.affectedRows >= 1) {
//             res.json({ insert: true });
//         } else {
//             res.json({ insert: false });
//         }
//     });
// });

//usuario
// app.get('/usuario/get/:id', function (req, res) {
//     var id = req.params.id;
//     con.query("SELECT * FROM usuario WHERE id = ?", [id], function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });
// app.get('/usuario/login/:usuario/:clave', function (req, res) {
//     var usuario = req.params.usuario;
//     var clave = req.params.clave;
//     con.query("SELECT * FROM usuario WHERE usuario = ? AND clave = ? LIMIT 1;", [usuario, clave], function (err, result, fields) {
//         if (err) throw err;
//         res.json(result);
//     });
// });
// app.get('/usuario/save/:usuario/:clave', function (req, res) {
//     var usuario = req.params.usuario;
//     var clave = req.params.clave;
//     con.query("INSERT INTO usuario (id, usuario, clave) VALUES (?, ?, ?);", [null, usuario, clave], function (err, result, fields) {
//         if (err) throw err;
//         if (result.affectedRows >= 1) {
//             res.json({ insert: true });
//         } else {
//             res.json({ insert: false });
//         }
//     });
// });

app.listen(3500, function () {
    console.log("Funciona 127.0.0.1:3500");
});

/*
app.get("/", function (req, res){
    res.send("Hola.");    
});
app.get("/test", function (req, res){
    res.send("Test.");    
});
app.listen(3000, function (){console.log("Funciona");});*/

// app.get('/crearComercio', function (req, res) {
//     res.sendFile(
//         path.join(__dirname + '/public/crearComercio.html')
//     );
// });
// app.route('/crearComercioPost')
//     .get(sessionChecker, (req, res) => {
//         res.sendFile(__dirname + '/public/login.html');
//     })
//     .post((req, res) => {
//         var nitComercio = req.body.nitComercio,
//             nombreComercio = req.body.nombreComercio,
//             razonComercio = req.body.razonComercio;
//         con.query("INSERT INTO comercio (id, nit, nombre, razon_social, estado) VALUES (?, ?, ?, ?, ?);",
//             [null, nitComercio, nombreComercio, razonComercio, 1], function (err, result, fields) {
//                 if (err) throw err;
//                 if (result.affectedRows == 1) {
//                     res.sendFile(__dirname + '/public/comercioCreado.html');
//                 } else {
//                     res.sendFile(__dirname + '/public/comercioNoCreado.html');
//                 }
//             });
//     });