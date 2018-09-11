var Sequelize = require('sequelize');
// var bcrypt = require('bcrypt');//Esto es para encriptar pero requiere python

// vincula la información de la base de datos
const application = require('../application.json')
// create a sequelize instance with our local postgres database information.

// crea una instancia de la base de datos
var sequelize = new Sequelize(application.database, application.username, application.password, {
    host: application.host,
    dialect: 'mysql'
})

// setup User model and its fields.
// define la estructura de la tabla usuario


// `id_usuario` INT(11) NOT NULL AUTO_INCREMENT,
// `id_comercio` INT(11) NULL DEFAULT NULL,
// `nombre` VARCHAR(50) NOT NULL,
// `fecha_nacimiento` DATE NULL DEFAULT NULL,
// `sexo` VARCHAR(1) NULL DEFAULT NULL,
// `celular` VARCHAR(10) NOT NULL,
// `email` VARCHAR(100) NOT NULL,
// `clave` VARCHAR(100) NOT NULL,
// `estado` INT(11) NOT NULL DEFAULT '1',

var User = sequelize.define('usuario', {
    // username: {
    //     type: Sequelize.STRING,
    //     unique: true,
    //     allowNull: false
    // },
    id_comercio: {
        type: Sequelize.INTEGER,
        unique: false,
        allowNull: true
    },
    nombre: {
        type: Sequelize.STRING,
        unique: false,
        allowNull: false
    },
    fecha_nacimiento: {
        type: Sequelize.DATE,
        unique: false,
        allowNull: true
    },
    sexo: {
        type: Sequelize.STRING,
        unique: false,
        allowNull: true
    },
    celular: {
        type: Sequelize.STRING,
        unique: true,
        allowNull: false
    },
    email: {
        type: Sequelize.STRING,
        unique: true,
        allowNull: false
    },
    password: {
        type: Sequelize.STRING,
        allowNull: false
    },
    estado: {
        type: Sequelize.INTEGER,
        allowNull: false

    }
}, {
        hooks: {
            beforeCreate: (user) => {
                const salt = "";//bcrypt.genSaltSync();// Apagamos la encriptación
                user.password = user.password;//bcrypt.hashSync(user.password, salt);// Apagamos la encriptación
                // user.estado = 1;
                // user.id_comercio = null;
            }
        }
        // instanceMethods: {
        //     validPassword: function (password) {
        //         return bcrypt.compareSync(password, this.password);
        //     }
        // }
    });

User.prototype.validPassword = function (password) {
    //return bcrypt.compareSync(password, this.password); // Apagamos la encriptación
    return (password == this.password);
};
// create all the defined tables in the specified database.
sequelize.sync();

// sequelize.sync()
//     .then(() => console.log('users table has been successfully created, if one doesn\'t exist'))
//     .catch(error => console.log('This error occured', error));

// export User model for use in other files.
module.exports = User;