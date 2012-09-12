-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
select "Acá van las constraints de sancion" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_sancion_bi $$

CREATE TRIGGER check_sancion_bi
BEFORE INSERT ON sancion
FOR EACH ROW BEGIN
    -- ARBITRA.idArbitroArb = SANCION.sancionadaPorArbitro  AND ARBITRA.idPartidoArb =  SANCION.aplicaParticipacion.jugoPartido
    -- jugoPartido = idPartido
    
    IF NOT EXISTS 
    (
        SELECT * 
        FROM 
            arbitra
        WHERE
            idArbitroArb = NEW.sancionadaPorArbitro AND
            idPartidoArb IN
            (
                SELECT jugoPartido
                FROM 
                    participacion
                WHERE
                    idParticipacion = NEW.aplicaParticipacion
            )
    )   
    THEN 
        CALL `El arbitro que sanciona debe estar asignado al partido`;
    END IF;

    CALL logOk('sancion insert', 'sancion insertada correctamente');

END$$

DROP TRIGGER IF EXISTS check_sancion_bu $$

CREATE TRIGGER check_sancion_bu
BEFORE UPDATE ON sancion
FOR EACH ROW BEGIN

    CALL logOk('sancion update', 'sancion updateada correctamente');

END$$

DELIMITER ;


