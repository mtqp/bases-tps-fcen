

delimiter &&

DROP PROCEDURE IF EXISTS sp_partido_mismo_equipos_misma_etapa &&

CREATE PROCEDURE sp_partido_mismo_equipos_misma_etapa (idSeleccion1 INT, idSeleccion2 INT, etapa INT)
BEGIN
    -- Dos equipos no pueden enfrentarse en la misma etapa dos veces.
    IF EXISTS 
    (
        SELECT * 
        FROM partido
        WHERE
            juegaEnEtapa = etapa AND
            equipoSeleccion1 IN (idSeleccion1, idSeleccion2) AND
            equipoSeleccion2 IN (idSeleccion1, idSeleccion2)
    )
    THEN
        CALL `Mismos equipos se enfrentan dos veces en la misma etapa`;
    END IF;

END&&

delimiter ;
