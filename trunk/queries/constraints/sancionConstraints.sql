-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
select "Acá van las constraints de sancion" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_sancion_bi $$

CREATE TRIGGER check_sancion_bi
BEFORE INSERT ON sancion
FOR EACH ROW BEGIN

    CALL sp_sancion_arbitro_mismo_partido (NEW.sancionadaPorArbitro, NEW.aplicaParticipacion);
    CALL logOk('sancion insert', 'sancion insertada correctamente');

END$$

DROP TRIGGER IF EXISTS check_sancion_bu $$

CREATE TRIGGER check_sancion_bu
BEFORE UPDATE ON sancion
FOR EACH ROW BEGIN

    CALL logOk('sancion update', 'sancion updateada correctamente');

END$$

DELIMITER ;


