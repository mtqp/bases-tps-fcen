-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
-- select "Acá van las constraints de integrante" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_integrante_bi $$

CREATE TRIGGER check_integrante_bi
BEFORE INSERT ON integrante
FOR EACH ROW BEGIN
    -- INTEGRANTE.tipoIntegrante IN { ‘Jugador’, ‘CuerpoTecnico’}
    IF (NEW.tipoIntegrante <> 'Jugador' AND NEW.tipoIntegrante <> 'CuerpoTecnico') THEN
        CALL `TipoIntegrante debe ser Jugador o CuerpoTecnico`;
    END IF;
    -- AÑO(SYSDATE) - AÑO(INTEGRANTE.fechaNacimiento) >= 18
    IF (YEAR(SYSDATE()) - YEAR(NEW.fechaNacimiento) < 18) THEN  
	CALL `AÑO(SYSDATE) - AÑO(INTEGRANTE.fechaNacimiento) debe ser >= 18`;
    END IF;
END$$

DROP TRIGGER IF EXISTS check_integrante_ai $$

CREATE TRIGGER check_integrante_ai
AFTER INSERT ON integrante
FOR EACH ROW BEGIN
    -- Por si los jugadores se insertan automaticamente 
	-- IF (NEW.tipoIntegrante = 'JUGADOR') THEN
    --    INSERT INTO jugador VALUES (NEW.idIntegrante, null);
    -- END IF;
    
    -- IF (NEW.tipoIntegrante = 'CUERPOTECNICO') THEN
    --    INSERT INTO cuerpotecnico VALUES (NEW.idIntegrante, null);
    -- END IF;
END$$

DELIMITER ;