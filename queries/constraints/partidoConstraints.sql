-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
Select "Acá van las constraints de partido" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_partido $$

CREATE TRIGGER check_partido
BEFORE INSERT ON partido
FOR EACH ROW BEGIN
    DECLARE etapaFaseGrupo INT;
    DECLARE etapa5to INT;
    DECLARE etapaFaseSemi INT;
    DECLARE etapa3ero INT;
    DECLARE etapaFinal INT;
    DECLARE countSelecciones INT;
    DECLARE countPartidosMax INT;
    DECLARE countPartidosExistentes INT;
    DECLARE faseAnterior INT;
    DECLARE fechaFaseMax DATE;
    DECLARE horarioFaseMax INT;

    SET etapaFaseGrupo  = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'FASE_GRUPOS');
    SET etapa5to        = (SELECT idEtapa FROM etapa WHERE nombreEtapa = '5TO_PUESTO');
    SET etapaFaseSemi   = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'SEMIFINAL');
    SET etapa3ero       = (SELECT idEtapa FROM etapa WHERE nombreEtapa = '3ER_PUESTO');
    SET etapaFinal      = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'FINAL');

    CALL sp_partido_distintas_selecciones(NEW.equipoSeleccion1, NEW.equipoSeleccion2);

    CALL sp_valor_positivo (NEW.duracion, 'partido', 'duracion');

    CALL sp_valor_en_rango (NEW.horario, 0, 23, 'partido', 'horario');
    
    CALL sp_partido_mismo_equipos_misma_etapa (NEW.equipoSeleccion1, NEW.equipoSeleccion2, NEW.juegaEnEtapa);
    
    CALL sp_partido_cantidad_por_fase (NEW.juegaEnEtapa);

    CALL sp_partido_fase_anterior_completa (NEW.juegaEnEtapa); --  (SI ESTO NO VA ORDENADO CON EL DE ABAJO, SE ROMPE TODO)

    CALL sp_partido_ordenados_por_fecha (NEW.juegaEnEtapa, NEW.fecha, NEW.horario);

    CALL sp_partido_mismo_grupo_fase_grupo (NEW.juegaEnEtapa, NEW.equipoSeleccion1, NEW.equipoSeleccion2)

    -- No puede haber dos partidos en un mismo horario
    IF EXISTS
    (
        SELECT *
        FROM partido
        WHERE
            horario = NEW.horario and
            fecha = NEW.fecha
    )
    THEN
        CALL `Partido en mismo horario`;
    END IF;
    
    CALL logOk('insert', CONCAT('ok insert partido con id: ', 'dsp concatenar el id partido'));-- (NEW.idPartido AS CHAR)));
    

END$$
DELIMITER ;






