-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
-- select "Acá van las constraints de seleccion" from DUAL;

-- seleccion --
-- SELECCION.grupo solo puede ser ‘A’ o ‘B’.
-- ALTER TABLE seleccion ADD CONSTRAINT chk_grupo CHECK (grupo='A' OR grupo='B'); -- Constraint puto no anda. 

DELIMITER $$

DROP TRIGGER IF EXISTS check_grupo $$

CREATE TRIGGER check_grupo
BEFORE INSERT ON seleccion
FOR EACH ROW BEGIN
  IF (NEW.grupo <> 'A' AND NEW.grupo <> 'B') THEN
	  CALL `Grupo debe ser A o B`;
  END IF;
END$$
DELIMITER ;


