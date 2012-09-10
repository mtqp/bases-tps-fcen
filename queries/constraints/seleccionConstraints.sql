-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
-- select "Acá van las constraints de seleccion" from DUAL;

-- seleccion --
-- SELECCION.grupo solo puede ser ‘A’ o ‘B’.
-- ALTER TABLE seleccion ADD CONSTRAINT chk_grupo CHECK (grupo='A' OR grupo='B'); -- Constraint puto no anda. 

DELIMITER $$

DROP TRIGGER IF EXISTS check_grupo_bi $$

CREATE TRIGGER check_grupo_bi
BEFORE INSERT ON seleccion
FOR EACH ROW BEGIN
  DECLARE maxPosicion INT;
  
  IF (NEW.grupo <> 'A' AND NEW.grupo <> 'B') THEN
	  CALL `Grupo debe ser A o B`;
  END IF;
  
  IF (NEW.cantIntegrantes <> 0) THEN
  	  CALL `La cantidad de integrantes difiere de los integrantes actuales`;
  END IF;
  
  INSERT INTO posicion values ();
  SET maxPosicion = (SELECT max(idPosicion) FROM posicion); 
  SET NEW.ubicaPosicion = @maxPosicion;
  
END$$

DROP TRIGGER IF EXISTS check_grupo_bu $$

CREATE TRIGGER check_grupo_bu
BEFORE UPDATE ON seleccion
FOR EACH ROW BEGIN
	
   DECLARE cantIntegrantes INT;
   SET cantIntegrantes = (SELECT count(*) FROM integrante I WHERE I.perteneceSeleccion = OLD.idSeleccion);
   -- INSERT INTO LOG (nombre, msg) VALUES ("check_grupo_bu", @cantIntegrantes);
   IF (NEW.cantIntegrantes <> cantIntegrantes) THEN
  	  CALL `La cantidad de integrantes difiere de los integrantes actuales`;
   END IF;
  
END$$


DELIMITER ;

