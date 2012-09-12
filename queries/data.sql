
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
INSERT INTO pais (nombrePais) values ('Venezuela');

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
-- No va, esto ya lo hace un trigger cuando se inserta en la seleccion

-- SELECCION --
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-20','A', 1, 1, 1);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-21','B', 2, 2, 2);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-22','A', 3, 3, 3);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-23','B', 4, 4 ,1);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-24','A', 1, 5, 2);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-20','A', 1, 6, 1);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-20','A', 1, 7, 1);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-20','A', 1, 8, 1);

-- PARTIDOS -- 

INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values(1, 1, 7, 1, '2012-08-22',1);
INSERT INTO partido (juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, fecha, horario) values (2, 8, 1, 2, '2012-08-23', 5);
					
-- INTEGRANTE
-- SELECCION ARGENTINA ( 5 titulares 1 suplente)

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 1, 'Emanuel', 'Ginobili', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 2, 'Juan', 'Scola', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 3, 'Andres', 'Nocioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 4, 'Pablo', 'Prigioni', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 5, 'Carlos', 'Delfino', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 6, 'Hernan', 'Jasen', '1992-08-24', 'JUGADOR');

-- SELECCION EEUU ( 5 titulares 1 suplente)
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 7, 'Tyson', 'Chandler', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 8, 'LeBron', 'James', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 9, 'Durant', 'Kevin', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 10, 'Paul', 'Chris', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 11, 'Anthony', 'Carmelo', '1992-08-24', 'JUGADOR');

INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(8, 12, 'Bryant', 'Kobe', '1992-08-24', 'JUGADOR');

-- EQUIPOS

INSERT INTO equipo (nombreEquipo) values ('Atenas');
INSERT INTO equipo (nombreEquipo) values ('Peñarol');
INSERT INTO equipo (nombreEquipo) values ('Boca Juniors');
INSERT INTO equipo (nombreEquipo) values ('San Antonio');
INSERT INTO equipo (nombreEquipo) values ('Lakers');
INSERT INTO equipo (nombreEquipo) values ('Boston');

-- JUGADORES
-- LOS ARGENTINOS
INSERT INTO jugador (idJugador, estaEnEquipo) values (1, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (2, 1);
INSERT INTO jugador (idJugador, estaEnEquipo) values (3, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (4, 2);
INSERT INTO jugador (idJugador, estaEnEquipo) values (5, 3);
INSERT INTO jugador (idJugador, estaEnEquipo) values (6, 3);

-- LOS EEUU
INSERT INTO jugador (idJugador, estaEnEquipo) values (7, 4);
INSERT INTO jugador (idJugador, estaEnEquipo) values (8, 4);
INSERT INTO jugador (idJugador, estaEnEquipo) values (9, 5);
INSERT INTO jugador (idJugador, estaEnEquipo) values (10, 5);
INSERT INTO jugador (idJugador, estaEnEquipo) values (11, 6);
INSERT INTO jugador (idJugador, estaEnEquipo) values (12, 6);

-- PARTICIPACIONES
-- PRIMER PARTIDO idpartido = 1 de 15 en adelante
-- GINOBILI
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

-- JASEN
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 6, 3, 1, 'BASE', 4, 0);

-- EEUU idpartido = 1 de 21 en adelante
-- Tyson
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 7, 3, 1, 'ALERO', 21, 1);

-- LeBron
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 8, 3, 1, 'PIVOT', 1, 1);

-- Durant
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 9, 3, 1, 'BASE', 3, 1);

-- Paul
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 10, 3, 0, 'ALERO', 12, 1);

-- Anthony
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 11, 3, 1, 'PIVOT', 5, 1);

-- Bryan
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 12, 3, 0, 'BASE', 1, 0);

-- SEGUNDO PARTIDO idpartido = 1 de 15 en adelante
-- GINOBILI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 1, 3, 1, 'ALERO', 22, 1);

-- SCOLA
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 2, 3, 1, 'PIVOT', 26, 1);

-- NOCIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 3, 3, 1, 'BASE', 2, 1);

-- PRIGIONI
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 4, 3, 1, 'ALERO', 1, 1);

-- DELFINO
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 5, 5, 1, 'PIVOT', 6, 1);

-- JASEN
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 6, 3, 1, 'BASE', 182, 0);

-- EEUU idpartido = 1 de 21 en adelante
-- Tyson
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 7, 3, 1, 'ALERO', 4, 1);

-- LeBron
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 8, 3, 1, 'PIVOT', 2, 1);

-- Durant
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 9, 3, 1, 'BASE', 18, 1);

-- Paul
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 10, 3, 1, 'ALERO', 4, 1);

-- Anthony
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 11, 3, 1, 'PIVOT', 5, 1);

-- Bryan
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(2, 12, 3, 1, 'BASE', 0, 0);

-- haciendo update esTitular = 1 se puede testear el reporte

-- ARBITRO --
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('EnzoARG',1);
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('EvoBOL',2);
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('MouquinhoBRA',3);
INSERT INTO arbitro (nombreArbitro,pertenecePais) values ('BermudezCHI',4);

-- ARBITRA --

-- Invalid
-- INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('1','1'); -- Argentino
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('2','1'); -- Boliviano
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('3','2'); -- Brasilero
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('4','2'); -- Chileno

-- SANCION --
INSERT INTO sancion (aplicaParticipacion, sancionadaPorArbitro, esDeTipo) values(1,2,1);


-- Invalidas --
-- La cantidad de Integrantes no coincide con los existentes  
-- INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (20,'2012-08-25','B');

-- Solo grupo A o B están permitidos 
-- INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (0,'2012-08-26','C');


