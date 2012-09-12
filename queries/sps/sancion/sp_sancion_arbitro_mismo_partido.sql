
delimiter &&

DROP PROCEDURE IF EXISTS sp_sancion_arbitro_mismo_partido &&

CREATE PROCEDURE sp_sancion_arbitro_mismo_partido (arbitroSP INT, participacionSP INT)
BEGIN
    -- ARBITRA.idArbitroArb = SANCION.sancionadaPorArbitro  AND ARBITRA.idPartidoArb =  SANCION.aplicaParticipacion.jugoPartido
    -- jugoPartido = idPartido
    
    IF NOT EXISTS 
    (
        SELECT * 
        FROM 
            arbitra
        WHERE
            idArbitroArb = arbitroSP AND
            idPartidoArb IN
            (
                SELECT jugoPartido
                FROM 
                    participacion
                WHERE
                    idParticipacion = participacionSP
            )
    )   
    THEN 
        CALL `El arbitro que sanciona debe estar asignado al partido`;
    END IF;

END&&

delimiter ;

