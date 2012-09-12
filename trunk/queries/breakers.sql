
-- Las sentencias de la pesada del SQL, que vienen a romper todo con palos y datos invalidos.

-- PARTICIPACION --
-- Solo una participacion por jugador por partido
INSERT INTO participacion (jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular) values
(1, 1, 4, 1, 'ALERO', 24, 1);

-- ETAPA --
-- Solo etapas predefinidas
INSERT INTO etapa (nombreEtapa) values ('NUEVA_FASE');

-- No etapas repetidas 
INSERT INTO etapa (nombreEtapa) values ('FASE_GRUPOS');

-- POSICION -- 
-- FAIL no mas de 8  posiciones
INSERT INTO posicion values ();

-- POSICION.puntos >= 0
UPDATE posicion SET puntos = -1;

-- POSICION.partidosJugados >= 0
UPDATE posicion SET partidosJugados = -1;

-- POSICION.partidosGanados >= 0
UPDATE posicion SET partidosGanados = -1;

-- POSICION.partidosPerdidos >= 0
UPDATE posicion SET partidosPerdidos = -1;

-- POSICION.tantosAFavor >= 0
UPDATE posicion SET tantosAFavor = -1;

-- POSICION.tantosEnContra >= 0
UPDATE posicion SET tantosEnContra = -1;

-- partidosJugados = partidosGanados + partidosPerdidos
UPDATE posicion SET partidosJugados = 100;

-- sancion emitida por un arbitro que no conduce el partido
INSERT INTO sancion (aplicaParticipacion, sancionadaPorArbitro, esDeTipo) values(1,3,1);

-- INTEGRANTE --
-- FAIL por tipoIntegrante
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 567, 'Pampita', 'Ardohain', '1984-08-24', 'CONEJITA');

-- FAIL por fechaNacimiento
INSERT INTO integrante (perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, fechaNacimiento, tipoIntegrante) values
(1, 567, 'Chavo', 'DelOcho', '2000-08-24', 'JUGADOR');

-- ARBITRA ----
-- FAIL por Arbitro con misma nacionalidad que algun equipo que dirige. 
INSERT INTO arbitra (idArbitroArb,idPartidoArb) values ('1','1'); -- Argentino

-- PARTICIPACION.posicion puede ser o bien BASE o ESCOLTA o ALERO o ALA-PIVOT o PIVOT o nulo.    
UPDATE participacion SET posicion='lalalala' WHERE idParticipacion = 1;


