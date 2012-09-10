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

-- SELECCION --

-- Validas --
INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (0,'2012-08-20','A');
INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (0,'2012-08-21','B');
INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (0,'2012-08-22','A');
INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (0,'2012-08-23','B');
INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (0,'2012-08-24','A');

-- Invalidas --

-- No hay integrantes al insertar por primera vez la selección 
-- INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (20,'2012-08-25','B');

-- Solo grupo A o B están permitidos 
-- INSERT INTO seleccion (cantIntegrantes,fechaArribo,grupo) values (0,'2012-08-26','C');


