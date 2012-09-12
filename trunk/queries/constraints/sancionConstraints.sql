-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
--select "Acá van las constraints de sancion" from DUAL;


DELIMITER $$

DROP TRIGGER IF EXISTS check_sancion_bi $$

CREATE TRIGGER check_sancion_bi
BEFORE INSERT ON sancion
FOR EACH ROW BEGIN
    DECLARE partidoId INT;	
    -- ARBITRA.idArbitroArb = SANCION.sancionadaPorArbitro  AND ARBITRA.idPartidoArb =  SANCION.aplicaParticipacion.jugoPartido
    -- jugoPartido = idPartido
    SET partidoId = (SELECT jugoPartido FROM participacion WHERE idParticipacion = NEW.aplicaParticipacion);
   IF (NOT (NEW.sancionadaPorArbitro IN (SELECT COUNT(1), idArbitroArb FROM arbitra WHERE idPartidoArb = @jugoPartido))) THEN
 	CALL `El arbitro que sanciona debe estar asignado al partido`;
   END IF;
END$$

DROP TRIGGER IF EXISTS check_sancion_bu $$

CREATE TRIGGER check_sancion_bu
BEFORE UPDATE ON sancion
FOR EACH ROW BEGIN
    DECLARE partidoId INT;	
    -- ARBITRA.idArbitroArb = SANCION.sancionadaPorArbitro  AND ARBITRA.idPartidoArb =  SANCION.aplicaParticipacion.jugoPartido
    -- jugoPartido = idPartido
   SET partidoId = (SELECT jugoPartido FROM participacion WHERE idParticipacion = NEW.aplicaParticipacion);
    IF (NOT (NEW.sancionadaPorArbitro IN (SELECT COUNT(1), idArbitroArb FROM arbitra WHERE idPartidoArb = @jugoPartido))) THEN
	CALL `El arbitro que sanciona debe estar asignado al partido`;
    END IF;
END$$

DELIMITER ;


