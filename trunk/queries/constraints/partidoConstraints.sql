-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
--select "Acá van las constraints de partido" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_partido $$

CREATE TRIGGER check_partido
BEFORE INSERT ON partido
FOR EACH ROW BEGIN
    -- PARTIDO.equipoSeleccion1 <> PARTIDO.equipoSeleccion2
    IF (NEW.equipoSeleccion1 = NEW.equipoSeleccion2) THEN
	CALL `EquipoSeleccion1 debe ser distinto de equipoSeleccion2`;
    END IF;
    -- La duración de los partidos tiene que ser > 0
    IF (NEW.duracion <= 0) THEN
	CALL `La duración debe ser > 0`;
    END IF;
    -- Si PARTIDO.juegaEnEtapa = ‘FASE_GRUPOS’’entonces PARTIDO.equipoSeleccion1.grupo = PARTIDO.equipoSeleccion2.grupo
END$$
DELIMITER ;

