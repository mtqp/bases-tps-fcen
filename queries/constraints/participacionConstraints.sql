-- ACA VAN TODAS LAS CONSTRAINTS DE PARTICIPACION

select "[!!!!MISSING!!!!!] Acá van las constraints de participacion" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_participacion_bi $$

-- PARTICIPACION(idParticipacion, jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular)
-- FK = { (jugoPartido), (participaJugador) }

CREATE TRIGGER check_participacion_bi
BEFORE INSERT ON participacion
FOR EACH ROW BEGIN

    CALL sp_participacion_posiciones_validas(NEW.posicion);

    CALL logOk('insert participacion', 'update participacion exitoso');
END$$

DROP TRIGGER IF EXISTS check_participacion_bu $$

CREATE TRIGGER check_participacion_bu
BEFORE UPDATE ON participacion
FOR EACH ROW BEGIN
    CALL sp_participacion_posiciones_validas(NEW.posicion);
--  -- PARTICIPACION.posicion puede ser o bien BASE o ESCOLTA o ALERO o ALA-PIVOT o PIVOT o nulo.    
--  IF 
--  (   
--      NEW.posicion <> 'BASE'      AND 
--      NEW.posicion <> 'ESCOLTA'   AND 
--      NEW.posicion <> 'ALERO'     AND 
--      NEW.posicion <> 'ALA-PIVOT' AND 
--      NEW.posicion <> 'PIVOT'     AND
--      NEW.posicion IS NOT NULL
--  ) THEN
--     CALL `Posicion es BASE o ESCOLTA o ALERO o ALA-PIVOT o PIVOT o nulo`;
--  END IF;
    
    
    CALL logOk('update participacion', 'update participacion exitoso');
END$$

DELIMITER ;

