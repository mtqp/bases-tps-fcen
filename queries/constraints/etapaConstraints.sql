-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
--select "Acá van las constraints de etapa" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_etapa_bi $$

CREATE TRIGGER check_etapa_bi
BEFORE INSERT ON etapa
FOR EACH ROW BEGIN
    -- ETAPA.nombreEtapa debe ser o bien FASE_GRUPOS o 5TO_PUESTO, o 3ER_PUESTO o SEMIFINAL, o FINAL
    IF (NEW.nombreEtapa <> 'FASE_GRUPOS' AND NEW.nombreEtapa <> '5TO_PUESTO' AND NEW.nombreEtapa <> '3ER_PUESTO' AND NEW.nombreEtapa <> 'SEMIFINAL' AND NEW.nombreEtapa <> 'FINAL') THEN
	CALL `NombreEtapa es FASE_GRUPOS, 5TO/3ER_PUESTO, SEMIFINAL o FINAL`;
    END IF;
END$$

DROP TRIGGER IF EXISTS check_etapa_bu $$

CREATE TRIGGER check_etapa_bu
BEFORE UPDATE ON etapa
FOR EACH ROW BEGIN
    -- ETAPA.nombreEtapa debe ser o bien FASE_GRUPOS o 5TO_PUESTO, o 3ER_PUESTO o SEMIFINAL, o FINAL
    IF (NEW.nombreEtapa <> 'FASE_GRUPOS' AND NEW.nombreEtapa <> '5TO_PUESTO' AND NEW.nombreEtapa <> '3ER_PUESTO' AND NEW.nombreEtapa <> 'SEMIFINAL' AND NEW.nombreEtapa <> 'FINAL') THEN
	CALL `NombreEtapa es FASE_GRUPOS, 5TO/3ER_PUESTO, SEMIFINAL o FINAL`;
    END IF;
END$$

DELIMITER ;
