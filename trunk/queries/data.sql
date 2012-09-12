
-- source truncateDb.sql;

-- Acá iran los DML --

-- PAIS
INSERT INTO pais (nombrePais) values ('Argentina');
INSERT INTO pais (nombrePais) values ('Bolivia');
INSERT INTO pais (nombrePais) values ('Brasil');
INSERT INTO pais (nombrePais) values ('Chile');
INSERT INTO pais (nombrePais) values ('Colombia');
INSERT INTO pais (nombrePais) values ('Paraguay');
INSERT INTO pais (nombrePais) values ('Peru');
INSERT INTO pais (nombrePais) values ('Uruguay');
-- INSERT INTO pais (nombrePais) values ('Venezuela');

-- HOSPEDAJE --
INSERT INTO lugarhospedaje (nombreHospedaje) values ('Hotel Intercontinental');
INSERT INTO lugarhospedaje (nombreHospedaje) values ('Hotel Savoy');
INSERT INTO lugarhospedaje (nombreHospedaje) values ('Hotel Hillton');
INSERT INTO lugarhospedaje (nombreHospedaje) values ('Hotel Sheraton');

-- FUNCION --
INSERT INTO funcion (nombreFuncion) values ('CLINICO');
INSERT INTO funcion (nombreFuncion) values ('TRAUMATOLOGO');
INSERT INTO funcion (nombreFuncion) values ('PSICOLOGO');

-- ESTADIO --
INSERT INTO estadio (nombreEstadio) values ('ElGranBalon');
INSERT INTO estadio (nombreEstadio) values ('MikeJordan');
INSERT INTO estadio (nombreEstadio) values ('BolaAlCesto');

-- ETAPA --
INSERT INTO etapa (nombreEtapa) values ('FASE_GRUPOS');
INSERT INTO etapa (nombreEtapa) values ('5TO_PUESTO');
INSERT INTO etapa (nombreEtapa) values ('SEMIFINAL');
INSERT INTO etapa (nombreEtapa) values ('3ER_PUESTO');
INSERT INTO etapa (nombreEtapa) values ('FINAL');

-- TIPO_SANCION --
INSERT INTO tiposancion (nombreSancion) values ('BLOQUEO');
INSERT INTO tiposancion (nombreSancion) values ('EMPUJE');
INSERT INTO tiposancion (nombreSancion) values ('TRABA');
INSERT INTO tiposancion (nombreSancion) values ('GOLPE');
INSERT INTO tiposancion (nombreSancion) values ('PUÑETAZO');

-- POSICION DEFAULT --
-- INSERT INTO posicion (puntos, partidosJugados, partidosGanados, partidosPerdidos, tantosAFavor, tantosEnContra) values (0, 0, 0, 0, 0, 0);
-- Estos datos los carga un trigger cuando se inserta en la seleccion

-- SELECCION --
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2000-08-20','A', 1, 1, 1);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2000-08-21','A', 2, 2, 2);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2000-08-22','A', 3, 3, 3);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2000-08-23','A', 4, 4 ,1);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2000-08-24','B', 1, 5, 2);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2000-08-20','B', 1, 6, 1);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2000-08-20','B', 1, 7, 1);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2000-08-20','B', 1, 8, 1);

-- INTEGRANTE
-- ARGENTINA ( 12 jugadores, 1 cuerpo tecnico) 

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 101, 'Emanuel', 'Ginobili', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 102, 'Juan', 'Scola', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 103, 'Andres', 'Nocioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 104, 'Pablo', 'Prigioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 105, 'Carlos', 'Delfino', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 106, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 107, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 108, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 109, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 110, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 111, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 112, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 113, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 114, 'Jose', 'Caese', '1950-08-24', 'CUERPOTECNICO');

-- BOLIVIA -- (12 jugadores, 1 cuerpo tecnico) 
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 201, 'Emanuel', 'Ginobili', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 202, 'Juan', 'Scola', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 203, 'Andres', 'Nocioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 204, 'Pablo', 'Prigioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 205, 'Carlos', 'Delfino', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 206, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 207, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 208, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 209, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 210, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 211, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 212, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 213, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 214, 'Jose', 'Caese', '1950-08-24', 'CUERPOTECNICO');

