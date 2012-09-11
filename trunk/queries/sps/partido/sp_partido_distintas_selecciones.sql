
delimiter &&

DROP PROCEDURE IF EXISTS sp_partido_distintas_selecciones &&

CREATE PROCEDURE sp_partido_distintas_selecciones (idSeleccion1 INT, idSeleccion2 INT)
BEGIN
    -- PARTIDO.equipoSeleccion1 <> PARTIDO.equipoSeleccion2
    IF (idSeleccion1 = idSeleccion2) THEN
        CALL logError('partido','distintas selecciones');
    	CALL `EquipoSeleccion1 debe ser distinto de equipoSeleccion2`;
    END IF;

END&&

delimiter ;
