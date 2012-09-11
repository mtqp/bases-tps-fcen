-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
-- select "Acá van las constraints de integrante" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_integrante $$

CREATE TRIGGER check_integrante
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
DELIMITER ;