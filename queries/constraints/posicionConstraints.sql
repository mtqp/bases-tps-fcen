-- ACA VAN TODAS LAS CONSTRAINTS DE POSICION

select "creando constraints de posicion" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_posicion_bi $$

CREATE TRIGGER check_posicion_bi
BEFORE INSERT ON posicion
FOR EACH ROW BEGIN
    -- Cantidad de inserts <= 8
    IF ((SELECT COUNT(1) FROM posicion) >= 8) THEN
        CALL `La cantidad de posiciones maxima es 8`;
    END IF;

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
    
    CALL logOk('posicion insert', 'posicion insert exitoso');
END$$

DROP TRIGGER IF EXISTS check_posicion_bu $$

CREATE TRIGGER check_posicion_bu
BEFORE UPDATE ON posicion
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
    
    CALL logOk('posicion update', 'posicion update exitoso');
END$$

DELIMITER ;


