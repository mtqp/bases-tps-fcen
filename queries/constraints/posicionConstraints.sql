-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
-- select "Acá van las constraints de posicion" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_posicion $$

CREATE TRIGGER check_posicion
BEFORE INSERT ON posicion
FOR EACH ROW BEGIN
    -- POSICION.puntos >= 0
    IF (NEW.puntos < 0) THEN
	CALL `Puntos debe ser >= 0`;
    END IF;
    -- POSICION.partidosJugados >= 0
    IF (NEW.partidosJugados < 0) THEN
	CALL `PartidosJugados debe ser >= 0`;
    END IF;
    -- POSICION.partidosGanados >= 0
    IF (NEW.partidosGanados < 0) THEN
	CALL `PartidosGanados debe ser >= 0`;
    END IF;
    -- POSICION.partidosPerdidos >= 0
    IF (NEW.partidosPerdidos < 0) THEN
	CALL `PartidosPerdidos debe ser >= 0`;
    END IF;
    -- POSICION.tantosAFavor >= 0
    IF (NEW.tantosAFavor < 0) THEN
	CALL `TantosAFavor debe ser >= 0`;
    END IF;
    -- POSICION.tantosEnContra >= 0
    IF (NEW.tantosEnContra < 0) THEN
	CALL `TantosEnContra debe ser >= 0`;
    END IF;
    -- partidosJugados = partidosGanados + partidosPerdidos
    IF (NEW.partidosJugados <> NEW.partidosGanados + NEW.partidosPerdidos) THEN
	CALL `PartidosJugados = partidosGanados + partidosPerdidos`;
    END IF;
END$$
DELIMITER;

-- Si POSICION.puntos es el mayor de todos => POSICION.partidosGanados >=2
-- (minimo debe ganar dos partidos en fase de grupos para ser campéon)


