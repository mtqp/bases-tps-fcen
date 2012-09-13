
delimiter &&

DROP PROCEDURE IF EXISTS sp_partido_fase_anterior_completa &&

CREATE PROCEDURE sp_partido_fase_anterior_completa (etapa INT)
BEGIN
    DECLARE etapaFaseGrupo INT;
    DECLARE etapa5to INT;
    DECLARE etapaFaseSemi INT;
    DECLARE etapa3ero INT;
    DECLARE etapaFinal INT;
    DECLARE countPartidosMax INT;
    DECLARE faseAnterior INT;

    SET etapaFaseGrupo  = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'FASE_GRUPOS');
    SET etapa5to        = (SELECT idEtapa FROM etapa WHERE nombreEtapa = '5TO_PUESTO');
    SET etapaFaseSemi   = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'SEMIFINAL');
    SET etapa3ero       = (SELECT idEtapa FROM etapa WHERE nombreEtapa = '3ER_PUESTO');
    SET etapaFinal      = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'FINAL');


    -- Al insertar un partido, esten todos los anteriores de fase
    IF NOT EXISTS
    (
        SELECT COUNT(1)
        FROM partido
        WHERE 
            juegaEnEtapa = etapa AND
            juegaEnEtapa <> etapaFaseGrupo
    ) 
    THEN 
        -- Voy a insertar el primer partido de esa fase
        -- Valido que existan todos los partidos anteriores
        IF (etapa = etapa5to) THEN
            SET faseAnterior = etapaFaseGrupo;
            SET countPartidosMax = 6;
        ELSE 
            IF (etapa = etapaFaseSemi) THEN
                SET faseAnterior = etapa5to;
                SET countPartidosMax = 1;
            ELSE 
                IF(etapa = etapa3ero) THEN
                    SET faseAnterior = etapaFaseSemi;
                    SET countPartidosMax = 2;
                ELSE 
                    IF(etapa = etapaFinal) THEN
                        SET faseAnterior = etapa3ero;
                        SET countPartidosMax = 1;
                    END IF;
                END IF;
            END IF;
        END IF;

        IF EXISTS 
        (
            SELECT COUNT(1), juegaEnEtapa
            FROM partido
            WHERE 
                juegaEnEtapa = faseAnterior
            HAVING
                COUNT(1) = countPartidosMax
        )
        THEN
            CALL `La fase anterior no esta completa`;
        END IF;
      END IF;
           
END&&

delimiter ;

