
delimiter &&

DROP PROCEDURE IF EXISTS sp_seleccion_max_equipos_por_grupo &&

CREATE PROCEDURE sp_seleccion_max_equipos_por_grupo (grupoSP CHAR(1))
BEGIN
    -- SELECCION.grupo == “&” no puede repetirse más de 4 veces.
    IF ((SELECT COUNT(*) FROM seleccion WHERE grupo = grupoSP) = 4) THEN
      CALL `El grupo no puede repetirse mas de 4 veces en la seleccion`;
    END IF;
END&&

delimiter ;

