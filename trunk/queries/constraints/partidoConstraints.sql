-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
-- Select "Acá van las constraints de partido" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_partido $$

CREATE TRIGGER check_partido
BEFORE INSERT ON partido
FOR EACH ROW BEGIN
    DECLARE etapaId INT;
    DECLARE countSelecciones INT;

    -- PARTIDO.equipoSeleccion1 <> PARTIDO.equipoSeleccion2
    IF (NEW.equipoSeleccion1 = NEW.equipoSeleccion2) THEN
	CALL `EquipoSeleccion1 debe ser distinto de equipoSeleccion2`;
    END IF;

    -- La duración de los partidos tiene que ser > 0
    IF (NEW.duracion <= 0) THEN
		CALL `La duración debe ser > 0`;
    END IF;

    -- Si PARTIDO.juegaEnEtapa = ‘FASE_GRUPOS’’entonces 
       -- PARTIDO.equipoSeleccion1.grupo = PARTIDO.equipoSeleccion2.grupo
    
    SET etapaId = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'FASE_GRUPOS');
    
	IF (@etapaId = NEW.juegaEnEtapa) THEN
		IF EXISTS
			(SELECT COUNT(1), grupo
			    FROM seleccion
			    WHERE
			        idSeleccion IN (NEW.equipoSeleccion1, NEW.equipoSeleccion2)
			    GROUP BY grupo
		     HAVING COUNT(1) <> 2
			)
		THEN
		    CALL `Grupos de distintos grupos jugando en Fase de grupos`;
		END IF;
    END IF;

END$$
DELIMITER ;

