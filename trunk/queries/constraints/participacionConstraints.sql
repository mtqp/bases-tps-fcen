-- ACA VAN TODAS LAS CONSTRAINTS DE PARTICIPACION

select "Acá van las constraints de participacion" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_participacion_bi $$

CREATE TRIGGER check_participacion_bi
BEFORE INSERT ON participacion
FOR EACH ROW BEGIN

    CALL sp_participacion_posiciones_validas(NEW.posicion);

    CALL sp_valor_positivo(NEW.rebotes, 'participacion', 'rebotes');
    
    CALL sp_valor_positivo(NEW.asistencias, 'participacion', 'asistencias');
    
    CALL sp_valor_positivo(NEW.puntos, 'participacion', 'puntos');

    CALL logOk('insert participacion', 'update participacion exitoso');
END$$

DROP TRIGGER IF EXISTS check_participacion_bu $$

CREATE TRIGGER check_participacion_bu
BEFORE UPDATE ON participacion
FOR EACH ROW BEGIN
    CALL sp_participacion_posiciones_validas(NEW.posicion);
    
    CALL sp_valor_positivo(NEW.rebotes, 'participacion', 'rebotes');
    
    CALL sp_valor_positivo(NEW.asistencias, 'participacion', 'asistencias');
    
    CALL sp_valor_positivo(NEW.puntos, 'participacion', 'puntos');
    
    CALL logOk('update participacion', 'update participacion exitoso');
END$$

DELIMITER ;