-- BRASIL --
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 301, 'Emanuel', 'Ginobili', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 302, 'Juan', 'Scola', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 303, 'Andres', 'Nocioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 304, 'Pablo', 'Prigioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 305, 'Carlos', 'Delfino', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 306, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 307, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 308, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 309, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 310, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 311, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 312, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 313, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 314, 'Jose', 'Caese', '1950-08-24', 'CUERPOTECNICO');

-- CHILE --
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 401, 'Emanuel', 'Ginobili', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 402, 'Juan', 'Scola', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 403, 'Andres', 'Nocioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 404, 'Pablo', 'Prigioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 405, 'Carlos', 'Delfino', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 406, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 407, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 408, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 409, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 410, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 411, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 412, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 413, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(4, 414, 'Jose', 'Caese', '1950-08-24', 'CUERPOTECNICO');

-- COLOMBIA --
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 501, 'Emanuel', 'Ginobili', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 502, 'Juan', 'Scola', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 503, 'Andres', 'Nocioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 504, 'Pablo', 'Prigioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 505, 'Carlos', 'Delfino', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 506, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 507, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 508, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 509, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 510, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 511, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 512, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 513, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(5, 514, 'Jose', 'Caese', '1950-08-24', 'CUERPOTECNICO');

-- PARAGUAY --
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 601, 'Emanuel', 'Ginobili', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 602, 'Juan', 'Scola', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 603, 'Andres', 'Nocioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 604, 'Pablo', 'Prigioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 605, 'Carlos', 'Delfino', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 606, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 607, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 608, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 609, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 610, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 611, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 612, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 613, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(6, 614, 'Jose', 'Caese', '1960-08-24', 'CUERPOTECNICO');

-- PERU --
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 701, 'Emanuel', 'Ginobili', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 702, 'Juan', 'Scola', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 703, 'Andres', 'Nocioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 704, 'Pablo', 'Prigioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 705, 'Carlos', 'Delfino', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 706, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 707, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 708, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 709, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 710, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 711, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 712, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 713, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(7, 714, 'Jose', 'Caese', '1970-08-24', 'CUERPOTECNICO');

-- URUGUAY ( 5 titulares 1 suplente)
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 801, 'Emanuel', 'Ginobili', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 802, 'Juan', 'Scola', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 803, 'Andres', 'Nocioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 804, 'Pablo', 'Prigioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 805, 'Carlos', 'Delfino', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 806, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 807, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 808, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 809, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 810, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 811, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 812, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 813, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 814, 'Jose', 'Caese', '1980-08-24', 'CUERPOTECNICO');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 815, 'Dr', 'Dolittle', '1972-08-24', 'CUERPOTECNICO');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 816, 'LaChica', 'Masajista', '1972-08-24', 'CUERPOTECNICO');

-- PARTIDOS --
-- Grupo A 
-- 1 Argentina
-- 2 Bolivia
-- 3 Brasil
-- 4 Chile

-- Grupo B
-- 5 Colombia
-- 6 Paraguay
-- 7 Peru
-- 8 Uruguay

-- ETAPAS --

-- 1 FASE_GRUPOS
-- 2 5TO_PUESTO
-- 3 SEMIFINAL
-- 4 3ER_PUESTO
-- 5 FINAL

-- FASE_GRUPOS (GRUPO A)
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 1, 2, 1, '2012-08-01',1);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 1, 3, 1, '2012-08-02',1);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 1, 4, 1, '2012-08-03',1);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 2, 3, 1, '2012-08-04',1);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 2, 4, 1, '2012-08-05',1);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 3, 4, 1, '2012-08-06',1);

-- FASE_GRUPOS (GRUPO B)
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 5, 6, 2, '2012-08-01',2);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 5, 7, 2, '2012-08-02',2);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 5, 8, 2, '2012-08-03',2);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 6, 7, 2, '2012-08-04',2);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 6, 8, 2, '2012-08-05',2);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 7, 8, 2, '2012-08-06',2);

-- 5TO_PUESTO
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(2, 4, 5, 2, '2012-08-07',2);

-- SEMIFINAL
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(3, 3, 8, 1, '2012-08-08',2);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(3, 1, 6, 2, '2012-08-08',3);

-- 3ER_PUESTO
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(4, 8, 6, 2, '2012-08-09',2);

