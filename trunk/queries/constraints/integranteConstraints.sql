-- ACA VAN TODAS LAS CONSTRAINTS DE INTEGRANTE

select "creando constraints de integrante" from DUAL;

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
    
    CALL logOk('insert integrante','insert integrante exitoso');
END$$

DROP TRIGGER IF EXISTS check_integrante_bu $$

CREATE TRIGGER check_integrante_bu
BEFORE UPDATE ON integrante
FOR EACH ROW BEGIN
    -- INTEGRANTE.tipoIntegrante IN { ‘Jugador’, ‘CuerpoTecnico’}
    IF (NEW.tipoIntegrante <> 'Jugador' AND NEW.tipoIntegrante <> 'CuerpoTecnico') THEN
        CALL `TipoIntegrante debe ser Jugador o CuerpoTecnico`;
    END IF;

    -- AÑO(SYSDATE) - AÑO(INTEGRANTE.fechaNacimiento) >= 18
    IF (YEAR(SYSDATE()) - YEAR(NEW.fechaNacimiento) < 18) THEN  
	    CALL `AÑO(SYSDATE) - AÑO(INTEGRANTE.fechaNacimiento) debe ser >= 18`;
    END IF;
    
    CALL logOk('insert integrante','insert integrante exitoso');
END$$

DELIMITER ;
