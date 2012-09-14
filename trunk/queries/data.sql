
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

-- BOLIVIA -- (12 jugadores, 1 cuerpo tecnico) 
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 201, 'Juanito', 'Gomez', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 202, 'Tronqui', 'Lola', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 203, 'Carpe', 'Diem', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 204, 'Pablo', 'Lolo', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 205, 'Samba', 'Yon', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 206, 'Nicolino', 'Noche', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 207, 'Kevin', 'Yojansen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 208, 'Hernan', 'Puertas', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 209, 'Esteban', 'Cado', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(2, 210, 'Dulces', 'Sueños', '1992-08-24', 'JUGADOR');

-- BRASIL --
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 301, 'Paulo', 'Mourinho', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 302, 'Fidel', 'Sacolo', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 303, 'Irio', 'Bousa', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 304, 'Trello', 'Marisato', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 305, 'Marpelo', 'DeSouza', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 306, 'Gorlin', 'Trochado', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 307, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 308, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 309, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(3, 310, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

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
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 1, 2, 1, '2012-08-01',1, 55);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 1, 3, 1, '2012-08-02',1, 55);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 1, 4, 1, '2012-08-03',1, 55);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 2, 3, 1, '2012-08-04',1, 55);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 2, 4, 1, '2012-08-05',1, 55);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 3, 4, 1, '2012-08-06',1, 55);

-- FASE_GRUPOS (GRUPO B)
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 5, 6, 2, '2012-08-01',2, 55);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 5, 7, 2, '2012-08-01',5, 55);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 5, 8, 2, '2012-08-03',2, 55);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 6, 7, 2, '2012-08-04',2, 55);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 6, 8, 2, '2012-08-05',2, 55);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(1, 7, 8, 2, '2012-08-06',2, 55);

-- 5TO_PUESTO
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(2, 4, 5, 2, '2012-08-07',2, 55);

-- SEMIFINAL
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(3, 3, 8, 1, '2012-08-08',2, 55);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(3, 1, 6, 2, '2012-08-08',3, 55);

-- 3ER_PUESTO
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(4, 8, 6, 2, '2012-08-09',2, 55);

-- FINAL
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario, duracion) values(5, 3, 1, 2, '2012-08-10',1, 55);


-- RESULTADOS
-- GRUPO A
UPDATE tanteador set scoreEquip1 = 100, scoreEquip2 = 1 where nrocuarto = 4 and idPartido = 1;
UPDATE tanteador set scoreEquip1 = 100, scoreEquip2 = 3 where nrocuarto = 4 and idPartido = 2;
UPDATE tanteador set scoreEquip1 = 100, scoreEquip2 = 0 where nrocuarto = 4 and idPartido = 3;
UPDATE tanteador set scoreEquip1 = 0, scoreEquip2 = 2 where nrocuarto = 4 and idPartido = 4;
UPDATE tanteador set scoreEquip1 = 1, scoreEquip2 = 2 where nrocuarto = 4 and idPartido = 5;
UPDATE tanteador set scoreEquip1 = 4, scoreEquip2 = 2 where nrocuarto = 4 and idPartido = 6;

-- GRUPO B
UPDATE tanteador set scoreEquip1 = 1, scoreEquip2 = 2 where nrocuarto = 4 and idPartido = 7;
UPDATE tanteador set scoreEquip1 = 2, scoreEquip2 = 1 where nrocuarto = 4 and idPartido = 8;
UPDATE tanteador set scoreEquip1 = 2, scoreEquip2 = 3 where nrocuarto = 4 and idPartido = 9;
UPDATE tanteador set scoreEquip1 = 4, scoreEquip2 = 0 where nrocuarto = 4 and idPartido = 10;
UPDATE tanteador set scoreEquip1 = 1, scoreEquip2 = 0 where nrocuarto = 4 and idPartido = 11;
UPDATE tanteador set scoreEquip1 = 0, scoreEquip2 = 2 where nrocuarto = 4 and idPartido = 12;

-- 5TO_PUESTO
UPDATE tanteador set scoreEquip1 = 0, scoreEquip2 = 1 where nrocuarto = 4 and idPartido = 13;

-- SEMIFINALES
UPDATE tanteador set scoreEquip1 = 2, scoreEquip2 = 1 where nrocuarto = 4 and idPartido = 14;
UPDATE tanteador set scoreEquip1 = 3, scoreEquip2 = 2 where nrocuarto = 4 and idPartido = 15;

-- 3ER_PUESTO
UPDATE tanteador set scoreEquip1 = 1, scoreEquip2 = 0 where nrocuarto = 4 and idPartido = 16;

