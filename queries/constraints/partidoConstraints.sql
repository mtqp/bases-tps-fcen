-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
Select "Acá van las constraints de partido" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_partido $$

CREATE TRIGGER check_partido
BEFORE INSERT ON partido
FOR EACH ROW BEGIN
    DECLARE etapaFaseGrupo INT;
    DECLARE etapa5to INT;
    DECLARE etapaFaseSemi INT;
    DECLARE etapa3ero INT;
    DECLARE etapaFinal INT;
    DECLARE countSelecciones INT;
    DECLARE countPartidosMax INT;
    DECLARE countPartidosExistentes INT;
    DECLARE faseAnterior INT;
    DECLARE fechaFaseMax DATE;
    DECLARE horarioFaseMax INT;

    SET etapaFaseGrupo  = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'FASE_GRUPOS');
    SET etapa5to        = (SELECT idEtapa FROM etapa WHERE nombreEtapa = '5TO_PUESTO');
    SET etapaFaseSemi   = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'SEMIFINAL');
    SET etapa3ero       = (SELECT idEtapa FROM etapa WHERE nombreEtapa = '3ER_PUESTO');
    SET etapaFinal      = (SELECT idEtapa FROM etapa WHERE nombreEtapa = 'FINAL');

    CALL sp_partido_distintas_selecciones(NEW.equipoSeleccion1, NEW.equipoSeleccion2);

    CALL sp_valor_positivo (NEW.duracion, 'partido', 'duracion');

    CALL sp_valor_en_rango (NEW.horario, 0, 23, 'partido', 'horario');
    
    -- Dos equipos no pueden enfrentarse en la misma etapa dos veces.
    IF EXISTS 
    (
        SELECT * 
        FROM partido
        WHERE
            juegaEnEtapa = NEW.juegaEnEtapa AND
            equipoSeleccion1 IN (NEW.equipoSeleccion1, NEW.equipoSeleccion2) AND
            equipoSeleccion2 IN (NEW.equipoSeleccion1, NEW.equipoSeleccion2)
    )
    THEN
        CALL `Mismos equipos se enfrentan dos veces en la misma etapa`;
    END IF;

    -- Si PARTIDO.juegaEnEtapa = ‘FASE_GRUPOS’’ ⇒ #PARTIDO <= 6
    -- Si PARTIDO.juegaEnEtapa = ‘5TO_PUESTO’ ⇒ #PARTIDO <= 1
    -- Si PARTIDO.juegaEnEtapa = ‘3ER_PUESTO’ ⇒ #PARTIDO <= 1
    -- Si PARTIDO.juegaEnEtapa = ‘SEMIFINAL’ ⇒ #PARTIDO <= 2
    -- Si PARTIDO.juegaEnEtapa = ‘FINAL’ ⇒ #PARTIDO <= 1
    IF (NEW.juegaEnEtapa = etapaFaseGrupo) THEN
        SET countPartidosMax = 6;
    ELSE
        IF (NEW.juegaEnEtapa = etapaFaseSemi) THEN
            SET countPartidosMax = 2;
        ELSE
            SET countPartidosMax = 1;
        END IF;
    END IF;
   
    SET countPartidosExistentes = (SELECT COUNT(1) FROM partido WHERE juegaEnEtapa = NEW.juegaEnEtapa);
    IF (@countPartidosExistentes = @countPartidosMax) THEN
        CALL `La cantidad de partidos para la fase supera el maximo esperado`;
    END IF;

   
    -- Al insertar un partido, esten todos los anteriores de fase (SI ESTO NO VA ORDENADO CON EL DE ABAJO, SE ROMPE TODO)
    IF NOT EXISTS
    (
        SELECT COUNT(1)
        FROM partido
        WHERE 
            juegaEnEtapa = NEW.juegaEnEtapa AND
            juegaEnEtapa <> etapaFaseGrupo
    ) 
    THEN 
        -- Voy a insertar el primer partido de esa fase
        -- Valido que existan todos los partidos anteriores
        IF (NEW.juegaEnEtapa = etapa5to) THEN
            SET faseAnterior = etapaFaseGrupo;
            SET countPartidosMax = 6;
        ELSE 
            IF (NEW.juegaEnEtapa = etapaFaseSemi) THEN
                SET faseAnterior = etapa5to;
                SET countPartidosMax = 1;
            ELSE 
                IF(NEW.juegaEnEtapa = etapa3ro) THEN
                    SET faseAnterior = etapaFaseSemi;
                    SET countPartidosMax = 2;
                ELSE 
                    IF(NEW.juegaEnEtapa = etapaFinal) THEN
                        SET faseAnterior = etapa3ro;
                        SET countPartidosMax = 1;
                    END IF;
                END IF;
            END IF;
        END IF;

        IF EXISTS 
        (
            SELECT COUNT(1), juegaEnEtapa
            FROM partido
            WHERE 
                juegaEnEtapa = faseAnterior
            HAVING
                COUNT(1) = @countPartidosMax
        )
        THEN
            CALL `La fase anterior no esta completa`;
        END IF;
      END IF;
           
    -- Las fechas de los partidos tienen que estar ordenado por la etapa (FASE_GRUPO < 5TO_PUESTO < SEMIFINAL < 3ER_PUESTO < FINAL)
    -- TODO REFACTORIZAR... SE UTILIZA ARRIBA TBM!!!!
    -- Consige la fase anterior
    IF (NEW.juegaEnEtapa = etapa5to) THEN
        SET faseAnterior = etapaFaseGrupo;
    ELSE 
        IF (NEW.juegaEnEtapa = etapaFaseSemi) THEN
            SET faseAnterior = etapa5to;
        ELSE 
            IF(NEW.juegaEnEtapa = etapa3ro) THEN
                SET faseAnterior = etapaFaseSemi;
            ELSE 
                IF(NEW.juegaEnEtapa = etapaFinal) THEN
                    SET faseAnterior = etapa3ro;
                END IF;
            END IF;
        END IF;
    END IF;

    -- Chequea que la fase anterior no tenga fecha/horario posterior al que se va a insertar
    SET fechaFaseMax    = (SELECT MAX(fecha) FROM partido WHERE juegaEnEtapa = @faseAnterior);
    SET horarioFaseMax  = (SELECT MAX(horario) FROM partido WHERE NEW.fecha = @fechaFaseMax);

    IF EXISTS 
    (
        -- Dia posterior
        SELECT * 
        FROM partido 
        WHERE
            NEW.fecha < @fechaFaseMax
        UNION
        -- Igual dia, Hora posterior
        SELECT * 
        FROM partido
        WHERE
            NEW.horario < @horarioFaseMax
    )
    THEN
        CALL `Existe un partido de fase anterior con fecha mayor`;
    END IF;

    -- Si PARTIDO.juegaEnEtapa = ‘FASE_GRUPOS’’entonces 
       -- PARTIDO.equipoSeleccion1.grupo = PARTIDO.equipoSeleccion2.grupo
    
	IF (@etapaFaseGrupo = NEW.juegaEnEtapa) THEN
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

    -- No puede haber dos partidos en un mismo horario
    IF EXISTS
    (
        SELECT *
        FROM partido
        WHERE
            horario = NEW.horario and
            fecha = NEW.fecha
    )
    THEN
        CALL `Partido en mismo horario`;
    END IF;
    
    

END$$
DELIMITER ;