-- FINAL
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(5, 3, 1, 2, '2012-08-10',1);



-- EQUIPOS
INSERT INTO equipo (nombreEquipo) values ('Atenas');
INSERT INTO equipo (nombreEquipo) values ('Peñarol');
INSERT INTO equipo (nombreEquipo) values ('Boca Juniors');
INSERT INTO equipo (nombreEquipo) values ('San Antonio');
INSERT INTO equipo (nombreEquipo) values ('Lakers');
INSERT INTO equipo (nombreEquipo) values ('Boston');

-- JUGADORES
-- ARGENTINOS
INSERT INTO jugador (idJugador, estaEnEquipo) values (101, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (102, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (103, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (104, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (105, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (106, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (107, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (108, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (109, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (110, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (111, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (112, 3);

-- BOLIVIA
INSERT INTO jugador (idJugador, estaEnEquipo) values (201, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (202, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (203, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (204, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (205, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (206, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (207, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (208, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (209, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (210, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (211, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (212, 3);

-- BRASIL
INSERT INTO jugador (idJugador, estaEnEquipo) values (301, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (302, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (303, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (304, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (305, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (306, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (307, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (308, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (309, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (310, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (311, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (312, 3);



-- PARTICIPACIONES
-- PRIMER PARTIDO (ARGENTINA - BOLIVIA)
-- GINOBILI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 101, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 102, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 103, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 104, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 105, 6, 1, 'PIVOT', 15, 1);

-- JASEN
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 106, 3, 1, 'BASE', 4, 0);

-- BOLIVIA idpartido = 1 de 21 en adelante
-- Tyson
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 201, 3, 1, 'ALERO', 21, 1);

-- LeBron
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 202, 3, 1, 'PIVOT', 1, 1);

-- Durant
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 203, 3, 1, 'BASE', 3, 1);

-- Paul
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 204, 3, 0, 'ALERO', 12, 1);

-- Anthony
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 205, 3, 1, 'PIVOT', 5, 1);

-- Bryan
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 206, 3, 0, 'BASE', 1, 0);

-- SEGUNDO PARTIDO (ARGENTINA - BRASIL)
-- GINOBILI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 101, 3, 1, 'ALERO', 22, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 102, 3, 1, 'PIVOT', 26, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 103, 3, 1, 'BASE', 2, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 104, 3, 1, 'ALERO', 1, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 105, 5, 1, 'PIVOT', 6, 1);

-- JASEN
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 106, 3, 1, 'BASE', 182, 0);

-- EEUU idpartido = 1 de 21 en adelante
-- Tyson
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 301, 3, 1, 'ALERO', 4, 1);

-- LeBron
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 302, 3, 1, 'PIVOT', 2, 1);

-- Durant
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 303, 3, 1, 'BASE', 18, 1);

-- Paul
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 304, 3, 1, 'ALERO', 4, 1);

-- Anthony
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 305, 3, 1, 'PIVOT', 5, 1);

-- Bryan
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 305, 3, 1, 'BASE', 0, 0);

-- haciendo update esTitular = 1 se puede testear el reporte

-- ARBITRO --
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('EnzoARG'     ,1); -- ARGENTINA
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('EvoBOL'      ,2); -- BOLIVIA
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('MouquinhoBRA',3); -- BRASIL
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('BermudezCHI' ,4); -- CHILE
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('BustilloCOL' ,5); -- COLOMBIA
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('CormenPAR'   ,6); -- PARAGUAY
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('GomezPER'    ,7); -- PERU
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('AtanezURU'   ,8); -- URUGUAY

-- ARBITRA --

-- Invalid
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('3','1'); -- Brasilero
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('2','2'); -- Boliviano
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('2','3'); -- Boliviano
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('4','4'); -- Chileno
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('1','5'); -- Argentino
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('1','6'); -- Argentino

-- SANCION --
INSERT INTO sancion (aplicaParticipacion, sancionadaPorArbitro, esDeTipo) values(1,3,1);

-- TANTEADOR --
-- Estos datos los carga un trigger cuando se inserta en el partido


-- Invalidas --
-- La cantidad de Integrantes no coincide con los existentes  
-- INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (20,'2012-08-25','B');

-- Solo grupo A o B están permitidos 
-- INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (0,'2012-08-26','C');


