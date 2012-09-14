-- ACA VAN TODAS LAS CONSTRAINTS DE PARTIDO

SELECT "creando constraints de partido" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_partido_bi $$

CREATE TRIGGER check_partido_bi
BEFORE INSERT ON partido
FOR EACH ROW BEGIN

    CALL sp_partido_distintas_selecciones(NEW.equipoSeleccion1, NEW.equipoSeleccion2);

    CALL sp_valor_positivo (NEW.duracion, 'partido', 'duracion');

    CALL sp_valor_en_rango (NEW.horario, 0, 23, 'partido', 'horario');

    CALL sp_partido_mismo_equipos_misma_etapa (NEW.equipoSeleccion1, NEW.equipoSeleccion2, NEW.juegaEnEtapa);

    CALL sp_partido_cantidad_por_fase (NEW.juegaEnEtapa);

    CALL sp_partido_fase_anterior_completa (NEW.juegaEnEtapa); 

    CALL sp_partido_ordenados_por_fecha (NEW.juegaEnEtapa, NEW.fecha, NEW.horario);

    CALL sp_partido_mismo_grupo_fase_grupo (NEW.juegaEnEtapa, NEW.equipoSeleccion1, NEW.equipoSeleccion2);

    CALL sp_partido_mismo_horario (NEW.horario, NEW.fecha);

    CALL logOk('before insert partido', 'before insert partido exitoso');

END$$

DROP TRIGGER IF EXISTS check_partido_ai $$

CREATE TRIGGER check_partido_ai
AFTER INSERT ON partido
FOR EACH ROW BEGIN

	INSERT INTO tanteador VALUES (1,NEW.idPartido, 0,0);
    INSERT INTO tanteador VALUES (2,NEW.idPartido, 0,0);
    INSERT INTO tanteador VALUES (3,NEW.idPartido, 0,0);
    INSERT INTO tanteador VALUES (4,NEW.idPartido, 0,0);
    
    CALL logOk('after insert partido', 'after insert partido exitoso');

END$$

DROP TRIGGER IF EXISTS check_partido_bu $$

CREATE TRIGGER check_partido_bu
BEFORE UPDATE ON partido
FOR EACH ROW BEGIN

    CALL sp_partido_distintas_selecciones(NEW.equipoSeleccion1, NEW.equipoSeleccion2);

    CALL sp_valor_positivo (NEW.duracion, 'partido', 'duracion');

    CALL sp_valor_en_rango (NEW.horario, 0, 23, 'partido', 'horario');

    CALL sp_partido_mismo_equipos_misma_etapa (NEW.equipoSeleccion1, NEW.equipoSeleccion2, NEW.juegaEnEtapa);

    CALL sp_partido_cantidad_por_fase (NEW.juegaEnEtapa);

    CALL sp_partido_fase_anterior_completa (NEW.juegaEnEtapa);

    CALL sp_partido_ordenados_por_fecha (NEW.juegaEnEtapa, NEW.fecha, NEW.horario);

    IF(OLD.equipoSeleccion1 <> NEW.equipoSeleccion1 OR OLD.equipoSeleccion2 <> NEW.equipoSeleccion2) THEN
    	CALL sp_partido_mismo_grupo_fase_grupo (NEW.juegaEnEtapa, NEW.equipoSeleccion1, NEW.equipoSeleccion2);
	END IF;

    CALL sp_partido_mismo_horario (NEW.horario, NEW.fecha);
    
    CALL logOk('insert partido', 'insert partido exitoso');

END$$

DELIMITER ;



