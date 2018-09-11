-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.34-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura de base de datos para db_descuentos
CREATE DATABASE IF NOT EXISTS `db_descuentos` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_descuentos`;


-- Volcando estructura para tabla db_descuentos.ciudad
CREATE TABLE IF NOT EXISTS `ciudad` (
  `id_ciudad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  KEY `PK_ciudad` (`id_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.ciudad: ~4 rows (aproximadamente)
DELETE FROM `ciudad`;
/*!40000 ALTER TABLE `ciudad` DISABLE KEYS */;
INSERT INTO `ciudad` (`id_ciudad`, `nombre`) VALUES
	(1, 'Medellín'),
	(2, 'Bello'),
	(3, 'Itagüí'),
	(4, 'Sabaneta'),
	(5, 'Envigado');
/*!40000 ALTER TABLE `ciudad` ENABLE KEYS */;


-- Volcando estructura para tabla db_descuentos.comercio
CREATE TABLE IF NOT EXISTS `comercio` (
  `id_comercio` int(11) NOT NULL AUTO_INCREMENT,
  `nit` varchar(100) NOT NULL DEFAULT '0',
  `nombre` varchar(100) NOT NULL DEFAULT '0',
  `razon_social` varchar(100) NOT NULL DEFAULT '0',
  `estado` int(11) NOT NULL DEFAULT '0',
  KEY `PK_comercio` (`id_comercio`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.comercio: ~0 rows (aproximadamente)
DELETE FROM `comercio`;
/*!40000 ALTER TABLE `comercio` DISABLE KEYS */;
INSERT INTO `comercio` (`id_comercio`, `nit`, `nombre`, `razon_social`, `estado`) VALUES
	(1, '1000000', 'Kokoriko', 'Kokoriko', 1);
/*!40000 ALTER TABLE `comercio` ENABLE KEYS */;


-- Volcando estructura para tabla db_descuentos.momento_dia
CREATE TABLE IF NOT EXISTS `momento_dia` (
  `id_momento_dia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  KEY `PK_momento_dia` (`id_momento_dia`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.momento_dia: ~0 rows (aproximadamente)
DELETE FROM `momento_dia`;
/*!40000 ALTER TABLE `momento_dia` DISABLE KEYS */;
INSERT INTO `momento_dia` (`id_momento_dia`, `nombre`) VALUES
	(1, 'Almuerzo');
/*!40000 ALTER TABLE `momento_dia` ENABLE KEYS */;


-- Volcando estructura para tabla db_descuentos.promocion
CREATE TABLE IF NOT EXISTS `promocion` (
  `id_promocion` int(11) NOT NULL AUTO_INCREMENT,
  `id_punto_atencion` int(11) NOT NULL,
  `id_momento_dia` int(11) DEFAULT NULL,
  `id_tipo_comida` int(11) DEFAULT NULL,
  `id_restriccion_alimenticia` int(11) DEFAULT NULL,
  `id_tipo_promocion` int(11) NOT NULL,
  `precio` int(11) NOT NULL,
  `porcion_descuento` float NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `inicio` date DEFAULT NULL,
  `fin` date DEFAULT NULL,
  KEY `PK_promocion` (`id_promocion`),
  KEY `FK_promocion_puntos_atencion` (`id_punto_atencion`),
  KEY `FK_promocion_momento_dia` (`id_momento_dia`),
  KEY `FK_promocion_tipo_comida` (`id_tipo_comida`),
  KEY `FK_promocion_restriccion_alimenticia` (`id_restriccion_alimenticia`),
  KEY `FK_promocion_tipo_promocion` (`id_tipo_promocion`),
  CONSTRAINT `FK_promocion_momento_dia` FOREIGN KEY (`id_momento_dia`) REFERENCES `momento_dia` (`id_momento_dia`),
  CONSTRAINT `FK_promocion_puntos_atencion` FOREIGN KEY (`id_punto_atencion`) REFERENCES `puntos_atencion` (`id_puntos_atencion`),
  CONSTRAINT `FK_promocion_restriccion_alimenticia` FOREIGN KEY (`id_restriccion_alimenticia`) REFERENCES `restriccion_alimenticia` (`id_restriccion_alimenticia`),
  CONSTRAINT `FK_promocion_tipo_comida` FOREIGN KEY (`id_tipo_comida`) REFERENCES `tipo_comida` (`id_tipo_comida`),
  CONSTRAINT `FK_promocion_tipo_promocion` FOREIGN KEY (`id_tipo_promocion`) REFERENCES `tipo_promocion` (`id_tipo_promocion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.promocion: ~3 rows (aproximadamente)
DELETE FROM `promocion`;
/*!40000 ALTER TABLE `promocion` DISABLE KEYS */;
INSERT INTO `promocion` (`id_promocion`, `id_punto_atencion`, `id_momento_dia`, `id_tipo_comida`, `id_restriccion_alimenticia`, `id_tipo_promocion`, `precio`, `porcion_descuento`, `descripcion`, `nombre`, `fecha_hora`, `cantidad`, `inicio`, `fin`) VALUES
	(1, 1, 1, 1, NULL, 1, 25000, 0.1, 'Hamburguesa de pollo apanado x 5 und', '5 Hamburguesas', '0000-00-00 00:00:00', NULL, NULL, NULL),
	(2, 1, 1, 1, NULL, 1, 50000, 0.1, 'Hamburguesa de pollo apanado x 7 und', '7 Hamburguesas', '2018-08-31 15:47:42', NULL, NULL, NULL),
	(3, 1, 1, 1, NULL, 2, 3000, 0.5, 'Sundae de helado 2 X 1', 'Sundae 2 X 1', '0000-00-00 00:00:00', 100, NULL, NULL);
/*!40000 ALTER TABLE `promocion` ENABLE KEYS */;


-- Volcando estructura para tabla db_descuentos.puntos_atencion
CREATE TABLE IF NOT EXISTS `puntos_atencion` (
  `id_puntos_atencion` int(11) NOT NULL AUTO_INCREMENT,
  `id_comercio` int(11) NOT NULL,
  `id_ciudad` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `barrio` varchar(100) NOT NULL,
  `latitud` varchar(50) NOT NULL,
  `longitud` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  KEY `PK_puntos_atencion` (`id_puntos_atencion`),
  KEY `FK_puntos_atencion_comercio` (`id_comercio`),
  KEY `FK_puntos_atencion_ciudad` (`id_ciudad`),
  CONSTRAINT `FK_puntos_atencion_ciudad` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`),
  CONSTRAINT `FK_puntos_atencion_comercio` FOREIGN KEY (`id_comercio`) REFERENCES `comercio` (`id_comercio`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.puntos_atencion: ~1 rows (aproximadamente)
DELETE FROM `puntos_atencion`;
/*!40000 ALTER TABLE `puntos_atencion` DISABLE KEYS */;
INSERT INTO `puntos_atencion` (`id_puntos_atencion`, `id_comercio`, `id_ciudad`, `nombre`, `direccion`, `barrio`, `latitud`, `longitud`, `telefono`) VALUES
	(1, 1, 1, 'Kokoriko Avenida Colombia', 'Calle 50 47 58', 'Estadio', '6.257156', '-75.582983', '4442020');
/*!40000 ALTER TABLE `puntos_atencion` ENABLE KEYS */;


-- Volcando estructura para tabla db_descuentos.redencion
CREATE TABLE IF NOT EXISTS `redencion` (
  `id_redencion` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL DEFAULT '0',
  `id_promocion` int(11) NOT NULL DEFAULT '0',
  `estado` int(11) NOT NULL DEFAULT '0',
  `codigo` varchar(50) NOT NULL DEFAULT '0',
  `fecha_hora` datetime NOT NULL,
  KEY `PK_redencion` (`id_redencion`),
  KEY `FK_redencion_usuario` (`id_usuario`),
  KEY `FK_redencion_promocion` (`id_promocion`),
  CONSTRAINT `FK_redencion_promocion` FOREIGN KEY (`id_promocion`) REFERENCES `promocion` (`id_promocion`),
  CONSTRAINT `FK_redencion_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.redencion: ~0 rows (aproximadamente)
DELETE FROM `redencion`;
/*!40000 ALTER TABLE `redencion` DISABLE KEYS */;
/*!40000 ALTER TABLE `redencion` ENABLE KEYS */;


-- Volcando estructura para tabla db_descuentos.restriccion_alimenticia
CREATE TABLE IF NOT EXISTS `restriccion_alimenticia` (
  `id_restriccion_alimenticia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  KEY `PK_restriccion_alimenticia` (`id_restriccion_alimenticia`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.restriccion_alimenticia: ~2 rows (aproximadamente)
DELETE FROM `restriccion_alimenticia`;
/*!40000 ALTER TABLE `restriccion_alimenticia` DISABLE KEYS */;
INSERT INTO `restriccion_alimenticia` (`id_restriccion_alimenticia`, `nombre`) VALUES
	(1, 'Vegano'),
	(2, 'Vegetariano');
/*!40000 ALTER TABLE `restriccion_alimenticia` ENABLE KEYS */;


-- Volcando estructura para tabla db_descuentos.tipo_comida
CREATE TABLE IF NOT EXISTS `tipo_comida` (
  `id_tipo_comida` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  KEY `PK_tipo_comida` (`id_tipo_comida`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.tipo_comida: ~0 rows (aproximadamente)
DELETE FROM `tipo_comida`;
/*!40000 ALTER TABLE `tipo_comida` DISABLE KEYS */;
INSERT INTO `tipo_comida` (`id_tipo_comida`, `nombre`) VALUES
	(1, 'Hamburguesas');
/*!40000 ALTER TABLE `tipo_comida` ENABLE KEYS */;


-- Volcando estructura para tabla db_descuentos.tipo_promocion
CREATE TABLE IF NOT EXISTS `tipo_promocion` (
  `id_tipo_promocion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  KEY `PK_tipo_promocion` (`id_tipo_promocion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.tipo_promocion: ~2 rows (aproximadamente)
DELETE FROM `tipo_promocion`;
/*!40000 ALTER TABLE `tipo_promocion` DISABLE KEYS */;
INSERT INTO `tipo_promocion` (`id_tipo_promocion`, `nombre`) VALUES
	(1, 'Convencional'),
	(2, 'Cantidad de usuarios'),
	(3, 'Tiempo limitado');
/*!40000 ALTER TABLE `tipo_promocion` ENABLE KEYS */;


-- Volcando estructura para tabla db_descuentos.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_comercio` int(11) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `sexo` varchar(1) DEFAULT NULL,
  `celular` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  KEY `PK_usuario` (`id_usuario`),
  KEY `FK_usuario_comercio` (`id_comercio`),
  CONSTRAINT `FK_usuario_comercio` FOREIGN KEY (`id_comercio`) REFERENCES `comercio` (`id_comercio`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.usuario: ~3 rows (aproximadamente)
DELETE FROM `usuario`;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id_usuario`, `id_comercio`, `nombre`, `fecha_nacimiento`, `sexo`, `celular`, `email`, `password`, `estado`) VALUES
	(1, NULL, 'Walter Restrepo', '1991-03-16', 'M', '3012858767', 'rpowalter@gmail.com', '789', 1),
	(2, NULL, 'Josue', '1980-08-31', 'M', '3000000000', 'josue@gmail.com', '456', 1),
	(3, NULL, 'Anderson', '1990-08-31', 'M', '3000000000', 'anderson@correo.com', '123', 1),
	(4, 1, 'Juan Gallego', '1980-08-31', 'M', '3001234567', 'juan.gallego@kokoriko.com', '000', 1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;


-- Volcando estructura para tabla db_descuentos.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.usuarios: ~0 rows (aproximadamente)
DELETE FROM `usuarios`;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
