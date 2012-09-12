
delimiter &&

DROP PROCEDURE IF EXISTS sp_seleccion_fecha_arribo_invalida &&

CREATE PROCEDURE sp_seleccion_fecha_arribo_invalida (fechaSP DATE)
BEGIN
    -- SELECCION.fechaArribo < PARTIDO.fecha
    IF EXISTS
    (
        SELECT * 
        FROM
            partido
        WHERE
            fecha < fechaSP
    )
    THEN
        CALL `Hay partidos con fecha anterior a llegada de seleccion`;
    END IF;
END&&

delimiter ;

