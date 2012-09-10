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

-- SELECCION --

-- Validas --
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-20','A', 1, 1, 1);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-21','B', 2, 2, 2);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-22','A', 3, 3, 3);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-23','B', 4, 4 ,1);
INSERT INTO seleccion (cantIntegrantes, fechaArribo, grupo, hospedaHospedaje, representaPais, concentraEstadio) values (0,'2012-08-24','A', 1, 5, 2);

-- Invalidas --

-- La cantidad de Integrantes no coincide con los existentes  
-- INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (20,'2012-08-25','B');

-- Solo grupo A o B están permitidos 
-- INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (0,'2012-08-26','C');