-- FINAL
UPDATE tanteador set scoreEquip1 = 2, scoreEquip2 = 1 where nrocuarto = 4 and idPartido = 17;

-- EQUIPOS
INSERT INTO equipo (nombreEquipo) values ('Atenas');
INSERT INTO equipo (nombreEquipo) values ('Peñarol');
INSERT INTO equipo (nombreEquipo) values ('Boca Juniors');
INSERT INTO equipo (nombreEquipo) values ('San Antonio');
INSERT INTO equipo (nombreEquipo) values ('Lakers');
INSERT INTO equipo (nombreEquipo) values ('Boston');

-- PAIS
INSERT INTO pais (nombrePais) values ('Argentina');
INSERT INTO pais (nombrePais) values ('Bolivia');
INSERT INTO pais (nombrePais) values ('Brasil');
INSERT INTO pais (nombrePais) values ('Chile');
INSERT INTO pais (nombrePais) values ('Colombia');
INSERT INTO pais (nombrePais) values ('Paraguay');
INSERT INTO pais (nombrePais) values ('Peru');
INSERT INTO pais (nombrePais) values ('Uruguay');

-- JUGADORES

-- ARGENTINA
INSERT INTO jugador (idJugador, estaEnEquipo) values (1, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (2, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (3, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (4, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (5, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (6, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (7, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (8, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (9, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (10, 3);

-- BOLIVIA
INSERT INTO jugador (idJugador, estaEnEquipo) values (11, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (12, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (13, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (14, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (15, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (16, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (17, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (18, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (19, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (20, 3);

-- BRASIL
INSERT INTO jugador (idJugador, estaEnEquipo) values (21, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (22, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (23, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (24, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (25, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (26, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (27, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (28, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (29, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (30, 3);

-- CHILE
INSERT INTO jugador (idJugador, estaEnEquipo) values (31, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (32, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (33, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (34, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (35, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (36, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (37, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (38, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (39, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (40, 2);

-- COLOMBIA
INSERT INTO jugador (idJugador, estaEnEquipo) values (41, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (42, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (43, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (44, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (45, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (46, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (47, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (48, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (49, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (50, 1);

-- PARAGUAY
INSERT INTO jugador (idJugador, estaEnEquipo) values (51, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (52, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (53, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (54, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (55, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (56, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (57, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (58, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (59, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (60, 3);

-- PERU
INSERT INTO jugador (idJugador, estaEnEquipo) values (61, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (62, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (63, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (64, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (65, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (66, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (67, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (68, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (69, 3);

-- URUGUAY
INSERT INTO jugador (idJugador, estaEnEquipo) values (70, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (71, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (72, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (73, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (74, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (75, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (76, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (77, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (78, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (79, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (80, 3);

-- PARTICIPACIONES
-- PRIMER PARTIDO A (ARGENTINA - BOLIVIA)
-- ARGENTINA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 1, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 2, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 3, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 4, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 5, 6, 1, 'PIVOT', 15, 1);

-- BOLIVIA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 11, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 12, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 13, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 14, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 15, 6, 1, 'PIVOT', 15, 1);


-- SEGUNDO PARTIDO A (ARGENTINA - BRASIL)
-- ARGENTINA
-- GINOBILI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 6, 3, 1, 'ALERO', 22, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 7, 3, 1, 'PIVOT', 26, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 8, 3, 1, 'BASE', 2, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 9, 3, 1, 'ALERO', 1, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 10, 5, 1, 'PIVOT', 6, 1);

-- JASEN
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 5, 3, 1, 'BASE', 182, 0);

-- BRASIL
-- Tyson
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 21, 3, 1, 'ALERO', 4, 1);

-- LeBron
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 22, 3, 1, 'PIVOT', 2, 1);

-- Durant
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 23, 3, 1, 'BASE', 18, 1);

-- Paul
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 24, 3, 1, 'ALERO', 4, 1);

-- Anthony
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 25, 3, 1, 'PIVOT', 5, 1);

-- TERCER PARTIDO A (ARGENTINA - CHILE)
-- ARGENTINA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(3, 1, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(3, 2, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(3, 3, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(3, 4, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(3, 5, 6, 1, 'PIVOT', 15, 1);

-- CHILE
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(3, 31, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(3, 32, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(3, 33, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(3, 34, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(3, 35, 6, 1, 'PIVOT', 15, 1);

-- CUARTO PARTIDO A (BOLIVIA - BRASIL)
-- BOLIVIA 
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(4, 11, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(4, 12, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(4, 13, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(4, 14, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(4, 15, 6, 1, 'PIVOT', 15, 1);

-- BRASIL
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(4, 21, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(4, 22, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(4, 23, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(4, 24, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(4, 25, 6, 1, 'PIVOT', 15, 1);

-- QUINTO PARTIDO A (BOLIVIA - CHILE)
-- BOLIVIA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(5, 11, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(5, 12, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(5, 13, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(5, 14, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(5, 15, 6, 1, 'PIVOT', 15, 1);

-- CHILE
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(5, 36, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(5, 37, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(5, 38, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(5, 39, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(5, 40, 6, 1, 'PIVOT', 15, 1);

-- SEXTO PARTIDO A (BRASIL - CHILE)
-- BRASIL
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(6, 21, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(6, 22, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(6, 23, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(6, 24, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(6, 25, 6, 1, 'PIVOT', 15, 1);

-- CHILE --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(6, 31, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(6, 32, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(6, 33, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(6, 34, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(6, 35, 6, 1, 'PIVOT', 15, 1);

-- PRIMER PARTIDO B (COLOMBIA - PARAGUAY)
-- COLOMBIA --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(7, 41, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(7, 42, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(7, 43, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(7, 44, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(7, 45, 6, 1, 'PIVOT', 15, 1);

-- PARAGUAY --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(7, 51, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(7, 52, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(7, 53, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(7, 54, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(7, 55, 6, 1, 'PIVOT', 15, 1);

-- SEGUNDO PARTIDO B (COLOMBIA - PERU)
-- COLOMBIA --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(8, 41, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(8, 42, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(8, 43, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(8, 44, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(8, 45, 6, 1, 'PIVOT', 15, 1);

-- PERU --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(8, 61, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(8, 62, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(8, 63, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(8, 64, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(8, 65, 6, 1, 'PIVOT', 15, 1);

-- TERECER PARTIDO B (COLOMBIA - URUGUAY)
-- COLOMBIA --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(9, 41, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(9, 42, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(9, 43, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(9, 44, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(9, 45, 6, 1, 'PIVOT', 15, 1);

-- URUGUAY --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(9, 71, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(9, 72, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(9, 73, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(9, 74, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(9, 75, 6, 1, 'PIVOT', 15, 1);


-- CUARTO PARTIDO B (PARAGUAY - PERU)
-- PARAGUAY --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(10, 51, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(10, 52, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(10, 53, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(10, 54, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(10, 55, 6, 1, 'PIVOT', 15, 1);

-- PERU --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(10, 61, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(10, 62, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(10, 63, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(10, 64, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(10, 65, 6, 1, 'PIVOT', 15, 1);

-- QUINTO PARTIDO B (PARAGUAY - URUGUAY)
-- PARAGUAY --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(11, 51, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(11, 52, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(11, 53, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(11, 54, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(11, 55, 6, 1, 'PIVOT', 15, 1);

-- URUGUAY --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(11, 71, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(11, 72, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(11, 73, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(11, 74, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(11, 75, 6, 1, 'PIVOT', 15, 1);

-- SEXTO PARTIDO B (PERU - URUGUAY)
-- PERU --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(12, 61, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(12, 62, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(12, 63, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(12, 64, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(12, 65, 6, 1, 'PIVOT', 15, 1);

-- URUGUAY --
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(12, 71, 4, 1, 'ALERO', 24, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(12, 72, 8, 1, 'PIVOT', 22, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(12, 73, 3, 1, 'BASE', 17, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(12, 74, 3, 1, 'ALERO', 13, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(12, 75, 6, 1, 'PIVOT', 15, 1);


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
-- INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('4','1'); -- Brasilero
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('7','2'); -- Boliviano
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('7','3'); -- Boliviano
-- INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('7','4'); -- Chileno
-- INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('1','5'); -- Argentino
-- INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('1','6'); -- Argentino
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values (8,5); -- URUGUAYO
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values (8,6); -- URUGUAYO

INSERT INTO arbitra (idArbitroArb,idPartidoArb) values(1,8); -- Argentino (se pisa fecha con partido 7)


-- SANCION --
INSERT INTO sancion (aplicaParticipacion, sancionadaPorArbitro, esDeTipo) values(1,4,1);

-- TANTEADOR --
-- Estos datos los carga un trigger cuando se inserta en el partido


-- Invalidas --
-- La cantidad de Integrantes no coincide con los existentes  
-- INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (20,'2012-08-25','B');

-- Solo grupo A o B están permitidos 
-- INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (0,'2012-08-26','C');


