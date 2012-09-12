
delimiter &&

DROP PROCEDURE IF EXISTS sp_participacion_posiciones_validas &&

CREATE PROCEDURE sp_participacion_posiciones_validas (posicionSP VARCHAR(50))
BEGIN
    -- PARTICIPACION.posicion puede ser o bien BASE o ESCOLTA o ALERO o ALA-PIVOT o PIVOT o nulo.    
    IF 
    (   
        posicionSP <> 'BASE'      AND 
        posicionSP <> 'ESCOLTA'   AND 
        posicionSP <> 'ALERO'     AND 
        posicionSP <> 'ALA-PIVOT' AND 
        posicionSP <> 'PIVOT'     AND
        posicionSP IS NOT NULL
    ) THEN
	    CALL `Posicion es BASE o ESCOLTA o ALERO o ALA-PIVOT o PIVOT o nulo`;
    END IF;

END&&

delimiter ;

