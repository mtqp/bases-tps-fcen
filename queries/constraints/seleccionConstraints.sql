-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION

select "[!!!MISSING CORRECT SP_SELECCION_FECHA_ARRIBO_INVALIDADA!!!!] creando constraints de seleccion" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_seleccion_bi $$

CREATE TRIGGER check_seleccion_bi
BEFORE INSERT ON seleccion
FOR EACH ROW BEGIN

    DECLARE maxPosicion INT;

    -- SELECCION.grupo solo puede ser ‘A’ o ‘B’. Revisión (+1) Martin
    IF (NEW.grupo <> 'A' AND NEW.grupo <> 'B') THEN
      CALL `Grupo debe ser A o B`;
    END IF;

    -- SELECCION.grupo == “&” no puede repetirse más de 4 veces.
    CALL sp_seleccion_max_equipos_por_grupo (NEW.grupo);

    -- #SELECCION.cantIntegrantes debe ser igual a la cantidad de integrantes relacionados. Revisión (+1) Martin
    IF (NEW.cantIntegrantes <> 0) THEN
      CALL `La cantidad de integrantes difiere de los integrantes actuales`;
    END IF;

    -- SELECCION.fechaArribo <= PARTIDO.fecha
--  CALL sp_seleccion_fecha_arribo_invalida (NEW.fechaArribo);
    
    -- LOG POSICION --
    INSERT INTO posicion values ();
    -- SET @maxPosicion = (SELECT max(idPosicion) FROM posicion); 
    SET NEW.ubicaPosicion = (SELECT max(idPosicion) FROM posicion);

    CALL logOk('insert seleccion', 'el insert de seleccion fue exitoso');

END$$

DROP TRIGGER IF EXISTS check_seleccion_bu $$

CREATE TRIGGER check_seleccion_bu
BEFORE UPDATE ON seleccion
FOR EACH ROW BEGIN

    -- #SELECCION.cantIntegrantes debe ser igual a la cantidad de integrantes relacionados. Revisión (+1) Martin	
    DECLARE cantIntegrantes INT;
    SET cantIntegrantes = (SELECT count(*) FROM integrante I WHERE I.perteneceSeleccion = OLD.idSeleccion);
    IF (NEW.cantIntegrantes <> cantIntegrantes) THEN
      CALL `La cantidad de integrantes difiere de los integrantes actuales`;
    END IF;
  
    -- SELECCION.grupo == “&” no puede repetirse más de 4 veces.
    IF(NEW.grupo <> OLD.grupo) THEN
        CALL sp_seleccion_max_equipos_por_grupo (NEW.grupo);
    END IF;

    -- SELECCION.fechaArribo <= PARTIDO.fecha
--  CALL sp_seleccion_fecha_arribo_invalida (NEW.fechaArribo);
  
    CALL logOk('update seleccion', 'el update de seleccion fue exitoso');
  
END$$


DELIMITER ;

