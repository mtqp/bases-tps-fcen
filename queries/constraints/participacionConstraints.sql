-- ACA VAN TODAS LAS CONSTRAINTS DE PARTICIPACION

select "[!!!!MISSING!!!!!] Acá van las constraints de participacion" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_participacion_bi $$

-- PARTICIPACION(idParticipacion, jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular)
-- FK = { (jugoPartido), (participaJugador) }

--    PARTICIPACION.jugoPartido.equipoSeleccion1 puede aparecer a lo sumo 5 veces con PARTICIPACION.esTitular = true
--    PARTICIPACION.jugoPartido.equipoSeleccion2 puede aparecer a lo sumo 5 veces con PARTICIPACION.esTitular = true
--    No puede haber dos PARTICIPACION.participaJugador tal que PARTICIPACION.esTitular = true y  PARTICIPACION.participaJugador.IdIntegrante.perteneceSeleccion  sean iguales y PARTICIPACION.posicion sean iguales.


Si PARTICIPACION.esTitular = false => PARTICIPACION.posicion is null  Donde 

CREATE TRIGGER check_participacion_bi
BEFORE INSERT ON participacion
FOR EACH ROW BEGIN

    CALL sp_participacion_posiciones_validas(NEW.posicion);

    CALL sp_valor_positivo(NEW.rebotes);
    
    CALL sp_valor_positivo(NEW.asistencias);
    
    CALL sp_valor_positivo(NEW.puntos);

    CALL logOk('insert participacion', 'update participacion exitoso');
END$$

DROP TRIGGER IF EXISTS check_participacion_bu $$

CREATE TRIGGER check_participacion_bu
BEFORE UPDATE ON participacion
FOR EACH ROW BEGIN
    CALL sp_participacion_posiciones_validas(NEW.posicion);
    
    CALL sp_valor_positivo(NEW.rebotes);
    
    CALL sp_valor_positivo(NEW.asistencias);
    
    CALL sp_valor_positivo(NEW.puntos);
    
    CALL logOk('update participacion', 'update participacion exitoso');
END$$

DELIMITER ;

