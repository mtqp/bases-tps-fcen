
delimiter &&

DROP PROCEDURE IF EXISTS sp_partido_mismo_grupo_fase_grupo &&

CREATE PROCEDURE sp_partido_mismo_grupo_fase_grupo (etapaSP INT, seleccion1SP INT, seleccion2SP INT)
BEGIN
    DECLARE etapaFaseGrupo INT;

    SET etapaFaseGrupo  = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'FASE_GRUPOS');

    -- Si PARTIDO.juegaEnEtapa = ‘FASE_GRUPOS’’entonces 
       -- PARTIDO.equipoSeleccion1.grupo = PARTIDO.equipoSeleccion2.grupo
    
	IF (etapaFaseGrupo = etapaSP) THEN
		IF EXISTS
			(SELECT COUNT(1), grupo
			    FROM seleccion
			    WHERE
			        idSeleccion IN (seleccion1SP, seleccion2SP)
			    GROUP BY grupo
		     HAVING COUNT(1) <> 2
			)
		THEN
		    CALL `Grupos de distintos grupos jugando en Fase de grupos`;
		END IF;
    END IF;
END&&

delimiter ;

