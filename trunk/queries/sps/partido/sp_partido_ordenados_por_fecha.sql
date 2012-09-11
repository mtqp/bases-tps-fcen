
delimiter &&

DROP PROCEDURE IF EXISTS sp_partido_ordenados_por_fecha &&

CREATE PROCEDURE sp_partido_ordenados_por_fecha (etapaSP INT, fechaSP DATE, horarioSP INT)
BEGIN
    DECLARE etapaFaseGrupo INT;
    DECLARE etapa5to INT;
    DECLARE etapaFaseSemi INT;
    DECLARE etapaFinal INT;
    DECLARE faseAnterior INT;
    DECLARE fechaFaseMax DATE;
    DECLARE horarioFaseMax INT;

    SET etapaFaseGrupo  = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'FASE_GRUPOS');
    SET etapa5to        = (SELECT idEtapa FROM etapa WHERE nombreEtapa = '5TO_PUESTO');
    SET etapaFaseSemi   = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'SEMIFINAL');
    SET etapaFinal      = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'FINAL');

    -- Las fechas de los partidos tienen que estar ordenado por la etapa (FASE_GRUPO < 5TO_PUESTO < SEMIFINAL < 3ER_PUESTO < FINAL)
    IF (etapaSP = etapa5to) THEN
        SET faseAnterior = etapaFaseGrupo;
    ELSE 
        IF (etapaSP = etapaFaseSemi) THEN
            SET faseAnterior = etapa5to;
        ELSE 
            IF(etapaSP = etapa3ro) THEN
                SET faseAnterior = etapaFaseSemi;
            ELSE 
                IF(etapaSP = etapaFinal) THEN
                    SET faseAnterior = etapa3ro;
                END IF;
            END IF;
        END IF;
    END IF;

    -- Chequea que la fase anterior no tenga fecha/horario posterior al que se va a insertar
    SET fechaFaseMax    = (SELECT MAX(fecha) FROM partido WHERE juegaEnEtapa = @faseAnterior);
    SET horarioFaseMax  = (SELECT MAX(horario) FROM partido WHERE fechaSP = @fechaFaseMax);

    IF EXISTS 
    (
        -- Dia posterior
        SELECT * 
        FROM partido 
        WHERE
            fechaSP < @fechaFaseMax
        UNION
        -- Igual dia, Hora posterior
        SELECT * 
        FROM partido
        WHERE
            horarioSP < @horarioFaseMax
    )
    THEN
        CALL `Existe un partido de fase anterior con fecha mayor`;
    END IF;
END&&

delimiter ;

