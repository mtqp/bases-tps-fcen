
delimiter &&

DROP PROCEDURE IF EXISTS sp_partido_mismo_horario &&

CREATE PROCEDURE sp_partido_mismo_horario (horarioSP INT, fechaSP DATE)
BEGIN
    -- No puede haber dos partidos en un mismo horario
    IF EXISTS
    (
        SELECT *
        FROM partido
        WHERE
            horario = horarioSP and
            fecha = fechaSP
    )
    THEN
        CALL `Partido en mismo horario`;
    END IF;

END&&

delimiter ;

