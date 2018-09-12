-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.35-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para db_descuentos
DROP DATABASE IF EXISTS `db_descuentos`;
CREATE DATABASE IF NOT EXISTS `db_descuentos` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_descuentos`;

-- Volcando estructura para tabla db_descuentos.ciudad
DROP TABLE IF EXISTS `ciudad`;
CREATE TABLE IF NOT EXISTS `ciudad` (
  `id_ciudad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  KEY `PK_ciudad` (`id_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.ciudad: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `ciudad` DISABLE KEYS */;
INSERT INTO `ciudad` (`id_ciudad`, `nombre`) VALUES
	(1, 'Medellín'),
	(2, 'Bello'),
	(3, 'Itagüí'),
	(4, 'Sabaneta'),
	(5, 'Envigado');
/*!40000 ALTER TABLE `ciudad` ENABLE KEYS */;

-- Volcando estructura para tabla db_descuentos.comercio
DROP TABLE IF EXISTS `comercio`;
CREATE TABLE IF NOT EXISTS `comercio` (
  `id_comercio` int(11) NOT NULL AUTO_INCREMENT,
  `nit` varchar(100) NOT NULL DEFAULT '0',
  `nombre` varchar(100) NOT NULL DEFAULT '0',
  `razon_social` varchar(100) NOT NULL DEFAULT '0',
  `estado` int(11) NOT NULL DEFAULT '0',
  KEY `PK_comercio` (`id_comercio`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.comercio: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `comercio` DISABLE KEYS */;
INSERT INTO `comercio` (`id_comercio`, `nit`, `nombre`, `razon_social`, `estado`) VALUES
	(1, '1000000', 'Kokoriko', 'Kokoriko', 1),
	(2, '1000000', 'La Miguera', 'Migueria', 1),
	(1, '100000000-1', 'Kokoriko', 'Kokoriko', 1),
	(2, '10000000', 'La Miguería', 'La Miguería', 1),
	(3, '1000000000', 'El Búho Café', 'El Búho Café', 1),
	(1, '100000000-1', 'Kokoriko', 'Kokoriko', 1),
	(2, '10000000', 'La Miguería', 'La Miguería', 1),
	(3, '1000000000', 'El Búho Café', 'El Búho Café', 1);
/*!40000 ALTER TABLE `comercio` ENABLE KEYS */;

-- Volcando estructura para tabla db_descuentos.momento_dia
DROP TABLE IF EXISTS `momento_dia`;
CREATE TABLE IF NOT EXISTS `momento_dia` (
  `id_momento_dia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  KEY `PK_momento_dia` (`id_momento_dia`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.momento_dia: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `momento_dia` DISABLE KEYS */;
INSERT INTO `momento_dia` (`id_momento_dia`, `nombre`) VALUES
	(1, 'Almuerzo'),
	(1, 'Desayuno'),
	(2, 'Almuerzo'),
	(3, 'Cena');
/*!40000 ALTER TABLE `momento_dia` ENABLE KEYS */;

-- Volcando estructura para tabla db_descuentos.promocion
DROP TABLE IF EXISTS `promocion`;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.promocion: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `promocion` DISABLE KEYS */;
INSERT INTO `promocion` (`id_promocion`, `id_punto_atencion`, `id_momento_dia`, `id_tipo_comida`, `id_restriccion_alimenticia`, `id_tipo_promocion`, `precio`, `porcion_descuento`, `descripcion`, `nombre`, `fecha_hora`, `cantidad`, `inicio`, `fin`) VALUES
	(1, 1, 1, 1, NULL, 1, 25000, 0.1, 'Hamburguesa de pollo apanado x 5 und', '5 Hamburguesas', '0000-00-00 00:00:00', NULL, NULL, NULL),
	(2, 1, 1, 1, NULL, 1, 50000, 0.1, 'Hamburguesa de pollo apanado x 7 und', '7 Hamburguesas', '2018-08-31 15:47:42', NULL, NULL, NULL),
	(3, 1, 1, 1, NULL, 2, 3000, 0.5, 'Sundae de helado 2 X 1', 'Sundae 2 X 1', '0000-00-00 00:00:00', 100, NULL, NULL),
	(1, 3, 2, NULL, NULL, 3, 17900, 0.15, 'Pollo > 4 Presas de pollo apanado, crocantes, jugosas y deliciosas, acompañadas de 6 arepas y miel', 'Medio Frisby Apanado', '0000-00-00 00:00:00', NULL, NULL, NULL),
	(2, 1, 2, 6, NULL, 1, 10000, 0.1, 'Churrasco Argentino al 10%', 'Churrasco Argentino', '2018-09-04 00:00:00', NULL, '2018-09-04', '2018-09-05'),
	(3, 3, 2, 1, 1, 1, 12000, 0.1, 'Talbazco zico', 'Talbazco', '2018-09-05 13:00:00', 3, '2018-09-05', '2018-09-05'),
	(4, 2, 1, NULL, NULL, 2, 2000, 0.5, 'Cafe expreso y almohabana', 'Promo café', '2018-09-04 19:27:15', 100, NULL, NULL),
	(5, 1, 2, 7, 2, 1, 24000, 0.1, 'Pollo ', 'pollo Fivy', '2018-09-05 11:50:00', 5, '2018-09-05', '2018-09-05'),
	(6, 2, 1, NULL, NULL, 1, 5000, 0.2, 'Pan Chocolate 20% Off', 'Pan Chocolate 20% Off', '2018-09-04 19:35:18', NULL, '2018-08-01', '2018-08-31');
/*!40000 ALTER TABLE `promocion` ENABLE KEYS */;

-- Volcando estructura para tabla db_descuentos.puntos_atencion
DROP TABLE IF EXISTS `puntos_atencion`;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.puntos_atencion: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `puntos_atencion` DISABLE KEYS */;
INSERT INTO `puntos_atencion` (`id_puntos_atencion`, `id_comercio`, `id_ciudad`, `nombre`, `direccion`, `barrio`, `latitud`, `longitud`, `telefono`) VALUES
	(1, 1, 1, 'Kokoriko Avenida Colombia', 'Calle 50 47 58', 'Estadio', '6.257156', '-75.582983', '4442020'),
	(1, 3, 1, 'El Buho Estadio', 'Calle 47 70 02', 'Estadio', '6.253275', '-75.587938', '0345810161'),
	(2, 2, 1, 'Migueria Estadio', 'Carrera 66 48 30', 'Suramericana', '6.253908', ' -75.583158', '0344483327'),
	(3, 1, 1, 'Kokoriko Estadio', 'Calle 50 47 58', 'Estadio', '6.257126', '-75.582929', '0344442020');
/*!40000 ALTER TABLE `puntos_atencion` ENABLE KEYS */;

-- Volcando estructura para tabla db_descuentos.redencion
DROP TABLE IF EXISTS `redencion`;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.redencion: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `redencion` DISABLE KEYS */;
INSERT INTO `redencion` (`id_redencion`, `id_usuario`, `id_promocion`, `estado`, `codigo`, `fecha_hora`) VALUES
	(1, 1, 4, 1, '8XTJ', '2018-09-04 19:27:18'),
	(2, 4, 2, 1, 'XYZ', '2018-09-04 00:00:00'),
	(3, 1, 4, 1, 'XHYO', '2018-09-04 19:38:35');
/*!40000 ALTER TABLE `redencion` ENABLE KEYS */;

-- Volcando estructura para tabla db_descuentos.restriccion_alimenticia
DROP TABLE IF EXISTS `restriccion_alimenticia`;
CREATE TABLE IF NOT EXISTS `restriccion_alimenticia` (
  `id_restriccion_alimenticia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  KEY `PK_restriccion_alimenticia` (`id_restriccion_alimenticia`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.restriccion_alimenticia: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `restriccion_alimenticia` DISABLE KEYS */;
INSERT INTO `restriccion_alimenticia` (`id_restriccion_alimenticia`, `nombre`) VALUES
	(1, 'Vegano'),
	(2, 'Vegetariano'),
	(1, 'Vegano'),
	(2, 'Vegetariano');
/*!40000 ALTER TABLE `restriccion_alimenticia` ENABLE KEYS */;

-- Volcando estructura para tabla db_descuentos.tipo_comida
DROP TABLE IF EXISTS `tipo_comida`;
CREATE TABLE IF NOT EXISTS `tipo_comida` (
  `id_tipo_comida` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  KEY `PK_tipo_comida` (`id_tipo_comida`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.tipo_comida: ~78 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_comida` DISABLE KEYS */;
INSERT INTO `tipo_comida` (`id_tipo_comida`, `nombre`) VALUES
	(1, 'Hamburguesas'),
	(1, 'Afgana'),
	(2, 'Africana'),
	(3, 'Albanesa'),
	(4, 'Alemana'),
	(5, 'Árabe'),
	(6, 'Argentina'),
	(7, 'Asiática'),
	(8, 'Australiana'),
	(9, 'Bar'),
	(10, 'Bar de vinos'),
	(11, 'Belga'),
	(12, 'Brasilera'),
	(13, 'Británica'),
	(14, 'Café'),
	(15, 'Cajún y criolla'),
	(16, 'Camboyana'),
	(17, 'Caribeña'),
	(18, 'Centroamericana'),
	(19, 'Cervecería'),
	(20, 'Chilena'),
	(21, 'China'),
	(22, 'China: Fujian'),
	(23, 'Churrasquería'),
	(24, 'Colombiana'),
	(25, 'Comida de calle'),
	(26, 'Comida rápida'),
	(27, 'Contemporánea'),
	(28, 'Coreana'),
	(29, 'Cubana'),
	(30, 'De Europa Central'),
	(31, 'De Europa del Este'),
	(32, 'De la India'),
	(33, 'Del Medio Oriente'),
	(34, 'Del sudoeste de EE.UU'),
	(35, 'Delicatessen'),
	(36, 'Ecuatoriana'),
	(37, 'Egipcia'),
	(38, 'Escocesa'),
	(39, 'Española'),
	(40, 'Estadounidense'),
	(41, 'Europea'),
	(42, 'Francesa'),
	(43, 'Fuente de soda'),
	(44, 'Fusión'),
	(45, 'Gastropub'),
	(46, 'Griega'),
	(47, 'Hawaiana'),
	(48, 'Internacional'),
	(49, 'Irlandesa'),
	(50, 'Israelí'),
	(51, 'Italiana'),
	(52, 'Japonesa'),
	(53, 'Latina'),
	(54, 'Libanesa'),
	(55, 'Mariscos'),
	(56, 'Mediterránea'),
	(57, 'Mexicana'),
	(58, 'Nativo estadounidense'),
	(59, 'Nepalí'),
	(60, 'Pakistaní'),
	(61, 'Parrilla'),
	(62, 'Parrillada'),
	(63, 'Peruana'),
	(64, 'Pizzería'),
	(65, 'Pub'),
	(66, 'Rumana'),
	(67, 'Saludable'),
	(68, 'Salvadoreña'),
	(69, 'Sopas'),
	(70, 'Sudamericana'),
	(71, 'Suiza'),
	(72, 'Sushi'),
	(73, 'Tailandesa'),
	(74, 'Taiwanesa'),
	(75, 'Turca'),
	(76, 'Venezolana'),
	(77, 'Vietnamita');
/*!40000 ALTER TABLE `tipo_comida` ENABLE KEYS */;

-- Volcando estructura para tabla db_descuentos.tipo_promocion
DROP TABLE IF EXISTS `tipo_promocion`;
CREATE TABLE IF NOT EXISTS `tipo_promocion` (
  `id_tipo_promocion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  KEY `PK_tipo_promocion` (`id_tipo_promocion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.tipo_promocion: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_promocion` DISABLE KEYS */;
INSERT INTO `tipo_promocion` (`id_tipo_promocion`, `nombre`) VALUES
	(1, 'Convencional'),
	(2, 'Cantidad de usuarios'),
	(3, 'Tiempo limitado'),
	(1, 'Tiempo limitado'),
	(2, 'Cantidad de Usuarios'),
	(3, 'Convencional');
/*!40000 ALTER TABLE `tipo_promocion` ENABLE KEYS */;

-- Volcando estructura para tabla db_descuentos.usuario
DROP TABLE IF EXISTS `usuario`;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.usuario: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id_usuario`, `id_comercio`, `nombre`, `fecha_nacimiento`, `sexo`, `celular`, `email`, `password`, `estado`) VALUES
	(1, NULL, 'Walter Restrepo', '1991-03-16', 'M', '3012858767', 'rpowalter@gmail.com', '789', 1),
	(2, NULL, 'Josue', '1980-08-31', 'M', '3000000000', 'josue@gmail.com', '456', 1),
	(3, NULL, 'Anderson', '1990-08-31', 'M', '3000000000', 'anderson@correo.com', '123', 1),
	(4, 1, 'Juan Gallego', '1980-08-31', 'M', '3001234567', 'juan.gallego@kokoriko.com', '000', 1),
	(5, NULL, 'Walter Restrepo', '1991-03-16', 'M', '3012858767', 'rpowalter@gmail.com', '123123', 1),
	(6, 1, 'Juan Rivera', '1980-09-12', 'M', '3012858761', 'juanrivera@kokoriko.com.co', 'kokoriko123', 1),
	(7, 2, 'Juan Velez', '1986-09-12', 'M', '3012748761', 'jvelez@gmail.com', 'clave123', 1),
	(8, NULL, 'Andersson Medina', '1993-01-26', 'M', '3117217321', 'zarco-ml26@hotmail.com', 'promociones123', 1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

-- Volcando estructura para tabla db_descuentos.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_comercio` int(11) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `fecha_nacimiento` datetime DEFAULT NULL,
  `sexo` varchar(255) DEFAULT NULL,
  `celular` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `estado` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `celular` (`celular`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla db_descuentos.usuarios: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`, `id_comercio`, `nombre`, `fecha_nacimiento`, `sexo`, `celular`, `email`, `password`, `estado`, `createdAt`, `updatedAt`) VALUES
	(1, NULL, 'walter', '2000-12-13 00:00:00', 'M', '3012858767', '1@1.com', '123', 1, '2018-09-11 21:53:37', '2018-09-11 21:53:37'),
	(2, NULL, 'Nelson Castañeda', '2018-09-11 00:00:00', 'M', '3194665823', 'espinal_nelson@hotmail.com', '123545663', 1, '2018-09-11 22:06:36', '2018-09-11 22:06:36'),
	(3, NULL, 'Anderson', '0000-00-00 00:00:00', 'M', '3000000000', '2@2.com', '123', 1, '2018-09-12 00:13:01', '2018-09-12 00:13:01'),
	(5, NULL, 'Walter Restrepo', '1991-03-16 00:00:00', 'M', '3212858767', 'rpowalter@gmail.com', '123123', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(6, 1, 'Juan Rivera', '1980-09-12 00:00:00', 'M', '3012858761', 'juanrivera@kokoriko.com.co', 'kokoriko123', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(7, 2, 'Juan Velez', '1986-09-12 00:00:00', 'M', '3012748761', 'jvelez@gmail.com', 'clave123', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
	(8, NULL, 'Andersson Medina', '1993-01-26 00:00:00', 'M', '3117217321', 'zarco-ml26@hotmail.com', 'promociones123', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
