
delimiter &&

DROP PROCEDURE IF EXISTS sp_partido_cantidad_por_fase &&

CREATE PROCEDURE sp_partido_cantidad_por_fase (etapa INT)
BEGIN
    DECLARE etapaFaseSemi INT;
    DECLARE etapaFaseGrupo INT;
    DECLARE countPartidosMax INT;
    DECLARE countPartidosExistentes INT;

    SET etapaFaseGrupo  = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'FASE_GRUPOS');
    SET etapaFaseSemi   = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'SEMIFINAL');

    -- Si PARTIDO.juegaEnEtapa = ‘FASE_GRUPOS’’ ⇒ #PARTIDO <= 6
    -- Si PARTIDO.juegaEnEtapa = ‘5TO_PUESTO’ ⇒ #PARTIDO <= 1
    -- Si PARTIDO.juegaEnEtapa = ‘3ER_PUESTO’ ⇒ #PARTIDO <= 1
    -- Si PARTIDO.juegaEnEtapa = ‘SEMIFINAL’ ⇒ #PARTIDO <= 2
    -- Si PARTIDO.juegaEnEtapa = ‘FINAL’ ⇒ #PARTIDO <= 1
    IF (etapa = etapaFaseGrupo) THEN
        SET countPartidosMax = 6;
    ELSE
        IF (etapa = etapaFaseSemi) THEN
            SET countPartidosMax = 2;
        ELSE
            SET countPartidosMax = 1;
        END IF;
    END IF;
   
    SET countPartidosExistentes = (SELECT COUNT(1) FROM partido WHERE juegaEnEtapa = etapa);
    IF (@countPartidosExistentes = @countPartidosMax) THEN
        CALL `La cantidad de partidos para la fase supera el maximo esperado`;
    END IF;

END&&

delimiter ;
